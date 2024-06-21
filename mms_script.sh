#!/usr/bin/env bash

mms_repo () {
    if ! [ -r "$MMS_HOME/.git" ]; then
        echo "Cloning mms"
        if ! git clone git@github.com:10gen/mms "$MMS_HOME"; then
            echo "If you got an error about not having the correct access rights,"
            echo "make sure you requested access to 10gen Cloud in MANA"
            echo "(check for an email from your lead when you started)"
            exit 1
        fi
    else
        echo "You already have a clone of mms so no git operations ran"
    fi
}


awsscratch () {
    # awscli
    scratch_account_id="358363220050"
    conf_local_secure="$MMS_HOME/server/conf/conf-local-secure.properties"
    conf_hosted_secure="$MMS_HOME/server/conf/conf-hosted-secure.properties"
    service_local_secure="$MMS_HOME/server/src/main/com/xgen/cloud/services/resource/config/service-local-secure.yaml"
    access_key=""
    secret_key=""
    keys_from_conf_local_secure=""
    cat $conf_local_secure
    if [ -r "$conf_local_secure" ]; then
        echo "Reading keys from existing conf-local-secure.properties"
        while read -r line; do
            key="$(cut -f 1 -d = <<< $line)"
            value="$(cut -f 2 -d = <<< $line)"
            echo $key
            echo $value
            if [ "${key}" = "local.aws.accessKey" ]; then
                access_key="${value}"
            elif [ "${key}" = "local.aws.secretKey" ]; then
                secret_key="${value}"
            fi
        done < "$conf_local_secure"
        echo $access_key
        echo $secret_key
        keys_from_conf_local_secure="1"
    elif [ -n "${ONBOARDING_AWS_ACCESS_KEY:-}" ]; then
        # Automated testing
        access_key="$ONBOARDING_AWS_ACCESS_KEY"
        secret_key="$ONBOARDING_AWS_SECRET_KEY"
    else
        echo "Access key ID ="
        echo "  aws configure get aws_access_key_id --profile mms-scratch"
        echo "Your lead sent you an email containing AWS API keys. Please paste them here."
        echo -n "Access key ID: "
        read -r access_key
        echo "Secret key ="
        echo "  aws configure get aws_secret_access_key --profile mms-scratch"
        echo -n "Secret key: "
        read -rs secret_key
        echo ""
        echo "One more thing for AWS. In your lead's email you were given a temporary password to log in to the console."
        echo "Please go to https://mms-scratch.signin.aws.amazon.com/"
        echo "At the top right, click 'My Account', then 'AWS Management Console'."
        echo "Log in, and change your password"
        echo ""
        echo "To prove you've done this, after signing in, go to https://console.aws.amazon.com/iam/home?#/users"
        echo "Find yourself in the list and click on the name"
        echo "User ARN ="
        echo "  aws iam get-user --output json --query 'User.Arn'"
        echo -n "Copy and paste your User ARN here: "
        read -r user_arn
        if ! echo "$user_arn" | grep -q "$scratch_account_id"; then
            echo "That's not correct. Please re-run the script and try again."
            exit 1
        fi
    fi
    if [ -z "$access_key" ] || [ -z "$secret_key" ]; then
        echo "Either access key ID or secret key weren't provided"
        if [ -r "$conf_local_secure" ]; then
            echo "This script tried to find keys in an existing $conf_local_secure file"
        fi
        exit 1
    fi
    export AWS_ACCESS_KEY_ID="$access_key"
    export AWS_SECRET_ACCESS_KEY="$secret_key"
    account_id="$(aws --output text --query Account sts get-caller-identity)"
    if [ "$account_id" = "$scratch_account_id" ]; then
        if [ -z "$keys_from_conf_local_secure" ]; then
            echo "Writing to conf-local-secure.properties for your local MMS server"
            echo "local.aws.accessKey=$access_key" >> "$conf_local_secure"
            echo "local.aws.secretKey=$secret_key" >> "$conf_local_secure"
            jira_user="$(aws --output text --query Arn sts get-caller-identity | cut -d / -f 2)"
            echo "local.global.user=$jira_user" >> "$conf_local_secure"
        fi
        # creating conf-hosted-secure.properties if not available
        if [ ! -f "$conf_hosted_secure" ]; then
            echo "Creating conf-hosted-secure.properties"
            mongo_releases_path="$MMS_HOME/server/mongodb-releases"

            {
                echo "automation.versions.directory=$mongo_releases_path"
                echo "mms.adminEmailAddr=cloud-manager-support@mongodb.com"
                echo "mms.assets.minified=false"
                echo "mms.assets.packaged=false"
                echo "mms.centralUrl=http://localhost:8080"
                echo "mms.pushLiveMigrations.updateJob.intervalSeconds=10"
                echo "mms.pushLiveMigrations.fetchJob.intervalSeconds=10"
                echo "mms.fromEmailAddr=cloud-manager-support@mongodb.com"
                echo "mms.hosted.version=current"
                echo "mms.ignoreInitialUiSetup=true"
                echo "mms.mail.hostname=email-smtp.us-east-1.amazonaws.com"
                echo "mms.mail.port=465"
                echo "mms.mail.ssl=true"
                echo "mms.mail.transport=smtp"
                echo "mms.replyToEmailAddr=cloud-manager-support@mongodb.com"
                echo "mms.testUtil.enabled=true"
                echo "mongo.mongoUri=mongodb://127.0.0.1:27017/?maxPoolSize=150&retryWrites=false&retryReads=false&uuidRepresentation=standard"
                echo "mongo.ssl=false"
            } >> "$conf_hosted_secure"
        fi
        if [ ! -f "$service_local_secure" ]; then
            echo "Creating service-local-secure.yaml"
            {
                echo "local:"
                echo "  aws:"
                echo "    accessKey: $access_key"
                echo "    secretKey: $secret_key"
            } >> "$service_local_secure"
        fi
        aws configure set region us-east-1 --profile mms-scratch
        aws configure set aws_access_key_id "$access_key" --profile mms-scratch
        aws configure set aws_secret_access_key "$secret_key" --profile mms-scratch
    else
        echo "The keys provided were not for the mms-scratch AWS account"
        if [ -r "$conf_local_secure" ]; then
            echo "This script tried to use keys in an existing $conf_local_secure file"
            echo "Those keys are not for the correct account, back them up and remove that file"
        fi
        exit 1
    fi
}

