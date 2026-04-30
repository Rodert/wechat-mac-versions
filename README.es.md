# Wechat-Versions-For-macOS

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [Español](README.es.md) | [Русский](README.ru.md) | [한국어](README.ko.md)

Usa este proyecto y sus datos mientras sigan disponibles.

- [Descargar versiones historicas de WeChat para Windows](https://github.com/Rodert/wechat-win-versions)
- [Descargar versiones historicas de WeChat para macOS](https://github.com/Rodert/wechat-mac-versions)

Este repositorio recopila y archiva versiones de WeChat para macOS.

## Estructura del Directorio

```shell
├── README.md # README en chino
├── README.en.md # README en ingles
├── README.ja.md # README en japones
├── README.fr.md # README en frances
├── README.es.md # README en espanol
├── README.ru.md # README en ruso
├── README.ko.md # README en coreano
├── index.html # Pagina de GitHub Pages
├── .nojekyll # Archivo de configuracion de GitHub Pages
├── WeChatSetup # Directorio temporal para instaladores de WeChat
│   └── temp # Directorio temporal
└── scripts # Directorio de scripts
    └── destVersionForMac.sh # Script para descargar instaladores y obtener version/hash
```

## Como Descargar Instaladores Historicos

> Las instrucciones detalladas estan disponibles en la [pagina Wiki](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions).  
> Para explorar releases en linea, [GitHub Pages](https://rodert.github.io/wechat-mac-versions/) muestra todas las versiones archivadas con enlaces directos de descarga.

Este repositorio guarda los instaladores historicos de WeChat mediante GitHub Releases. Para descargar una version:

1. Abre la [pagina Releases](https://github.com/Rodert/wechat-mac-versions/releases) del repositorio.
2. Busca la version que necesitas en la lista de releases. Estan ordenadas en orden cronologico inverso, con la version mas reciente arriba.
3. Abre la pagina Release correspondiente.
4. Descarga el archivo instalador `.dmg`.
5. Opcionalmente, descarga tambien el archivo `.sha256` para verificar la integridad del instalador.

### Demostracion

El siguiente GIF muestra el flujo completo de descarga:

![Como descargar instaladores historicos](如何下载历史安装包.gif)

## Notas

- Actualizacion del 2024-10-01: el proyecto ahora convierte el DMG a IMG y lo extrae para obtener el numero de version exacto de WeChat, por ejemplo `3.8.9.xx`. Antes de esta actualizacion, no se podian extraer los dos ultimos digitos de version menor, por lo que se agregaba un sufijo con la fecha de actualizacion para distinguir builds menores dentro de la misma version principal. Revisa cuidadosamente antes de descargar versiones antiguas.

Este proyecto usa GitHub Actions para descargar automaticamente el instalador oficial mas reciente de WeChat, calcular su hash y publicarlo en GitHub Releases. Actualmente no hay planes para archivar instaladores de la App Store.

Los registros de cambios de cada version estan disponibles en el [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true) oficial de WeChat.

Si tienes preguntas o inquietudes sobre infraccion de derechos, abre una issue.
