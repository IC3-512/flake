{ lib, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {

      # Navigation
      ll = "eza -lah --git";
      la = "eza -la --git";
      lt = "eza --tree --level=2";
      ltt = "eza --tree --level=3";
      l = "eza -lah";

      b = "bat";

      # Git
      gs = "git status";
      ga = "git add .";
      gc = "git commit";
      gp = "git push";
      gl = "git log --oneline --graph --decorate";

      # Nix / Home Manager
      hms = "home-manager switch --flake ~/nix/flake#mentleutner";
      hmb = "home-manager build --flake ~/nix/flake#mentleutner";
      nfu = "nix flake update";
    };

    initContent = lib.mkAfter ''
      autoload -Uz add-zsh-hook

      pentest_cmd_start() {
          PENTEST_CMD_START=$(date +%s)
      }

      pentest_cmd_end() {
          local exit_code=$?

          if [[ -n "$PENTEST_CMD_START" ]]; then
              local end=$(date +%s)
              local duration=$(( end - PENTEST_CMD_START ))
              local symbol

              if (( exit_code == 0 )); then
                  symbol="%F{green}✓%f"
              else
                  symbol="%F{red}✗ $exit_code%f"
              fi

              print -P "%F{blue}%f $symbol  %F{242}$duration sec%f  %F{242}$(date '+%H:%M:%S')%f"

              unset PENTEST_CMD_START
          fi
      }

      add-zsh-hook preexec pentest_cmd_start
      add-zsh-hook precmd pentest_cmd_end
    '';
  };
}
