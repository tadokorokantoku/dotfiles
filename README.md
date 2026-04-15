# dotfiles

## Setup

```bash
git clone https://github.com/tadokorokantoku/dotfiles.git ~/.dotfiles
```

clone 先が `~/.dotfiles` でない場合は、次のコマンド内の `$HOME/.dotfiles` と `source` 行の `~/.dotfiles` を実際のパスに合わせてください。

```bash
git config --global --get-all include.path 2>/dev/null | grep -qxF "$HOME/.dotfiles/git/gitconfig" || git config --global --add include.path "$HOME/.dotfiles/git/gitconfig"; touch ~/.zshrc && { grep -qxF 'source ~/.dotfiles/zsh/aliases.zsh' ~/.zshrc || echo 'source ~/.dotfiles/zsh/aliases.zsh' >> ~/.zshrc; }
```
