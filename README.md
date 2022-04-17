# KabuCalculator
統計指標に基づく、株式比較、抽出ツールです。
株を安く買って高く売ろうとしても、たくさんの株式が存在し、
価格が安い株どれか、リターンの高い株はどれか、分からないことが多々あります。
KabuCalculatorは、これらの疑問に答える統計指標を提供し、株式を比較、抽出することを支援します。



# 本番環境
このサービスの本番環境ではAWSを使用しています。

- Route 53

ドメインとインスタンスの紐付け
- EC2

インスタンスと呼ばれる仮想コンピューティング環境

![システム構成](/docs/system_structure.png)

# 開発環境

ウェブサーバ、アプリケーションサーバ、データベースサーバ、バッチシステムごとにDockerコンテナを作成し、開発を行います。

![Docker構成図](/docs/docker_structure.png)

開発開始する場合は事前にDockerとDocker Composeをインストールする必要があります。

### ウェブサーバ

  - Nginx latest

### アプリケーションサーバ

  - Ruby 3.0.3
  - Rails 6.1.4 

### データベースサーバ

  - MySQL 5.7
### バッチシステム

  - Python 3.9

### 環境変数の設定

  |環境変数名|説明|
  |----------|----|
  |DB_HOST|データベースのホスト名|
  |DB_PORT|データベースサーバのポート番号|
  |DB_DATABASE|`development`もしくは`production`|
  |DB_USERNAME|データベースのユーザ名|
  |DB_PASSWORD|データベースのユーザパスワード|
  |DB_ROOT_PASSWORD|データベースのルートユーザパスワード|
  |DB_TABLE|`indicators`|
  |ENVIRONMENT|`development`もしくは`production`|
  |SELENIUM_DRIVER_URL|`http://selenium_chrome:4444/wd/hub`※システムテストをするときに使用するSeleniumのコンテナにアプリケーションサーバ側から接続するための設定|

# インストール
プロジェクトルートで以下コマンドを実行してください。
```
docker-compose -f docker-compose.dev.yml up -d
```

データベースへのデータ投入に開発環境であれば10分ほど時間を要します。
少し待っていただき、`localhost:3000`につないでみてください。

# テスト

### アプリケーションサーバ

```
docker exec kabucalculator_appserver_1 bin/setup
docker exec kabucalculator_appserver_1 rails test:all
```

### バッチシステム

```
docker exec kabucalculator_batch_1 /bin/bash -c 'cd test && python -m unittest'
```

# Lint

### アプリケーションサーバ

Rubyのコードについては以下のコマンドをご使用ください。

```
docker exec kabucalculator_appserver_1 rubocop
```

JavaScriptのコードについては以下のコマンドをご使用ください。

```
docker exec kabucalculator_appserver_1 yarn run lint
```

### バッチシステム

```
docker exec kabucalculator_batch_1 python -m flake8 test lib --exclude python3.9
```

# スクリーンショット

### 銘柄抽出画面

- 指標一覧
![スクリーンショット(指標一覧)](/docs/screenshot_indicators_index.png)

- グラフ
![スクリーンショット(グラフ)](/docs/screenshot_indicators_graph.png)

### 各指標の補足説明
- 補足説明
![スクリーンショット(補足説明)](/docs/screenshot_additionals.png)
