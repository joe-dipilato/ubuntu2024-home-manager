# ubuntu2024-home-manager

## Mount /nix from home dir

```shell
mkdir /home/ubuntu/nix
echo "/home/ubuntu/nix /nix auto defaults,nofail,nobootwait,bind 0 2" | sudo tee -a /etc/fstab
sudo systemctl daemon-reload
sudo systemctl restart local-fs.target
```

## Install nix package manager

```shell
sh <(curl -L https://nixos.org/nix/install) --daemon --yes
# Start a new shell
```

## Enable home-manager

```shell
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

## add to .bashrc / .zshrc

```shell
echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.bashrc
echo '. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"' >> ~/.zshrc
```

## enable flakes

```shell
mkdir -p ~/.config/nix/
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
sudo systemctl restart nix-daemon.service
```

## Install home manager

```shell
nix run home-manager/release-23.11 -- init --switch
```

This will generate a flake.nix and a home.nix file in ~/.config/home-manager

- `~/.config/home-manager/home.nix`
- `~/.config/home-manager/flake.nix`

```shell
home-manager switch --flake .
```

`nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";`

```shell
git config --global user.name "Joe DiPilato"
git config --global user.email "joe.dipilato@mongodb.com"
```

## Update packages

```shell
nix-channel --update
nix flake update
home-manager switch --flake .
```

```shell
# nix-collect-garbage -d
```
