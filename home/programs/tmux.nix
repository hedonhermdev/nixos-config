{ config, pkgs, ... }:
let 
  plugins = pkgs.tmuxPlugins;
in {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    terminal = "screen-256color";
    plugins = with plugins; [
      nord
      cpu
    ];
    extraConfig = ''
      set-option -g mouse on

      # Set prefix to <C-a>
      set-option -g prefix C-a
      unbind-key C-b
      bind-key C-a send-prefix

      bind | split-window -h
      bind - split-window -v
      unbind '"'
      unbind %

      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      ## styling
      # split lines
      set -g pane-border-style fg=brightblack
      set -g pane-active-border-style fg=brightblack

      # statusline
      set -g status-bg black
      set -g status-fg white

      set -g status-right ""
      set -g status-left ""

      set -g status-justify centre

      set -g window-status-current-format "●"
      set -g window-status-format "○"
    '';
  };
}
