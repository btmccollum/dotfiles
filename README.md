[dotfiles]
========

Primarily used with MacOS, copy what you like or install the full thing at your discretion. 

- editor(s):
  - [doom-emacs](https://github.com/hlissner/doom-emacs)
  - [neovim](https://github.com/neovim/neovim)
  
- terminal:
  - [kitty](https://github.com/kovidgoyal/kitty)
  
- notable inclusions (check Brewfile for more):
  - [Ruby Environment Manager (RVM)](https://github.com/anishathalye/dotbot#configuration)
  - [Oh My Zsh](https://github.com/ohmyzsh/ohmyzsh/)
  - [Emacs Plus](https://github.com/d12frosted/homebrew-emacs-plus)

## Installation

Please be sure to take a look through everything before deciding to copy the entire setup.

### Full Installation

This repo includes the [dotbot] installer as a submodule, so
installation is pretty easy. Please be aware this installs **everything** and
is done at your own discretion.

Install with the following command:

```
git clone https://github.com/btmccollum/dotfiles.git && cd ~/dotfiles && ./install
```

### vimrc
 
In the process of switching to *doom-emacs* but also keeping my vim config here.

The [vimrc] file is my configuration file for the *neovim* text editor.

You'll need to run `:PlugInstall` to install all plugins. 
More information can be found by opening the [vimrc] file and
reading the comments.

## Libraries Used

- [dotbot](https://github.com/anishathalye/dotbot#configuration): Dotfile installer
