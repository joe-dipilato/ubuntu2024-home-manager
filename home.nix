{
  inputs,
  outputs,
  pkgs,
  config,
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
    # gh # github
    lsof #
    nvd # nix wrapper
    delta # diff tool
    # dunk another git diff
    file # file type display
    tmux

    ############################################################
    # Basic Utilities
    ############################################################
    qemu #
    cachix #
    virt-manager #
    libvirt #
    xdg-utils #
    grim #
    slurp #
    # wl-copy
    pandoc # doc converter
    # home-manager # Nix Home Manager
    python312 #
    nixd # Nix language server
    scowl # dictionary wordlist
    age # Encryption tool
    sops # encryption management
    logrotate # rotate logs
    # pipx # install python apps
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
    # alacrity
    # TODO: zsh-syntax-highlighting Zsh Syntax Highlighting - Fish shell like syntax highlighting for Zsh
    # zsh-navigation-tools
    # zsh-fzf-tab
    # zsh-forgit
    # zsh-fast-syntax-highlighting
    # zsh-completions
    # zsh-autosuggestions
    # zsh-autopair

    ############################################################
    # Networking
    ############################################################
    ethtool
    socat
    conntrack-tools
    # ebtables
    # iptables
    wavemon # is a wireless device monitoring application
    # TODO: bandwhich - Bandwidth utilization monitor
    # TODO: bmon - Bandwidth Monitor
    helmfile
    # TODO: ngrok - Reverse proxy for sharing localhost
    # TODO: speedtest-cli - Command line speed test utility
    # TODO: speedtest-rs
    # TODO: Termshark - A terminal user-interface for tshark, inspired by Wireshark
    # TODO: Trippy - combines the functionality of traceroute and ping and is designed to assist with the analysis of networking issues

    ############################################################
    # Cluster
    ############################################################
    # crun #
    # kubectl # container management
    k9s # kubernetes explorer
    kubernetes
    # kompose
    kubernetes-helm
    # cri-tools
    # etcd
    # cfssl
    # podman # container tool
    # ctop # Container metrics and monitoring
    # TODO: kdash - Kubernetes dashboard app
    # dive # A tool for exploring a docker image, layer contents, and discovering ways to shrink the size of your Docker/OCI image
    # TODO: Kubectx - Faster way to switch between clusters and namespaces in kubectl
    # TODO: kubie is an alternative to kubectx, kubens and the k on prompt modification script
    # podman-tui # podman tui
    # calico-cni-plugin
    # calicoctl
    # confd-calico
    # calico-apiserver
    # calico-app-policy
    # calico-kube-controllers
    # calico-pod2daemon
    # calico-typha

    # https://terminaltrove.com/categories/tui/
    ############################################################
    # Terminal Apps
    ############################################################
    dust # terminal disk usage tool
    # tldr # [man] supplemental tool
    zellij # [tmux] replacement
    # ranger
    neofetch # system stats
    onefetch # git repo stats
    cpufetch # cpu stats
    starfetch # star stats
    btop # [top] replacement
    lazygit # git tool
    # NOTES: https://awesomeopensource.com
    # NOTES: https://github.com/mayfrost/guides/blob/master/ALTERNATIVES.md
    angle-grinder # allows you to parse, aggregate, sum, average, min/max, percentile, and sort your data
    aria2 # downloader
    # TODO: Austin / austin-tui - pyython profiler
    # TODO: Brogue - is a Roguelike game
    bluetuith # TUI-based bluetooth connection manager, which can interact with bluetooth adapters and devices
    browsh # text-based browser rendered to TTYs and browsers
    calcure # Modern TUI calendar and task manager with customizable interface
    # TODO: buku - Bookmark manager
    # TODO: Carbonyl is a Chromium based browser built to run in a terminal
    # TODO: Chafa - converts image data, into ANSI/Unicode
    # TODO: clinfo
    # TODO: cmdpxl: a totally practical command-line image editor
    # TODO: ddgr - Search the web from the terminal
    difftastic # (vs diff)
    diff-so-fancy # (vs diff)
    direnv # (load environment variables depending on the current directory)
    drill # vs dig
    dog # vs dig
    # dua-cli # Disk usage analyzer and monitor (better du)
    ncdu # better du
    dust # better du
    duf # [df] replacement
    # TODO: elia = A snappy, keyboard-centric terminal user interface for interacting with large language models
    # TODO: Euporie is a terminal based interactive computing environment for Jupyter
    # TODO: exiftool - Reading + writing metadata
    fd # [find] replacement
    # TODO: fdupes - Duplicate file finder
    # TODO: Fjira is a powerful command-line tool designed to simplify your interactions with Jira
    fq # (like jq, but for binary)
    frogmouth # Markdown viewer / browser for your terminal
    fx # a terminal JSON viewer and a JSON processor
    # TODO: gdu
    # TODO: glances - Resource monitor + web and API
    # TODO: glow = markdown terminal view
    # TODO: GoAccess is an open source real-time web log analyzer and interactive viewers
    gpg-tui # Terminal User Interface for GnuPG
    gping # (better ping)
    # TODO: Grafterm - like a simplified and minimalist version of Grafana for terminal
    # TODO: Harlequin / LAZYSQL - The SQL IDE for Your Terminal.
    # TODO: Hex Editors: HT Editor -> biew -> dhex -> hexedit
    # TODO: Hexabyte - tui hex editor
    htmlq # (like jq, but for HTML)
    httpie # (better curl)
    jc # convert tool output to json
    jless # json pager
    jo # create json objects
    jqp # TUI for exploring jq
    # TODO: kmon -  Linux Kernel Manager and Activity Monitor
    # TODO: lesspipe
    # TODO: libva-utils
    # TODO: LNAV -- The Logfile Navigator
    # TODO: miller (“like awk/sed/cut/join/sort for CSV/TSV/JSON/JSON lines”)
    most # better less
    # TODO: mtr - traceroute
    # TODO: mutt - Email client
    # TODO: neoss aims to replace usual ss command for basic usage. It provides a list of in-use TCP and UDP sockets with their respective statistics
    # TODO: NetHack - dungeon crawler
    # TODO: NVTOP - Neat Videocard TOP, a (h)top like task monitor for GPUs and accelerators
    # TODO: opencl-info
    # play # TUI for sed awk grep
    # TODO: plocate (locate)
    procs # [ps] replacement
    # TODO: PuDB: a console-based visual debugger for Python
    rm-improved # [rm] replacement
    # TODO: Runme is a tool that makes runbooks actually runnable
    # TODO: sclack - tui slack
    # TODO: scli is a simple terminal user interface for Signal
    sd # [sed] replacement
    systemctl-tui # (worse than sysz?)
    sysz # A fzf terminal UI for systemctl
    # rofi-systemd
    # TODO: topgrade
    # TODO: Torrent Tracker Scraper: Torrtux -> Torrench -> Jackett
    # TODO: tre - Directory hierarchy (better tree)
    # TODO: Usenet (File Grabber): LottaNZB -> SABnzbd -> NZBGet -> nzb -> nzbperl
    # TODO: vdpauinfo
    # TODO: vidir allows editing of the contents of a directory in a text editor
    # TODO: Violet is a colorful TUI frontend to manage Vagrant virtual machines
    # TODO: visidata (“an interactive multitool for tabular data”)
    # TODO: vulkan-tools
    wtf # wtfutil - personal information dashboard for your terminal # TODO: configure
    # TODO: xsv (a command line tool for csv files, from burntsushi)
    # TODO: hexyl (xxd, od)
    yewtube # forked from mps-youtube , is a Terminal based YouTube player and downloader
    # mpv # terminal video player
    # logshark # json log viewer
    # nemu - ncurses-based TUI for QEMU
    # neoss - User-friendly and detailed socket statistics with a TUI.
    # netop - A network topology visualizer.
    # openapi-tui - Browse and run APIs defined with OpenAPI v3.0 in the TUI
    # pathos - A terminal interface for editing and managing PATH environment variables.
    oxker # A simple TUI to view & control docker/podman containers.
    # radare2 # unix-like reverse engineering framework and command-line toolset.
    # rizin # like radare2
    # sc-im - An ncurses spreadsheet program for terminal
    # sshs - Terminal user interface for SSH
    # tailspin # A log file highlighter
    # taskwarrior-tui # A terminal user interface for taskwarrior
    # tig # Text-mode interface for git
    # wiki-tui # A fast Wikipedia CLI/TUI client
    # youtube-tui # An aesthetically pleasing YouTube TUI written in Rust

    ############################################################
    # Editors
    helix # [vim] replacement
    neovim # editor
    vim # editor
    vscode #
    alejandra # formatter

    ############################################################
    # Graphical
    sxiv # image viewer
    xdg-utils
    firefox #                    # https://github.com/notusknot/dotfiles-nix/blob/main/modules/firefox/default.nix

    ############################################################
    # FONTS
    nerdfonts
    font-awesome
    google-fonts
    source-code-pro

    ############################################################
    # Unsorted
    pavucontrol
    meson
    pipewire
    brightnessctl
    gparted
    qemu_kvm
    sddm
  ];

  ################################################################################
  # FILES
  ################################################################################

  home.file = {
    ".sops.yaml".source = ./config/sops.yaml;
  };

  xdg.configFile = {
    "kitty/kitty.session.conf".source = ./config/kitty.session.conf;
  };

  home.sessionVariables = {
    EDITOR = "code";
  };

  systemd.user.startServices = "sd-switch";

  ################################################################################
  # PROGRAMS
  ################################################################################
  programs = {
    home-manager.enable = true; # Let Home Manager install and manage itself.
    git.enable = true;
    gpg.enable = true;
    zsh = {
      enable = true;
      autocd = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

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
        update = "sudo ${pkgs.nixos-rebuild}/bin/nixos-rebuild switch --flake ~/repos/nixos-config --impure";
        cat = "bat";
        pcat = "prettybat --style=full";
        _cat = "$(whereis cat | cut -f2 -d' ')";
        grep = "rg --no-line-number";
        pgrep = "batgrep --no-follow";
        _grep = "$(whereis grep | cut -f2 -d' ')";
        man = "BAT_THEME='Monokai Extended' batman";
        _man = "$(whereis man | cut -f2 -d' ')";
        watch = "batwatch --watcher=entr";
        _watch = "$(whereis watch | cut -f2 -d' ')";
        diff = "batdiff";
        _diff = "$(whereis diff | cut -f2 -d' ')";
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

    kitty = {
      enable = true;
      extraConfig = builtins.readFile (pkgs.substitute {
        name = "extra-init";
        src = ./config/kitty.conf;
        isExecutable = true;
        substitutions = ["--subst-var-by" "_homedir_" config.home.homeDirectory];
      });
      font.name = "FiraCode Nerd Font Propo";
      shellIntegration = {
        enableZshIntegration = true;
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



  };
}
