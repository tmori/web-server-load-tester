# web-server-load-tester

`web-server-load-tester` は、Webサーバーの負荷テストを実行するための簡易テストフレームです。

「簡易」とあえて添えているのは、あまり複雑な作りにせず、可読性があり、本フレームワークを利用する人が簡単に改造できるような構造を目指したいためです。

Webサーバーの負荷テストでは、Web APIを連続して多重で実行するケースが多いと思われ、本フレームワークでは、「連続実行」と「多重実行」する機能を提供します。

Web API発行部分やテスト結果の確認部分は、プラグイン(インタフェース実装)として個別開発する形となります。


## 機能概要
テスト項目に共通する環境設定情報は、env/env.bash にて、環境変数で定義します。
テスト項目は、csv ファイル(サンプル)で定義します。

テストフレームワークは、csv で定義されたテスト項目ファイルをパースして、全テスト項目を自動実行してくれます。
テスト実行時には、各項目に応じた多重度、連続実行数、test-impl内の呼び出すプログラムをピックアップして実行します。

ここで、テスト実行の親玉は、[test-controller.bash](https://github.com/tmori/web-server-load-tester/blob/main/test-runtime/test-controller.bash) であり、bash スクリプトで 50 行程度でコーディングされていますので、bash スクリプト使える方なら簡単に理解できると思います。

テスト項目実行部分は、[test-runner.bash](https://github.com/tmori/web-server-load-tester/blob/main/test-runtime/test-runner.bash) であり、こちらも bash スクリプトで 30 行程度でコーディングされています。わりと簡単に理解できると思われます。

## テストフレームワーク設計
テストフレームワークのクラス設計は下図のとおりです。

![image](https://user-images.githubusercontent.com/164193/192410192-891b91b0-22c5-405a-90d7-e215387942f8.png)

## ファイル構成
ファイル構成は以下の通りです。

* `[]`内の説明は、クラスパッケージに相当します。
* `[*ユーザ定義部分*]` は、プラグイン部分になります。

```
web-server-load-tester
├── env [環境設定]
│   └── env.bash[*ユーザ定義部分*]
├── test-item [テスト項目]
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
├── test-logger [テスト用ロガーツール]
└── test-utils [共通ライブラリ]
```

