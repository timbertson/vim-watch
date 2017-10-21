{ pkgs ? import <nixpkgs> {}, enableNeovim ? false }:
pkgs.callPackage ./default.nix {
	inherit enableNeovim;
	sourceOverrides.vim-watch = ./local.tgz;
}
