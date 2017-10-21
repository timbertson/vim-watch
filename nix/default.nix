{ pkgs ? import <nixpkgs> {}, enableNeovim ? false, sourceOverrides ? {} }:
with pkgs;
let
	pythonPackages = pkgs.python3Packages;
	python = pythonPackages.python;
in
stdenv.mkDerivation {
	name = "vim-watch";
	src = sourceOverrides.vim-watch or (fetchgit {
		url = "https://github.com/gfxmonk/vim-watch";
		rev = "382aea1469dc832154e7c1aaf7c43923c1973155";
		sha256 = "1hxv6a14wsjbn0nncgy3nl7kw428zy3l11j415y8nmvkr73y55jn";
	});
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
