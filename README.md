###What is it?

A Configuration files for Vim and Bash this configuration work on Mac Os X and Linux

### Dependencies

* Vim
* Tmux
* Git
* Python

### Ubuntu

    $ apt-get install vim-nox tmux git python python-dev python-setuptools

### Mac OS X

**Homebrew:** [http://brew.sh/](http://brew.sh/)

    $ brew install python vim tmux git

#### Override System Python:
    
    $ cd /System/Library/Frameworks/Python.framework/Versions

    $ sudo mv Current Current.bak

    $ sudo ln -s /usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/2.7 Current

### How to install

    $ git clone https://github.com/kevinrobayna/config_workstation.git

    $ cd config_workstation

    $ make deps #Optional

    $ make mac or make linux

### How to Remove Backup files
    
    $ make rm-backup

###What plugins are included?

* [pathogen.vim](https://github.com/tpope/vim-pathogen): Manages the runtime path of the plugins
* [tcomment_vim](https://github.com/tomtom/tcomment_vim):
* [supertab](https://github.com/ervandew/supertab): 
* [syntastic](https://github.com/scrooloose/syntastic): 
* [tlib_vim](https://github.com/tomtom/tlib_vim):
* [vim-addon-mw-utils](https://github.com/MarcWeber/vim-addon-mw-utils):
* [vim-snippets](https://github.com/honza/vim-snippets): 
* [python-mode](https://github.com/klen/python-mode): 
* [handlebars](https://github.com/nono/vim-handlebars):
* [jinja2](https://github.com/Glench/Vim-Jinja2-Syntax):
* [vim-less](https://github.com/groenewege/vim-less):
* [vim-colorschemes](https://github.com/flazz/vim-colorschemes): 
* [vim-golang](https://github.com/jnwhiteh/vim-golang):
* [NERD Tree](https://github.com/scrooloose/nerdtree): A tree explorer plugin for vim
* [ctrlp.vim](https://github.com/kien/ctrlp.vim): Fuzzy file, buffer, mru and tag finder. In my config it's mapped to `<Ctrl+F>`, because `<Ctrl+P>` is used by YankRing
* [vim-airline](https://github.com/bling/vim-airline): Lean & mean status/tabline for vim that's light as air (replacing powerline)
* [vim-fugitive](https://github.com/tpope/vim-fugitive): A Git wrapper so awesome, it should be illegal

