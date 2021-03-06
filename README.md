<img src="http://gfxmonk.net/dist/status/project/vim-watch.png">

# vim-watch

..is a simple linux-only tool that enables quick feedback during development, by automatically re-running a command whenever you save a file (with vim).

It's similar to countless other framework-specific utilities that watch your filesystem for changes. Instead of bothering with include / exclude lists, filtering out spurious events and watching hundreds of files or more, vim-watch just watches one file. It's combined with a vim plugin that touches that file whenever you save a file from any vim instance. It's not clever, but it's generally all you need.

## Installation:

Dump the git checkout somewhere on vim's runtime path (use pathogen or something), and add `bin/` to your `$PATH`.

## Usage:

	vim-watch [OPTIONS] command [arg ... ]

This will automatically tell every running vim instance to run `:WatchNotify`, and poll the sentinel file for modification. On startup (and every time the file changes), it'll run the command you passed. There is no funny business like shell interpolation - just a command and its arguments.

When you stop vim-watch (with ctrl-c), it'll tell every running vim instance to run `:WatchNotifyOff`.

If you'd rather be without this integration, you can use `--no-remote` and make sure the plugin is enabled in vim yourself.

If you're some kind of smart non-vim-loving person, I'm sure you can knock up a plugin for `$EDITOR` that does the same thing, and maybe modify / copy the `vim-watch` script to integrate accordingly. Patches welcome.

## Good ideas:

	vim-watch make

	# if you have a long-running server that responds to HUP by restarting:
	vim-watch killall -HUP server-process

## Caveats:

 - If you run multiple concurrent watchers (I'm not sure why you'd need to), the first one to quit will turn off the lights (i.e run `:WatchNotifyOff`).
 - If you start a new vim instance after starting `vim-watch`, it won't have the plugin enabled. You can manually run `:WatchNotify` (or even put this in your `~/.vimrc` if you don't want to have to remember it)
