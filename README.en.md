# Wechat-Versions-For-macOS

<sub>Languages: [Simplified Chinese](README.md) · [English](README.en.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [Español](README.es.md) · [Русский](README.ru.md) · [한국어](README.ko.md)</sub>

Use this project and its data while they remain available.

- [Download historical WeChat for Windows versions](https://github.com/Rodert/wechat-win-versions)
- [Download historical WeChat for macOS versions](https://github.com/Rodert/wechat-mac-versions)

This repository collects and archives WeChat for macOS versions.

## Directory Structure

```shell
├── README.md # Chinese README
├── README.en.md # English README
├── README.ja.md # Japanese README
├── README.fr.md # French README
├── README.es.md # Spanish README
├── README.ru.md # Russian README
├── README.ko.md # Korean README
├── index.html # GitHub Pages display page
├── .nojekyll # GitHub Pages configuration file
├── WeChatSetup # Temporary directory for WeChat installers
│   └── temp # Temporary directory
└── scripts # Scripts directory
    └── destVersionForMac.sh # Script for downloading installers and getting version/hash values
```

## How to Download Historical Installers

> Detailed instructions are available on the [Wiki page](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions).  
> Browse releases online: [GitHub Pages](https://rodert.github.io/wechat-mac-versions/) lists all archived versions with direct download links.

This repository stores historical WeChat installer packages through GitHub Releases. To download a version:

1. Open the repository [Releases page](https://github.com/Rodert/wechat-mac-versions/releases).
2. Find the version you need in the release list. Releases are sorted in reverse chronological order, with the newest version at the top.
3. Open the corresponding Release page.
4. Download the `.dmg` installer package.
5. Optionally download the `.sha256` file to verify installer integrity.

### Demo

The following GIF shows the complete download flow:

![How to download historical installers](如何下载历史安装包.gif)

## Notes

- Updated on 2024-10-01: the project now converts the DMG to IMG and extracts it to obtain the exact WeChat version number, such as `3.8.9.xx`. Before this update, the last two minor version digits could not be extracted, so an update-date suffix was added to distinguish minor builds under the same major version. Please check carefully before downloading older versions.

This project uses GitHub Actions to automatically download the latest official WeChat installer, calculate its hash value, and publish it to GitHub Releases. There is currently no plan to archive App Store installer packages.

Version changelogs are available on the official WeChat [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true).

If you have questions or infringement concerns, please open an issue.
