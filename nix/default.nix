{ pkgs ? import <nixpkgs> {}, enableNeovim ? false }:
with pkgs;
let
	pythonPackages = pkgs.python3Packages;
	python = pythonPackages.python;
in
stdenv.mkDerivation {
	name = "vim-watch";
	src = ../.;
	buildInputs = [ python ] ++ (if enableNeovim then [ makeWrapper neovim-remote ] else []);
	installPhase = ''
		mkdir -p $out/share/vim;
		cp -a ./* $out/share/vim
		mv $out/share/vim/bin $out/bin
	'' + (if enableNeovim
		then ''
			wrapProgram $out/bin/vim-watch \
				--prefix PATH : ${neovim-remote}/bin \
				;
		''
		else ""
	);
}
