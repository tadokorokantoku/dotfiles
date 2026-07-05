# Element Screenshot Skill

指定されたWebページの特定要素のスクリーンショットを撮影する。
ビフォーアフターの比較用スクショなど、フロント開発のレビューに使う。

## 前提

- `agent-browser` がインストール済みであること（`npm i -g agent-browser`）
- macOS環境であること（`sips` コマンドを使用）

## 事前準備

agent-browserの基本操作（snapshot、ref、wait等）に不慣れな場合は、まずcore skillを読むこと：

```bash
agent-browser skills get core
```

## 手順

### 1. ページを開く

```bash
agent-browser open <url>
```

開発中のローカルサーバーの場合は `http://localhost:3000/path` など。

### 2. 対象要素を特定する

スナップショットを取得して、ページの構造と要素の参照（`@eN`）を確認する。

```bash
agent-browser snapshot -i
```

ユーザーが指定した箇所がどの要素に対応するかを判断し、CSSセレクタを決定する。
必要に応じてスコープを絞る：

```bash
agent-browser snapshot -s "#main" -i
```

### 3. 要素をビューポート内にスクロールする

```bash
agent-browser scrollintoview @eN
```

### 4. 要素の座標を取得する

`eval --stdin` を使ってBoundingClientRectを取得する。
CSSセレクタは手順2で特定したものを使う。

```bash
cat <<'JSEOF' | agent-browser eval --stdin
(() => {
  const el = document.querySelector('YOUR_CSS_SELECTOR');
  if (!el) throw new Error('Element not found');
  const r = el.getBoundingClientRect();
  return Math.round(r.x) + ',' + Math.round(r.y) + ',' + Math.round(r.width) + ',' + Math.round(r.height);
})()
JSEOF
```

出力は `"x,y,w,h"` 形式。二重クォートを除去してパースする。

### 5. スクリーンショットを撮影する

```bash
agent-browser screenshot /tmp/viewport.png
```

### 6. 要素部分をクロップする

```bash
cp /tmp/viewport.png <output_path>
sips --cropToHeightWidth <H> <W> --cropOffset <Y> <X> <output_path> > /dev/null
```

引数の順番に注意：
- `--cropToHeightWidth` は **Height Width** の順
- `--cropOffset` は **Y X** の順

### 7. ブラウザを閉じる

撮影が全て終わったら閉じる。連続して複数のスクショを撮る場合は閉じずに続ける。

```bash
agent-browser close
```

## ビフォーアフター撮影の流れ

1. 修正前のブランチで対象ページのスクショを撮る → `before.png`
2. 修正後のブランチに切り替える
3. 同じページ・同じ要素のスクショを撮る → `after.png`
4. 両方の画像をPRに貼り付ける

## 注意事項

- `agent-browser eval` はグローバルスコープを共有するため、必ずIIFE `(() => { ... })()` でラップすること
- スクロール後は座標が変わるため、`scrollintoview` の後に座標を取得すること
- ページの読み込みが完了する前に操作するとずれるので、必要に応じて `agent-browser wait --load networkidle` を入れること
