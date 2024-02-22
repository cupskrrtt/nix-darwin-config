{ config, pkgs, lib, home-manager, ... }:

let user = "cup";
in
{
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
        packages = with pkgs; [
          # Terminal
          stow
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
            mysql = "/usr/local/mysql/bin/mysql -u root -p";
            #rebuild = "darwin-rebuild switch --flake ~/dotfiles/nix/.config/nix-darwin";
          };
          initExtraFirst = ''
                        dev () {
                           nix develop ~/nix-darwin-config#$1 -c zsh
                        }
            						eval "$(starship init zsh)"
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

            				        # --> Catppuccin (Mocha)
            				        thm_bg="#1e1e2e"
            				        thm_fg="#cdd6f4"
                  					thm_cyan="#89dceb"
            				        thm_black="#181825"
            				        thm_gray="#313244"
            				        thm_magenta="#cba6f7"
            				        thm_pink="#f5c2e7"
            				        thm_red="#f38ba8"
            				        thm_green="#a6e3a1"
            				        thm_yellow="#f9e2af"
            				        thm_blue="#89b4fa"
            				        thm_orange="#fab387"
            				        thm_black4="#585b70"

            				        # =====================================
            				        # ===    Appearence and status bar  ==
            				        # =====================================
            				        set -g mode-style "fg=$thm_fg,bg=$thm_bg"

            				        # command line style
            				        set -g message-style "fg=$thm_fg,bg=$thm_black4"

            				        # status line style
            				        set -g status-style "fg=$thm_blue,bg=$thm_bg"

            				        # general status bar settings
            				        set -g status on
            				        set -g status-interval 5
            				        set -g status-position top
            				        set -g status-justify left
            				        set -g status-right-length 100

            				        # define widgets we're going to use in status bar
            				        # note, that this is not the complete list, some of them are loaded from plugins
            				        wg_session="#[fg=$thm_fg] #S #[default]"
            				        wg_date="#[fg=$thm_blue]%h %d %H:%M#[default]"
            				        wg_user_host="#[fg=$thm_blue]#(whoami)#[default]"

            				        set -g status-left "$wg_session"
            				        set -g status-right "$wg_user_host | $wg_date"
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
                background = "#1E1E2E";
                foreground = "#CDD6F5";
                dim_foreground = "#CDD6F4";
                bright_foreground = "#CDD6F4";
              };

              cursor = {
                text = "#1E1E2E";
                cursor = "#F5E0DC";
              };

              vi_mode_cursor = {
                text = "#1E1E2E";
                cursor = "#B4BEFE";
              };

              search = {
                matches = {
                  foreground = "#1E1E2E";
                  background = "#A6ADC8";
                };

                focused_match = {
                  foreground = "#1E1E2E";
                  background = "#A6E3A1";
                };

                footer_bar = {
                  foreground = "#1E1E2E";
                  background = "#A6ADC8";
                };
              };

              hints = {
                start = {
                  foreground = "#1E1E2E";
                  background = "#F9E2AF";
                };
                end = {
                  foreground = "#1E1E2E";
                  background = "#A6ADC8";
                };
              };

              selection = {
                text = "#1E1E2E";
                background = "#F5E0DC";
              };

              normal = {
                black = "#45475A";
                red = "#F38BA8";
                green = "#A6E3A1";
                yellow = "#F9E2AF";
                blue = "#89B4FA";
                magenta = "#F5C2E7";
                cyan = "#94E2D5";
                white = "#BAC2DE";
              };

              bright = {
                black = "#585B70";
                red = "#F38BA8";
                green = "#A6E3A1";
                yellow = "#F9E2AF";
                blue = "#89B4FA";
                magenta = "#F5C2E7";
                cyan = "#94E2D5";
                white = "#A6ADC8";
              };

              dim = {
                black = "#45475A";
                red = "#F38BA8";
                green = "#A6E3A1";
                yellow = "#F9E2AF";
                blue = "#89B4FA";
                magenta = "#F5C2E7";
                cyan = "#94E2D5";
                white = "#BAC2DE";
              };

              indexed_colors = [
                {
                  index = 16;
                  color = "#FAB387";
                }
                {
                  index = 17;
                  color = "#F5E0DC";
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
              $username$hostname$directory$git_branch$git_state$git_status$cmd_duration$line_break$python$character
            '';
            directory = { style = "blue"; };
            character = {
              success_symbol = "[❯](purple)";
              error_symbol = "[❯](red)";
              vimcmd_symbol = "[❮](green)";
            };

          };
        };

        eza = { enable = true; };
      };
    };
  };
}
