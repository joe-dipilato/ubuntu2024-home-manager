{
  inputs,
  outputs,
  pkgs,
  ...
}: {

  nixpkgs = {
    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlay
      # outputs.overlays.additions
      # outputs.overlays.modifications
      # outputs.overlays.unstable-packages
    ];
    config = {
      allowUnfree = true;
    };
  };


  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home = {
    username = "ubuntu";
    homeDirectory = "/home/ubuntu";
    # This value determines the Home Manager release that your configuration is
    # compatible with. This helps avoid breakage when a new Home Manager release
    # introduces backwards incompatible changes.
    #
    # You should not change this value, even if you update Home Manager. If you do
    # want to update the value, then make sure to first check the Home Manager
    # release notes.
    stateVersion = "23.11"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
    # environment.
    packages = with pkgs; [
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
      tldr # [man] supplemental tool
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
      ############################################################
      helix # [vim] replacement
      neovim # editor
      vim # editor
      vscode #
      alejandra # formatter

      ############################################################
      # Graphical Utilities
      ############################################################
      eww # widget
      sxiv # image viewer
      # vlc # video player
      mame # multi arcade machine emulator
      papirus-icon-theme
      whitesur-gtk-theme
      # TODO: Video Game Console Emulation (ATARI): Stella
      # TODO: Video Game Console Emulation (MULTIPLE): Higan -> Mednafen -> RetroArch -> MAME -> AdvanceMAME (framebuffer support)
      # TODO: Video Game Console Emulation (NINTENDO): FCEUX/Citra, DeSmuME (Nintendo DS), Mupen64Plus (Nintendo 64), Dolphin (GameCube and Wii)
      # TODO: Video Game Console Emulation (SCUMM): ScummVM
      # TODO: Video Game Console Emulation (XBOX): XQEMU

      ############################################################
      # Graphical Applications (consider flatpaks)
      ############################################################
      firefox-wayland #            # https://github.com/notusknot/dotfiles-nix/blob/main/modules/firefox/default.nix
      steam #                      #
      chromium #                   #
      baobab #                     # disk use - auto installed

      ############################################################
      # Display
      ############################################################
      hypridle # idle machine management
      hyprlock # lock screen
      hyprpicker # Color picker
      hyprcursor # Cursor
      libnotify #
      xdg-desktop-portal-gtk #
      xdg-desktop-portal-hyprland #
      xdg-utils
      dunst # notifications
      swww # wallpaper
      rofi-wayland # app launcher
      waybar # status bar

      ############################################################
      # Unsorted
      ############################################################
      pavucontrol
      meson
      pipewire
      brightnessctl
      flameshot # # screenshot SW no hyprland?
      sway-contrib.grimshot # screenshot
      gparted
      qemu_kvm
      sddm


      # # Adds the 'hello' command to your environment. It prints a friendly
      # # "Hello, world!" when run.
      # pkgs.hello

      # # It is sometimes useful to fine-tune packages, for example, by applying
      # # overrides. You can do that directly here, just don't forget the
      # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
      # # fonts?
      # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

      # # You can also create simple shell scripts directly inside your
      # # configuration. For example, this adds a command 'my-hello' to your
      # # environment:
      # (pkgs.writeShellScriptBin "my-hello" ''
      #   echo "Hello, ${config.home.username}!"
      # '')
    ];

    # Home Manager is pretty good at managing dotfiles. The primary way to manage
    # plain files is through 'home.file'.
    file = {
      # # Building this configuration will create a copy of 'dotfiles/screenrc' in
      # # the Nix store. Activating the configuration will then make '~/.screenrc' a
      # # symlink to the Nix store copy.
      # ".screenrc".source = dotfiles/screenrc;

      # # You can also set the file content immediately.
      # ".gradle/gradle.properties".text = ''
      #   org.gradle.console=verbose
      #   org.gradle.daemon.idletimeout=3600000
      # '';
    };

    # Home Manager can also manage your environment variables through
    # 'home.sessionVariables'. If you don't want to manage your shell through Home
    # Manager then you have to manually source 'hm-session-vars.sh' located at
    # either
    #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
    # or
    #  /etc/profiles/per-user/ubuntu/etc/profile.d/hm-session-vars.sh
    sessionVariables = {
      EDITOR = "code";
    };
  };

  programs = {
    # Let Home Manager install and manage itself.
    home-manager = {
      enable = true;
    };
    git = {
      enable = true;
    };
  };
}
