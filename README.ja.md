# Wechat-Versions-For-macOS

<sub>Languages: [简体中文](README.md) · [English](README.en.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [Español](README.es.md) · [Русский](README.ru.md) · [한국어](README.ko.md)</sub>

このプロジェクトとデータは、利用できるうちにご利用ください。

- [Windows 版 WeChat の過去バージョンをダウンロード](https://github.com/Rodert/wechat-win-versions)
- [macOS 版 WeChat の過去バージョンをダウンロード](https://github.com/Rodert/wechat-mac-versions)

このリポジトリは、macOS 版 WeChat の各バージョンを収集し、アーカイブします。

## ディレクトリ構成

```shell
├── README.md # 中国語 README
├── README.en.md # 英語 README
├── README.ja.md # 日本語 README
├── README.fr.md # フランス語 README
├── README.es.md # スペイン語 README
├── README.ru.md # ロシア語 README
├── README.ko.md # 韓国語 README
├── index.html # GitHub Pages の表示ページ
├── .nojekyll # GitHub Pages 設定ファイル
├── WeChatSetup # WeChat インストーラーの一時ディレクトリ
│   └── temp # 一時ディレクトリ
└── scripts # スクリプトディレクトリ
    └── destVersionForMac.sh # インストーラーの取得、バージョン番号、ハッシュ値を取得するスクリプト
```

## 過去のインストーラーをダウンロードする方法

> 詳しい使い方は [Wiki ページ](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions) を参照してください。  
> オンラインで Releases を閲覧する場合は、[GitHub Pages](https://rodert.github.io/wechat-mac-versions/) からすべてのアーカイブ済みバージョンを確認し、直接ダウンロードできます。

このリポジトリでは、GitHub Releases を使って WeChat の過去バージョンのインストーラーを保存しています。ダウンロード手順は次のとおりです。

1. このリポジトリの [Releases ページ](https://github.com/Rodert/wechat-mac-versions/releases) を開きます。
2. リリース一覧から必要なバージョンを探します。一覧は新しい順で、最新バージョンが一番上に表示されます。
3. 対象バージョンの Release ページを開きます。
4. `.dmg` インストーラーファイルをダウンロードします。
5. 必要に応じて `.sha256` ファイルもダウンロードし、インストーラーの整合性を確認します。

### 操作デモ

次の GIF は、ダウンロード手順全体を示しています。

![過去のインストーラーをダウンロードする方法](如何下载历史安装包.gif)

## 補足

- 2024-10-01 更新: DMG を IMG に変換して展開することで、`3.8.9.xx` のような正確な WeChat バージョン番号を取得できるようになりました。この更新以前は末尾 2 桁の小バージョン番号を取得できなかったため、同じメジャーバージョン内の小さな差分を区別するために更新日のサフィックスを追加していました。古いバージョンをダウンロードする前に、ご自身で確認してください。

このプロジェクトは GitHub Actions を使用して、WeChat 公式サイトの最新インストーラーを自動的にダウンロードし、ハッシュ値を計算して GitHub Releases に公開します。現時点では、App Store 版インストーラーを保存する予定はありません。

各バージョンの更新履歴は、公式の [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true) を参照してください。

質問や権利侵害に関する連絡がある場合は、issue を作成してください。
