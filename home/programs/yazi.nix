{ pkgs, ... }:

{
  programs.yazi = {
    enable = true;
    enableZshIntegration = true;

    extraPackages = with pkgs; [
      ripgrep
      fd
      fzf
      bat
      jq
      poppler
      ffmpegthumbnailer
      imagemagick
    ];

    settings = {
      mgr = {
        show_hidden = true;

        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
        linemode = "size";
        show_symlink = true;

        ratio = [
          1
          3
          4
        ];
      };

      preview = {
        wrap = "yes";
        tab_size = 2;
        max_width = 1200;
        max_height = 1800;
      };
    };

    keymap = {
      mgr.prepend_keymap = [
        {
          on = [ "<C-q>" ];
          run = "quit";
          desc = "Quit";
        }

        {
          on = [ "g" "h" ];
          run = "cd ~";
          desc = "Go home";
        }

        {
          on = [ "g" "r" ];
          run = "cd /";
          desc = "Go root";
        }

        {
          on = [ "<C-f>" ];
          run = "filter --smart";
          desc = "Filter files";
        }
      ];
    };
  };
}
