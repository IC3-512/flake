{ pkgs, ... }:

{
  programs.tmux = {
    enable = true;

    # Always start the Home Manager/Nix zsh
    shell = "${pkgs.zsh}/bin/zsh";

    terminal = "screen-256color";

    mouse = true;
    keyMode = "vi";

    baseIndex = 1;
    clock24 = true;

    escapeTime = 0;
    historyLimit = 100000;

    focusEvents = true;
    aggressiveResize = true;


        plugins = with pkgs; [
      tmuxPlugins.sensible

      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          set -g @resurrect-capture-pane-contents 'on'
        '';
      }

      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g default-command "${pkgs.zsh}/bin/zsh"
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '15'
        '';
      }

      {
        plugin = tmuxPlugins.logging;
        extraConfig = ''
          set -g @logging-path "$HOME/logs/tmux"
          set -g @screen-capture-path "$HOME/logs/tmux"
          set -g @save-complete-history-path "$HOME/logs/tmux"
        '';
      }
    ];

    extraConfig = ''
      # True color
      set -as terminal-features ",xterm-256color:RGB"

      # Start numbering windows/panes at 1
      set -g renumber-windows on

      # Easier splits
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      # New windows inherit current directory
      bind c new-window -c "#{pane_current_path}"

      # Reload config
      bind r source-file ~/.config/tmux/tmux.conf \; display-message "tmux config reloaded"

      # Better pane navigation
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      # Resize panes
      bind -r H resize-pane -L 5
      bind -r J resize-pane -D 5
      bind -r K resize-pane -U 5
      bind -r L resize-pane -R 5

      # Copy mode
      bind [ copy-mode

      bind -T copy-mode-vi v send -X begin-selection
      bind -T copy-mode-vi y send -X copy-selection-and-cancel

      # Don't rename windows automatically
      set -g allow-rename off
      set -g automatic-rename off


      # Create a private log directory.
      run-shell 'umask 077; ${pkgs.coreutils}/bin/mkdir -p "$HOME/logs/tmux"'

      # Separate log per pane; strip terminal colour codes.
      set -g @autolog-command 'umask 077; exec ${pkgs.coreutils}/bin/stdbuf -oL ${pkgs.ansifilter}/bin/ansifilter >> "$HOME/logs/tmux/tmux-#{pid}-#{pane_pid}-%Y%m%dT%H%M%S.log"'

      # Automatically log new sessions, windows, and split panes.
      set-hook -g after-new-session {
        pipe-pane -o "#{T:@autolog-command}"
      }
      set-hook -g after-new-window {
        pipe-pane -o "#{T:@autolog-command}"
      }
      set-hook -g after-split-window {
        pipe-pane -o "#{T:@autolog-command}"
      }

      # Override the plugin toggle to control the same logging pipe.
      bind-key P pipe-pane -o "#{T:@autolog-command}"
    '';
  };
}
