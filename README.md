# dotfiles

## Setup

```bash
git clone https://github.com/tadokorokantoku/dotfiles.git ~/.dotfiles
```

メインの `~/.gitconfig` からこのリポジトリの共有設定（`git/gitconfig`）を読み込むには、次を実行します。

```bash
git config --global --add include.path ~/.dotfiles/git/gitconfig
```

別の場所に clone した場合は、パスを合わせてください。既に `include.path` がある環境では `--add` で追記されます。重複した行が気になる場合は `~/.gitconfig` を編集して整理してください。

`.zshrc` に以下を追加:

```bash
source ~/.dotfiles/zsh/aliases.zsh
```

シェルを再起動するか `source ~/.zshrc` で反映。
