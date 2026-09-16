{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  imports = [
    ./programs/vscode.nix
    ./programs/fzf.nix
    ./programs/zsh.nix
    ./programs/starship.nix
    ./programs/yazi.nix
    ./programs/tmux.nix
  ];

  home.username = "mentleutner";
  home.homeDirectory = "/home/mentleutner";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    ripgrep
    jq
    btop
    doggo

  ];
}
