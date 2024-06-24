{
  inputs,
  outputs,
  pkgs,
  config,
  lib,
  ...
}: {

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.nix-vscode-extensions.overlays.default
    inputs.nur.overlay
  ];

  home = {
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
    stateVersion = "23.11";
  };

  # environment variables
  home.sessionVariables = {
    EDITOR = "code --wait";
    EZA_COLORS = "ex=92;1:cr=31;2:tm=2;3;9:do=94:im=95:vi=95:mu=95:lo=95:sc=32:gn=95:uR=31:gR=31:nb=2;36:nk=2;92:nm=2;33:ng=2;31:nt=2;31";
    BAT_THEME = "Monokai Extended";
    MMS_HOME= "/home/ubuntu/mms";
  };

  home.shellAliases = {
      bazel = "bazelisk";
      update = "home-manager switch --flake ~/repos/ubuntu2024-home-manager --impure";
      pcat = "prettybat --style=full";
      grep = "rg --no-line-number";
      pgrep = "batgrep --no-follow";
      man = "BAT_THEME='Monokai Extended' batman";
      diff = "batdiff";
  };

  ################################################################################
  # PACKAGES
  ################################################################################
  home.packages = with pkgs; [
    ############################################################
    # Terminal packages
    ############################################################
    wget #
    curl #
    bat # [cat] replacement
    bat-extras.batdiff # .
    bat-extras.batman # .
    bat-extras.batgrep # .
    bat-extras.batpipe # .
    bat-extras.batwatch # .
    bat-extras.prettybat # .
    eza # [ls] replacement
    ripgrep # [grep] replacement
    ripgrep-all # .
    zoxide # [cd] replacement
    hstr # history management
    entr # run command on save
    navi # termina cheat sheet
    just # simple script selector
    jq #
    yq #
    git #
    jujutsu # [git] supplement (jj)
    gh # github
    lsof #
    nvd # nix wrapper
    delta # diff tool
    file # file type display
    drone-cli # drone.io cli

    ############################################################
    # Basic Utilities
    ############################################################
    qemu #
    cachix #
    virt-manager #
    libvirt #
    xdg-utils #
    pandoc # doc converter
    python312 #
    nixd # Nix language server
    scowl # dictionary wordlist
    age # Encryption tool
    sops # encryption management
    logrotate # rotate logs
    rsyslog # syslog rules
    glib # basic gnome tools e.g. gresource
    openssl
    gnumake
    rpcbind # needed for nfs

    ############################################################
    # Terminal Emulator / Shell tools
    ############################################################
    zsh # shell
    zsh-powerlevel10k # .
    kitty # terminal editor
    fzf # fuzzy finder
    fzf-zsh # .

    ############################################################
    # Networking
    ############################################################
    ethtool
    socat
    conntrack-tools
    iptables
    wavemon # is a wireless device monitoring application

    ############################################################
    # Cluster
    ############################################################
    k9s # kubernetes explorer
    kubernetes
    (wrapHelm kubernetes-helm {
      plugins = [
        kubernetes-helmPlugins.helm-diff
      ];
    })
    helmfile
    podman # container tool
    podman-tui # podman tui

    ############################################################
    # Terminal Apps
    ############################################################
    dust # terminal disk usage tool
    tealdeer # [tldr] / [man] alternate
    neofetch # system stats
    onefetch # git repo stats
    cpufetch # cpu stats
    btop # [top] replacement
    lazygit # git tool
    angle-grinder # allows you to parse, aggregate, sum, average, min/max, percentile, and sort your data
    aria2 # downloader
    calcure # Modern TUI calendar and task manager with customizable interface
    difftastic # (vs diff)
    diff-so-fancy # (vs diff)
    direnv # (load environment variables depending on the current directory)
    drill # vs dig
    dog # vs dig
    ncdu # better du
    dust # better du
    duf # [df] replacement
    fd # [find] replacement
    fq # (like jq, but for binary)
    frogmouth # Markdown viewer / browser for your terminal
    fx # a terminal JSON viewer and a JSON processor
    gpg-tui # Terminal User Interface for GnuPG
    gping # (better ping)
    htmlq # (like jq, but for HTML)
    httpie # (better curl)
    jc # convert tool output to json
    jless # json pager
    jo # create json objects
    jqp # TUI for exploring jq
    bazelisk
    most # better less
    procs # [ps] replacement
    rm-improved # [rm] replacement
    sd # [sed] replacement
    systemctl-tui # (worse than sysz?)
    sysz # A fzf terminal UI for systemctl
    wtf # wtfutil - personal information dashboard for your terminal # TODO: configure
    oxker # A simple TUI to view & control docker/podman containers.

    ############################################################
    # Editors
    helix # [vim] replacement
    neovim # editor
    vim # editor
    alejandra # formatter

    ############################################################
    # FONTS
    nerdfonts
    font-awesome
    google-fonts
    source-code-pro

    ############################################################
    # Unsorted
    meson

  ];

  ################################################################################
  # FILES
  ################################################################################

  home.file = {
    ".sops.yaml".source = ./config/sops.yaml;
  };
  # Hack to allow setting permissions
  home.file.".cache/known_hosts".source = ./config/known_hosts;
  home.file.".cache/known_hosts".onChange = ''
    install -m 600 ${config.home.homeDirectory}/.cache/known_hosts ${config.home.homeDirectory}/.ssh/user_known_hosts
  '';

  systemd.user.startServices = "sd-switch";

  ################################################################################
  # PROGRAMS
  ################################################################################
  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    gpg.enable = true;
    ssh = {
      enable = true; # https://mynixos.com/home-manager/options/programs.ssh
      userKnownHostsFile = "~/.ssh/user_known_hosts";
      addKeysToAgent = "yes";
      # extraConfig = "# test";
    };

    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      sessionVariables = {
        MMS_HOME= "/home/ubuntu/mms";
      };

      initExtra = builtins.readFile (pkgs.substitute {
        name = "extra-init";
        src = ./config/zsh-extra-init.sh;
        isExecutable = true;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      });
      # zsh will source the contents of 'file' given a 'src' directory containing the file
      plugins = [
        {
          name = "powerlevel10k";
          src = pkgs.zsh-powerlevel10k;
          file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
        }
        {
          name = "powerlevel10k-config";
          src = ./config/p10k;
          file = "p10k.zsh";
        }
      ];
      shellAliases = {

      };
      oh-my-zsh = {
        enable = true;
        theme = "robbyrussell";
        # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
        plugins = builtins.fromJSON (builtins.readFile (pkgs.substitute {
          name = "oh-my-zsh-conf";
          src = ./config/oh-my-zsh.json;
          isExecutable = false;
          substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
        }));
      };
    };

    tealdeer = {
      enable = true; # https://mynixos.com/options/programs.tealdeer
      settings = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "tealdeer-conf";
        src = ./config/tealdeer.conf;
        isExecutable = false;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
    };

    ripgrep = {
      enable = true; # https://mynixos.com/home-manager/options/programs.ripgrep
      arguments = [];
    };

    eza = {
      enable = true;
      enableZshIntegration = true;
      git = true;
      icons = true;
      extraOptions = [
        "--group-directories-first"
        "--header"
        "--group"
        "--reverse"
        "--sort=modified"
        "--color=always"
        "--classify=always"
      ];
    };

    bat = {
      enable = true;
      config = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "bat-conf";
        src = ./config/bat.conf;
        isExecutable = false;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
      extraPackages = with pkgs.bat-extras; [batdiff batman batgrep batpipe batwatch];
    };

    zoxide = {
      enable = true;
      enableZshIntegration = true;
      options = ["--cmd cd"];
    };

    fzf = {
      enable = true;
      enableZshIntegration = true;
    };

    hstr = {
      enable = true;
      enableZshIntegration = true;
    };

    # https://github.com/sxyazi/yazi
    yazi = {
      enable = true; # https://mynixos.com/home-manager/options/programs.yazi
      enableZshIntegration = true;
      # https://yazi-rs.github.io/docs/configuration/yazi/
      settings = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "yazi-conf";
        src = ./config/yazi/yazi.toml;
        isExecutable = false;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
      # https://yazi-rs.github.io/docs/configuration/keymap/
      keymap = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "yazi-keymap";
        src = ./config/yazi/keymap.toml;
        isExecutable = false;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
      # https://yazi-rs.github.io/docs/configuration/theme
      theme = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "yazi-theme";
        src = ./config/yazi/theme.toml;
        isExecutable = false;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
    };

    git = {
      enable = true;
      lfs.enable = true;
      signing.key = "TBD";

      extraConfig = builtins.fromTOML (builtins.readFile (pkgs.substitute {
        name = "git-conf";
        src = ./config/git.conf;
        isExecutable = false;
        substitutions =
          ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      }));
    };
  };


  services = {
    gpg-agent = {
      enable = true; # https://mynixos.com/home-manager/options/services.gpg-agent
      enableZshIntegration = true;
      extraConfig = "";
      enableSshSupport = true;
      # pinentryPackage =
      # sshKeys = [];
    };
    ssh-agent.enable = true; # https://mynixos.com/home-manager/options/services.ssh-agent

  };
}
