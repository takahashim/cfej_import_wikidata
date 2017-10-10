# Code for 選挙 Wikidataインポートコマンド生成用

GrayDBのデータを元に、https://tools.wmflabs.org/quickstatements/ からインポートできるコマンドを生成します。
[Ruby Quickstart](https://developers.google.com/sheets/api/quickstart/ruby)のサンプルを元にしたものです。

## インストール

```
$ git clone https://github.com/takahashim/cfej_import_wikidata.git
$ cd cfej_import_wikidata
$ bundle install
```

## 使い方

ざっくりメモ程度に書いておきます。

1. 前準備: GoogleアカウントのOAuth2認証用のclient_secret.jsonを作成して保存しておく
   (これが説明しづらい… https://developers.google.com/sheets/api/quickstart/ruby の「Step 1: Turn on the Google Sheets API」を粛々と実行します。)
2. コンソールから `bundle exec ruby create_importcommands.rb` と入力して実行する
3. 出てくるURLをブラウザに入力し、OAuth2認証を行う
4. 実行途中のコンソールに戻って、ブラウザに表示されたコードを入力する
5. コマンドが標準出力から出力されるので、出力結果をファイル等で保存する
6. https://tools.wmflabs.org/quickstatements/ の「Import commands」メニューからコピペで登録する（要ログイン）

一回実行すれば3.〜5.は省略されます。

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

MIT License です。
