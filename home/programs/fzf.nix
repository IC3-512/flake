{ pkgs, ... }:

{
  programs.fzf = {
    enable = true;

    enableBashIntegration = true;
    enableZshIntegration = true;

    defaultCommand =
      "fd --type f --hidden --follow --exclude .git";

    defaultOptions = [
      "--height=60%"
      "--layout=reverse"
      "--border"
      "--info=inline"
    ];

    fileWidgetCommand =
      "fd --type f --hidden --follow --exclude .git";

    fileWidgetOptions = [
      "--preview 'bat --color=always --line-range=:300 {}'"
      "--preview-window=right:60%"
    ];

    changeDirWidgetCommand =
      "fd --type d --hidden --follow --exclude .git";

    changeDirWidgetOptions = [
      "--preview 'eza --tree --color=always --level=2 {}'"
    ];

    historyWidgetOptions = [
      "--sort"
      "--exact"
    ];
  };

  home.packages = with pkgs; [
    fd
    bat
    eza
  ];
}
