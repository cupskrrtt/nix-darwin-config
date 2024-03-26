{ config, pkgs, lib, home-manager, ... }:

let user = "cup";
in {
  imports = [ ];

  users.users.${user} = {
    name = "${user}";
    home = "/Users/${user}";
    isHidden = false;
    shell = pkgs.zsh;
  };

  homebrew = {
    enable = true;
    casks = pkgs.callPackage ./cask.nix { };

    # App IDs from using the mas CLI app
    #masApps = {};
  };

  environment.systemPackages = with pkgs; [ mas ];

  # Enable home-manager
  home-manager = {
    useGlobalPkgs = true;

    users.${user} = { pkgs, config, lib, ... }: {
      home = {
        enableNixpkgsReleaseCheck = false;
        packages = with pkgs;
          [
            # Terminal
            lazygit
          ];
        stateVersion = "23.11";
      };

      programs = {
        zsh = {
          enable = true;
          syntaxHighlighting = { enable = true; };
          enableAutosuggestions = true;
          shellAliases = {
            ls = "exa --long --header --all --icons";
            gl = "lazygit";
            proj = "cd /Volumes/Cup/Dev/Projects/";
            work = "cd /Volumes/Cup/Dev/Work/";
          };
          initExtraFirst = ''
            eval "$(starship init zsh)"
          '';
          initExtra = ''
            export PATH="$PATH:$HOME/go/bin"
            dev () {
              nix develop ~/nix-darwin-config#$1 -c zsh
            }
          '';
        };

        tmux = {
          enable = true;
          terminal = "screen-256color";
          baseIndex = 1;
          escapeTime = 0;
          extraConfig = ''
            set -g allow-rename on
            set -g automatic-rename on
            set -g base-index 1
            setw -g pane-base-index 1
            set -g detach-on-destroy on
            set -g mouse on

            is_vim='echo "#{pane_current_command}" | grep -iqE "(^|\/)g?(view|n?vim?)(diff)?$"'

            set-option -ga terminal-overrides ",xterm-256color:Tc"

            set -g mode-style "fg=#7aa2f7,bg=#3b4261"

            set -g message-style "fg=#7aa2f7,bg=#3b4261"
            set -g message-command-style "fg=#7aa2f7,bg=#3b4261"

            set -g pane-border-style "fg=#3b4261"
            set -g pane-active-border-style "fg=#7aa2f7"

            set -g status "on"
            set -g status-justify "left"

            set -g status-style "fg=#7aa2f7,bg=#16161e"

            set -g status-left-length "100"
            set -g status-right-length "100"

            set -g status-left-style NONE
            set -g status-right-style NONE

            set -g status-left "#[fg=#15161e,bg=#7aa2f7,bold] #S #[fg=#7aa2f7,bg=#16161e,nobold,nounderscore,noitalics]"
            set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %I:%M %p #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
            if-shell '[ "$(tmux show-option -gqv "clock-mode-style")" == "24" ]' {
              set -g status-right "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#16161e] #{prefix_highlight} #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261] %Y-%m-%d  %H:%M #[fg=#7aa2f7,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#15161e,bg=#7aa2f7,bold] #h "
            }

            setw -g window-status-activity-style "underscore,fg=#a9b1d6,bg=#16161e"
            setw -g window-status-separator ""
            setw -g window-status-style "NONE,fg=#a9b1d6,bg=#16161e"
            setw -g window-status-format "#[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]#[default] #I  #W #F #[fg=#16161e,bg=#16161e,nobold,nounderscore,noitalics]"
            setw -g window-status-current-format "#[fg=#16161e,bg=#3b4261,nobold,nounderscore,noitalics]#[fg=#7aa2f7,bg=#3b4261,bold] #I  #W #F #[fg=#3b4261,bg=#16161e,nobold,nounderscore,noitalics]"

            # tmux-plugins/tmux-prefix-highlight support
            set -g @prefix_highlight_output_prefix "#[fg=#e0af68]#[bg=#16161e]#[fg=#16161e]#[bg=#e0af68]"
            set -g @prefix_highlight_output_suffix ""  
          '';
        };

        git = {
          enable = true;
          userName = "Luthfi Khan";
          userEmail = "khanalfarizzi@hotmail.com";
        };

        #Finish the settings
        alacritty = {
          enable = true;
          settings = {
            env = { TERM = "xterm-256color"; };

            window = {
              decorations = "none";
              class = {
                instance = "Alacritty";
                general = "Alacrittye";
              };
            };

            scrolling = { history = 5000; };

            font = {
              normal = {
                family = "Hack Nerd Font Mono";
                style = "Regular";
              };

              bold = {
                family = "Hack Nerd Font Mono";
                style = "Bold";
              };

              italic = {
                family = "Hack Nerd Font Mono";
                style = "Italic";
              };

              bold_italic = {
                family = "Hack Nerd Font Mono";
                style = "Bold Italic";
              };

              size = 14.0;
            };

            colors = {
              primary = {
                background = "#1a1b26";
                foreground = "#c0caf5";
              };

              normal = {
                black = "#15161e";
                red = "#f7768e";
                green = "#9ece6a";
                yellow = "#e0af68";
                blue = "#7aa2f7";
                magenta = "#bb9af7";
                cyan = "#7dcfff";
                white = "#a9b1d6";
              };

              bright = {
                black = "#414868";
                red = "#f7768e";
                green = "#9ece6a";
                yellow = "#e0af68";
                blue = "#7aa2f7";
                magenta = "#bb9af7";
                cyan = "#7dcfff";
                white = "#c0caf5";
              };

              indexedColors = [
                {
                  index = 16;
                  color = "#ff9e64";
                }
                {
                  index = 17;
                  color = "#db4b4b";
                }
              ];
            };
            save_to_clipboard = true;
            dynamic_title = true;
            live_config_reload = true;

            key_bindings = [
              {
                key = "T";
                mods = "Command";
                chars = "\\x02\\x63";
              }
              {
                key = "W";
                mods = "Command";
                chars = "\\x02\\x78";
              }
              {
                key = "RBracket";
                mods = "Command";
                chars = "\\x02n";
              }
              {
                key = "LBracket";
                mods = "Command";
                chars = "\\x02p";
              }
              {
                key = "V";
                mods = "Command|Shift";
                chars = ''\x02"'';
              }
              {
                key = "H";
                mods = "Command|Shift";
                chars = "\\x02%";
              }
              {
                key = "H";
                mods = "Control|Command";
                chars = "\\x02\\x1b\\x5b\\x44";
              }
              {
                key = "L";
                mods = "Control|Command";
                chars = "\\x02\\x1b\\x5b\\x43";
              }
              {
                key = "J";
                mods = "Control|Command";
                chars = "\\x02\\x1b\\x5b\\x42";
              }
              {
                key = "K";
                mods = "Control|Command";
                chars = "\\x02x1b\\x5b\\x41";
              }
            ];

          };
        };

        #Finish the settings
        starship = {
          enable = true;
          settings = {
            format = ''
              $username$directory$git_branch$git_state$git_status$cmd_duration$line_break''${custom}$character
            '';
            directory.style = "blue";
            character = {
              success_symbol = "[❯](fg:#FF51BF)";
              error_symbol = "[❯](fg:#FF51BF)";
              vimcmd_symbol = "[vim ❯](green)";
            };
            username = { show_always = true; };
            custom.lang = {
              command = "echo $DEV_SHELL_ENV";
              when = ''test -n "$DEV_SHELL_ENV"'';
              format = "[$output]($style) ";
              style = "fg:#FFD1DC";
            };
          };
        };

        eza = { enable = true; };
      };
    };
  };
}
