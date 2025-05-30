FZF + Vim Quick Opener (fv Command)

What You Did

You created a custom fv command to:

Use fzf to fuzzy-search files recursively from the current directory.

Open the selected file in vim by pressing Ctrl + V.

Setup Instructions

Add the following function to your .zshrc:

fv() {
  find . -type f | fzf --bind "ctrl-v:execute(vim {})"
}

Then reload your shell config:

source ~/.zshrc

How to Use It

In any directory, type:

fv

Fuzzy-search through files.

Press Ctrl + V to open the highlighted file in vim.

Requirements

fzf

vim
