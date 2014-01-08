### Dependencies

* Vim
* Tmux
* Git
* Python

### Linux

    $ apt-get install vim-nox tmux git python python-dev python-setuptools

### Mac OS X

**Homebrew:** [http://brew.sh/](http://brew.sh/)

    $ brew install python vim tmux git

#### Override System Python:
    
    $ cd /System/Library/Frameworks/Python.framework/Versions

    $ sudo mv Current Current.bak

    $ sudo ln -s /usr/local/Cellar/python/2.7.3/Frameworks/Python.framework/Versions/2.7 Current

### How to install

    $ git clone https://github.com/kevinrobayna/dotfiles.git

    $ cd dotfiles/

    $ make deps #Optional

           [ mac #setup for mac enviroment
    $ make | linux #setup for common linux enviroment
           [ cc #setup for cc of ULL

### How to Remove Backup files
    
    $ make rm-backup

