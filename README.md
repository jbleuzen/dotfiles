# Do you dotfiles ?

As I am not an original person, I forked Zach Holman dotfiles to create my own, as he stated in "[Dotfiles are meant to be forked](http://zachholman.com/2010/08/dotfiles-are-meant-to-be-forked/)". 
It helps me to have my beloved configuration on every computer I use.

This dotfiles contain only things I use on daily basis, feel free to use every line to create your own.

_Please : don't forget that I am constently building my dotfiles._

## Installation

It's easy, it takes three seconds and only three commands :

	git clone --recursive git@github.com:jbleuzen/dotfiles.git ~/.dotfiles
	cd ~/.dotfiles
	./deploy

If you are lazy (and you should) you can even make it in one second :
	
	git clone --recursive git@github.com:jbleuzen/dotfiles.git ~/.dotfiles && ~/.dotfiles/deploy.sh

## Fonts

For MacVim to play nicely with powerline plugin and the font I use (Menlo Bold:11), I add to install a forked font [from a gist](https://gist.github.com/1627888).
Once donwloaded, you need to install it by double clicking it, and you're done.

## Uninstalling

You find something better, no problems enjoy it!
Uninstallation is easy as well, you just need two commands :

	cd ~/.dotfiles
	./deploy uninstall
