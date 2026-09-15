{ ... }:

{
  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      format = ''
        $directory$git_branch$git_status
        $character
      '';

      right_format = "\${custom.date}$time";

      directory = {
        format = "[$path](bold fg:#58A6FF) ";
        truncation_length = 4;
        truncate_to_repo = false;
        home_symbol = "~";
      };

      git_branch = {
        symbol = "git:";
        format = "[$symbol$branch](bold fg:#BC8CFF) ";
      };

      git_status = {
        format = "[$all_status$ahead_behind](bold fg:#D29922)";

        modified = "+";
        staged = "+";
        untracked = "?";
        deleted = "-";
        renamed = "»";
        conflicted = "!";

        ahead = "↑\${count}";
        behind = "↓\${count}";
        diverged = "↕";
      };

      character = {
        success_symbol = "[>](bold fg:#58A6FF)";
        error_symbol = "[>](bold fg:#58A6FF)";
      };

      custom.date = {
        command = "date '+%a %Y-%m-%d'";
        when = "true";
        format = "[$output](fg:#8B949E) ";
      };

      time = {
        disabled = false;
        time_format = "%H:%M:%S";
        format = "[$time](fg:#8B949E)";
      };

      cmd_duration.disabled = true;
      status.disabled = true;
    };
  };
}
