vim
===

This is my Vim configuration.

## Installation

```bash
git clone https://github.com/kovagoz/vim.git ~/.vim
~/.vim/install.sh
```

## Install vim

```bash
hg clone https://vim.googlecode.com/hg/ vim
cd vim/src
./configure --enable-luainterp=yes --enable-pythoninterp=yes --prefix=$HOME
make && make install
```
