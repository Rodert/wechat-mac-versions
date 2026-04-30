# Wechat-Versions-For-macOS

<sub>Languages: [简体中文](README.md) · [English](README.en.md) · [日本語](README.ja.md) · [Français](README.fr.md) · [Español](README.es.md) · [Русский](README.ru.md) · [한국어](README.ko.md)</sub>

Utilisez ce projet et ses donnees tant qu'ils restent disponibles.

- [Telecharger les anciennes versions de WeChat pour Windows](https://github.com/Rodert/wechat-win-versions)
- [Telecharger les anciennes versions de WeChat pour macOS](https://github.com/Rodert/wechat-mac-versions)

Ce depot collecte et archive les versions de WeChat pour macOS.

## Structure du Repertoire

```shell
├── README.md # README chinois
├── README.en.md # README anglais
├── README.ja.md # README japonais
├── README.fr.md # README francais
├── README.es.md # README espagnol
├── README.ru.md # README russe
├── README.ko.md # README coreen
├── index.html # Page d'affichage GitHub Pages
├── .nojekyll # Fichier de configuration GitHub Pages
├── WeChatSetup # Repertoire temporaire pour les installateurs WeChat
│   └── temp # Repertoire temporaire
└── scripts # Repertoire des scripts
    └── destVersionForMac.sh # Script pour telecharger les installateurs et obtenir les versions/hash
```

## Comment Telecharger les Anciens Installateurs

> Les instructions detaillees sont disponibles sur la [page Wiki](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions).  
> Parcourir les releases en ligne: [GitHub Pages](https://rodert.github.io/wechat-mac-versions/) liste toutes les versions archivees avec des liens de telechargement directs.

Ce depot conserve les anciens installateurs WeChat via GitHub Releases. Pour telecharger une version:

1. Ouvrez la [page Releases](https://github.com/Rodert/wechat-mac-versions/releases) du depot.
2. Recherchez la version souhaitee dans la liste des releases. Elles sont triees par ordre chronologique inverse, avec la plus recente en haut.
3. Ouvrez la page Release correspondante.
4. Telechargez le fichier d'installation `.dmg`.
5. Si necessaire, telechargez aussi le fichier `.sha256` pour verifier l'integrite de l'installateur.

### Demonstration

Le GIF suivant montre le processus complet de telechargement:

![Comment telecharger les anciens installateurs](如何下载历史安装包.gif)

## Remarques

- Mise a jour du 2024-10-01: le projet convertit maintenant le DMG en IMG puis l'extrait afin d'obtenir le numero de version exact de WeChat, par exemple `3.8.9.xx`. Avant cette mise a jour, les deux derniers chiffres de version mineure ne pouvaient pas etre extraits. Un suffixe de date de mise a jour etait donc ajoute pour distinguer les builds mineurs sous la meme version majeure. Veuillez verifier attentivement avant de telecharger les anciennes versions.

Ce projet utilise GitHub Actions pour telecharger automatiquement le dernier installateur officiel de WeChat, calculer sa valeur de hash et le publier dans GitHub Releases. Il n'est actuellement pas prevu d'archiver les installateurs de l'App Store.

Les journaux de modifications des versions sont disponibles dans le [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true) officiel de WeChat.

Pour toute question ou demande liee a une atteinte aux droits, veuillez ouvrir une issue.
