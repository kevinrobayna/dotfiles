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

    $ git clone https://github.com/kevinrobayna/dotfiles.git

    $ cd dotfiles/

    $ make deps #Optional

    $ make mac or make linux

### How to Remove Backup files
    
    $ make rm-backup

