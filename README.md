# NVM.vim
This plugin allows you to manage your node versions through `nvm` within vim, so plugins that use node (like [vim-test](https://github.com/janko-m/vim-test) that actually made me write this thing) may use the right version for the project you're working on

## How to install it
I'm using [neovim](https://github.com/neovim/neovim), and you should too, since it's awesome.
But if you're using vim, just replace the neovim config path in the following examples by the vim one, and you'll be good to go :+1:

### Requirements
You'll need to [install nvm](https://github.com/creationix/nvm#installation) first

After this is done, you will need to create a symlink to one of your nvm node version that will be accessible from your $PATH, so that `which node` returns that symlink's path:
```
$> mkdir -p ~/.config/nvim/bin #This path is used by default by the plugin
$> nvm install 8.12.0
$> ln -snf ~/.nvm/versions/node/v8.12.0/bin/node ~/.config/nvim/bin/node
```
Then add this path your `$PATH`:
```
$> echo 'export PATH="~/.config/nvim/bin/node"'
```

Alternatively, you also just make `/usr/bin/node` point to this path by doing:
```
$> sudo ln -s ~/.config/nvim/bin/node /usr/bin/node
```
(That's the way I did it)


### Using pathogen
```
$> cd ~/.config/nvim
$> mkdir -p bundle
$> cd bundle
$> git clone https://github.com/marene/nvm.vim
```

### Using vundle
Add this to your `init.vim` (or `.vimrc`)
```
set rtp+=~/.config/nvim/bundle/Vundle
call vundle#begin('/home/marene/.config/nvim/bundle') "Put your path, not mine, obviously

Plugin 'marene/nvm.vim'

call vundle#end()
```

## How to use this plugin
This plugin works by updating a symlink in your `$PATH` pointing to an `nvm` node binary each time you want to change the version you're using.

It exposes two commands:
  * `:NvmList`: Opens an horizontal split that displays all available node versions. Hitting <CR> or doubleleft clicking on one of them selects this version
  * `:NvmUse`: If there is a `.nvmrc` file in (neo)vim's current working directory, and it's version of node is installed, will select this version of node
