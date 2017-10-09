# Code for 選挙 Wikidataインポートコマンド生成用

## 使い方

ざっくりメモ程度に書いておきます。

* `git clone https://github.com/takahashim/cfej_import_wikidata.git`などと実行してこのプロジェクトのファイルを取得する
* 前準備: GoogleアカウントのOAuth2認証用のclient_secret.jsonを作成して保存しておく
* コンソールから `bundle exec ruby create_importcommands.rb` と入力して実行する
* 出てくるURLをブラウザに入力し、OAuth2認証を行う
* 実行途中のコンソールに戻って、ブラウザに表示されたコードを入力する
* コマンドが標準出力から出力されるので、出力結果をファイル等で保存する
* https://tools.wmflabs.org/quickstatements/ の「Import commands」メニューからコピペで登録する（要ログイン）


## インポートコマンドの形式

登録済みデータの更新ではなく、新規の登録については、以下のような形式になります。

```
CREATE
LAST	Lja	"田中一郎"
CREATE
LAST	Lja	"田中二郎"
```

「LAST」と「Lja」の間、「Lja」と人名の間はタブです。
各データを投入する際に毎回「CREATE」行を用意する必要があります。これがないと同じWikidata IDに上書きされます（そのため最後の一行しか有効にならない）。

## ライセンス

MIT