bazelrc_local_setup () {
    if ! [ -r "$MMS_HOME/.bazelrc.local" ]; then
        echo "Setting up defaults in .bazelrc.local"
        echo "A new mms/.bazelrc.auto is created for you on each bazel invocation in new branches."
        echo "A mms/bazelrc.user file can be created to override .auto."
        echo "See https://bazel.build/run/bazelrc for more info."
        if [ "$(uname -m)" = arm64 ]; then
            # also include homebrew tools
            action_env_path_line='build --action_env=PATH=/bin:/usr/bin:/usr/local/bin:/opt/homebrew/bin:/sbin'
        else
            action_env_path_line=''
        fi
        cat > "$MMS_HOME/.bazelrc.local" << EOF
# Configure directories used in tests
build \
    --define=AGENTS_DIR=$MMS_HOME/server/mongodb-releases \
    --define=RELEASE_DIR=$MMS_HOME/server/mongodb-releases \
    --sandbox_writable_path=$MMS_HOME/server/mongodb-releases \
    --define=TEST_DAEMON_ROOT_DIR=$MMS_HOME/server/test_dbs/

# Webpack build "development" mode skips minification and thereby speeds up builds
build --define=CLIENT_BUILD_ENVIRONMENT=development
# "local" strategy relaxes Bazel sandboxing and thereby speeds up builds https://bazel.build/docs/user-manual#strategy
build --strategy=Webpack=local
$action_env_path_line

# Used by java build. -XepDisableAllChecks skips Error Prone (errorprone.info) checks and thereby speeds up builds.
build --javacopt="-XepDisableAllChecks"

# Uncomment next line to override the defaults for Backup tests
# test --test_arg=--jvm_flags="-DMONGODB.VERSION.FOR.BRS.TESTS=3.6.0 -DSTORAGE.ENGINE.FOR.BRS.TESTS=wiredTiger"
EOF
    else
        echo "Found an existing .bazelrc.local and left it alone"
        echo "~/mms/scripts/preonboarding/modules/bazelrc_local.sh contains current recommendations"
    fi
}

onboarding () {
    mms_repo
    if [ "${ONBOARDING_NO_LOCAL_CLOUD:-}" != '1' ]; then
        awsscratch
    elif ! grep -q "export BAZEL_TELEMETRY" ~/.zshenv; then
        echo 'export BAZEL_TELEMETRY=0' >> ~/.zshenv  # won't have access to telemetry service
    fi
    # cd "$MMS_HOME" || exit 1
    # bazel run //scripts/onboarding
}

onboarding
