# web-server-load-tester

`web-server-load-tester` は、Webサーバーの負荷テストを実行するための簡易テストフレームです。

「簡易」とあえて添えているのは、あまり複雑な作りにせず、可読性があり、本フレームワークを利用する人が簡単に改造できるような構造を目指したいためです。

Webサーバーの負荷テストでは、Web APIを連続して多重で実行するケースが多いと思われ、本フレームワークでは、「連続実行」と「多重実行」する機能を提供します。

Web API発行部分やテスト結果の確認部分は、プラグイン(インタフェース実装)として個別開発する形となります。


## 機能概要
テスト項目に共通する環境設定情報は、[env.bash](https://github.com/tmori/web-server-load-tester/blob/main/env/env.bash) にて、[環境変数](https://github.com/tmori/web-server-load-tester/blob/main/README.md#%E7%92%B0%E5%A2%83%E5%A4%89%E6%95%B0)で定義します。
テスト項目は、csv ファイル([サンプル](https://github.com/tmori/web-server-load-tester/blob/main/test-item/sample-test-item.csv))で定義します。

テストフレームワークは、csv で定義されたテスト項目ファイルをパースして、全テスト項目を自動実行してくれます。
テスト実行時には、各項目に応じた多重度、連続実行数、test-impl ディレクトリ内の呼び出すプログラムをピックアップして実行します。

ここで、テスト実行の親玉は、[test-controller.bash](https://github.com/tmori/web-server-load-tester/blob/main/test-runtime/test-controller.bash) であり、bash スクリプトで 100 行程度でコーディングされていますので、bash スクリプト使える方なら簡単に理解できると思います。

テスト項目実行部分は、[test-runner.bash](https://github.com/tmori/web-server-load-tester/blob/main/test-runtime/test-runner.bash) であり、こちらも bash スクリプトで 30 行程度でコーディングされています。わりと簡単に理解できると思われます。

## インストール手順

本リポジトリをクローンするだけです。

```
git clone https://github.com/tmori/web-server-load-tester.git
```

## セットアップ手順

1. [env.bash](https://github.com/tmori/web-server-load-tester/blob/main/env/env.bash) の[環境変数](https://github.com/tmori/web-server-load-tester/blob/main/README.md#%E7%92%B0%E5%A2%83%E5%A4%89%E6%95%B0)を定義してください。
2. csv ファイルでテスト項目を定義してください。(注意：カンマの間に空白を含めないこと)
3. テスト項目で定義したテストプログラムを作成して、適切なディレクトリ配下に配置してください。

## テスト実行手順

セットアップ完了後、本リポジトリのトップディレクトリで以下のコマンドを実行してください。

```
bash test-runtime/test-controller.bash <テスト項目(csvファイル)>
```

テスト実行すると、[logディレクトリ](https://github.com/tmori/web-server-load-tester/tree/main/log) 直下に、test-<テスト項目番号>.log としてログ出力されます。

テスト実行例：

```
$ bash test-runtime/test-controller.bash test-item/sample-test-item.csv
INFO: 2022年  9月 27日 火曜日 10:58:15 JST : SETUP TEST...
INFO: 2022年  9月 27日 火曜日 10:58:15 JST : ID=1:PREPARE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:16 JST : ID=1, RID=1:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:17 JST : ID=1, RID=2:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:18 JST : ID=1, RID=3:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:19 JST : ID=1, RID=4:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:20 JST : ID=1, RID=5:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : ID=1:DONE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : TEARDOWN TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : SETUP TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : ID=2:PREPARE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : ID=1:PREPARE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : ID=2, RID=1:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:21 JST : ID=1, RID=1:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:22 JST : ID=2, RID=2:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:22 JST : ID=1, RID=2:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:23 JST : ID=1, RID=3:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:23 JST : ID=2, RID=3:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:24 JST : ID=1, RID=4:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:24 JST : ID=2, RID=4:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:26 JST : ID=2, RID=5:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:26 JST : ID=1, RID=5:DOING TEST...
INFO: 2022年  9月 27日 火曜日 10:58:27 JST : ID=2:DONE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:27 JST : ID=1:DONE TEST...
INFO: 2022年  9月 27日 火曜日 10:58:27 JST : TEARDOWN TEST...
```

## 性能測定対象
以下の性能を測定します。

* [スループット](https://github.com/tmori/web-server-load-tester/blob/46404ae7425b0df4afcdfcd40110e5c8f241b516/test-utils/perf/perf.bash#L39-L59)[単位：Do処理数/sec]
  * 定義：( 多重度 × 連続実行数 ) / Do 処理に要する時間[sec]
* [レスポンスタイム](https://github.com/tmori/web-server-load-tester/blob/46404ae7425b0df4afcdfcd40110e5c8f241b516/test-utils/perf/perf.bash#L39-L59)[単位：sec/回(Do毎)]
  * 定義：( Σ各Web API応答時間[sec] ) / ( 多重度 × 連続実行数 )
* [CPU使用率](https://github.com/tmori/web-server-load-tester/blob/main/test-utils/perf/sar-cpu.bash)[単位：%]
  * sar コマンドで CPU idle を監視し、テスト実行前後で増えたCPU使用率を計測
* [メモリ使用量](https://github.com/tmori/web-server-load-tester/blob/main/test-utils/perf/sar-mem.bash)[単位：GB]
  * sar コマンドでメモリ使用量(kbmemused) を監視し、テスト実行前後で増えたメモリ使用量を計測
* [データ使用量](https://github.com/tmori/web-server-load-tester/blob/main/test-utils/perf/perf.bash#L88-L128)[単位：GB]
  * df コマンドで`TEST_DISK_DEV`で定義されたデバイスの監視し、テスト実行前後で増えたディスク使用量を計測
* DBテーブルの総サイズ[単位：MB]
  * 利用しているデータベースの全DBテーブルの総サイズが、テスト実行前後で増えた量を計測
    * [postgres 向け計測SQL](https://github.com/tmori/web-server-load-tester/blob/main/test-utils/db/postgresql/template/table_stat_sql.tpl)
    * [mysql向け計測SQL](https://github.com/tmori/web-server-load-tester/blob/main/test-utils/db/mysql/template/table_stat_sql.tpl)

## テストフレームワーク設計
テストフレームワークのクラス設計は下図のとおりです。

![image](https://user-images.githubusercontent.com/164193/192410192-891b91b0-22c5-405a-90d7-e215387942f8.png)

## テスト実行フロー
テスト実行フローは下図の通りです。

![image](https://user-images.githubusercontent.com/164193/192419122-1db21283-4ce6-4d99-a17c-291ab4bc1283.png)


## ファイル構成
ファイル構成は以下の通りです。

* `[]`内の説明は、クラスパッケージに相当します。
* `[*ユーザ定義部分*]` は、プラグイン部分になります。

```
web-server-load-tester
├── env [環境設定]
│   └── env.bash[*ユーザ定義部分*]
├── test-item [テスト項目]
├── test-result [テスト結果]
├── test-runtime [テスト・ランタイム共通部]
│   ├── test-controller.bash
│   └── test-runner.bash
├── test-impl [テスト・実装部]
│   └── sample[*]
│       ├── controller
│       │   ├── setup
│       │   │   └── sample-setup.bash[*ユーザ定義部分*]
│       │   └── teardown
│       │       └── sample-teardown.bash[*ユーザ定義部分*]
│       └── runner
│           ├── do
│           │   └── sample-do.bash[*ユーザ定義部分*]
│           ├── done
│           │   └── sample-done.bash[*ユーザ定義部分*]
│           └── prepare
│               └── sample-prepare.bash[*ユーザ定義部分*]
├── log [ログファイル配置]
│   ├── perf[性能測定結果格納ディレクトリ]
│   └── test-<TestNo>.log [テスト実行ログ]
├── test-logger [テスト用ロガーツール]
└── test-utils [共通ライブラリ]
```

## 環境変数

* WEB_SERVER_URL(変更可)
  * テスト対象となるWebサーバーのURLです。
  * テスト内容に応じて、自由に変更ください
* TOP_DIR(変更不可)
  * 本フレームワークのトップディレクトリです。
  * 変更しないでください。
* TEST_TARGET(変更可)
  * test-impl ディレクトリの中で、テスト対象とするテスト実装のトップディレクトリ名です。
  * デフォルト以外の設定にしたい場合は、自由に変更ください。
* TEST_IMPL_DIR(変更可)
  * test-impl ディレクトリのトップディレクトリパスです。
  * デフォルト以外の設定にしたい場合は、自由に変更ください。
* TEST_ITEM_DIR(変更可)
  * test-item ディレクトリのトップディレクトリパスです。
  * デフォルト以外の設定にしたい場合は、自由に変更ください。
* TEST_RNTM_DIR(変更不可)
  * テストツール群のトップディレクトリです。
  * 変更しないでください。
* TEST_LOGGER(変更可)
  * テストで利用するロガー配置ディレクトリです。
  * デフォルトのものと差し替えた場合は変更してください。
* TEST_LOGPATH(変更可)
  * テストログ配置ディレクトリです。
  * デフォルトのものと差し替えた場合は変更してください。
* TEST_PERFPATH(変更可)
  * スループットとレスポンスタイムを計算するための性能ログ情報配置ディレクトリです。
    * ディレクトリ：item-<テスト項目番号>
    * スループット向け：elaps_ms.txt (prepare, do, doneの総処理時間をmsec単位で保存します)
    * レスポンスタイム向け：response_time-<多重度ID> (多重実行される各 do 処理時間を time -p で計測した結果を保存します)
    * 平均レスポンス時間[ミリ秒/件]：response_time_ms.txt
    * スループット[件/秒]：throughput.txt
  * デフォルトのものと差し替えた場合は変更してください。
* TEST_RESULTPATH(変更可)
  * テスト結果格納ディレクトリです。
  * デフォルトのものと差し替えた場合は変更してください。
* TEST_TARGET_TOOL_DIR(変更可)
  * Webサーバー側に本フレームワークを配置するディレクトリ(絶対パス)
  * テスト環境にあわせて変更してください
* TEST_SSH_ACCOUNT(変更可)
  * WebサーバーのSSHログインアカウント
  * テスト環境にあわせて変更してください
  * テスト自動実行するため、パスワードなしでログインできるようにセッティングしてください
* TEST_SAR_ENABLE(変更可)
  * sarコマンドでの監視を可能にする場合は、本変数を有効化してください。
  * 本変数を無効化すると、CPU使用率、メモリ使用量は計測されません。
* TEST_DISK_DEV(変更可)
  * df コマンドで監視を可能にする場合は、対象デバイスを設定してください。
  * テスト環境にあわせて変更してください
* DB_TYPE(変更可)
  * DBテーブル使用量の監視を可能にする場合は、対象DBのRMDBSの種類(mysql or postgresql)を設定してください。
  * テスト環境にあわせて変更してください
* MYSQL_DB_NAME(変更可)
  * 観測対象とするデータベース名(mysql向け)
* MYSQL_USER(変更可)
  * 観測対象とするデータベースのユーザアカウント(mysql向け)
* MYSQL_PASSWD(変更可)
  * 観測対象とするデータベースのユーザパスワード(mysql向け)
* POSTGRES_DB_NAME(変更可)
  * 観測対象とするデータベース名(postgresql向け)
* POSTGRES_USER(変更可)
  * 観測対象とするデータベースのユーザパスワード(postgresql向け)
* POSTGRES_PASSWD(変更可)
  * 観測対象とするデータベースのユーザパスワード(postgresql向け)

# テスト項目

テスト項目の内容は、以下のとおりです。
必要な項目を埋めて頂くことで、テスト自動実行させることができます。

* No
  * テスト項目番号
* Multiplicity
  * 多重実行数
* SetUp
  * テスト実施前のセットアッププログラム名
* TearDown
  * テスト実施後の後始末プログラム名
* Prepare
  * テスト事前準備用のプログラム名
* Do
  * テスト実行プログラム名
* Done
  * テスト終了時に実行するプログラム名
* DoRepeatNum
  * Do プログラムを実行する回数(連続実行数)
