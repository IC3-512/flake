{ pkgs, ... }:

{
  programs.vscode = {
    enable = true;

    package = pkgs.vscode;

    profiles.default = {
      userSettings = {
        # Editor
        "editor.fontSize" = 14;
        "editor.tabSize" = 4;
        "editor.insertSpaces" = true;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;

        # Files
        "files.trimTrailingWhitespace" = true;
        "files.insertFinalNewline" = true;
        "files.trimFinalNewlines" = true;

        # Terminal
        "terminal.integrated.fontSize" = 14;

        # Workbench
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "GitHub Dark Dimmed";

        # Security
        "security.workspace.trust.enabled" = true;

        # Updates are handled through Nix
        "update.mode" = "none";

        # Autosave
        "files.autoSave" = "afterDelay";
        "files.autoSaveDelay" = 1000;

        # Disable slop
        "chat.disableAIFeatures" = true;


        # Language Server
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.formatterPath" = "nixfmt";
      };

      extensions = with pkgs.vscode-extensions; [
        jnoortheen.nix-ide
        editorconfig.editorconfig
        github.github-vscode-theme
      ];
    };
  };
}
