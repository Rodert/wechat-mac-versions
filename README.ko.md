# Wechat-Versions-For-macOS

[简体中文](README.md) | [English](README.en.md) | [日本語](README.ja.md) | [Français](README.fr.md) | [Español](README.es.md) | [Русский](README.ru.md) | [한국어](README.ko.md)

이 프로젝트와 데이터는 이용 가능한 동안 사용해 주세요.

- [Windows용 WeChat 이전 버전 다운로드](https://github.com/Rodert/wechat-win-versions)
- [macOS용 WeChat 이전 버전 다운로드](https://github.com/Rodert/wechat-mac-versions)

이 저장소는 macOS용 WeChat 버전을 수집하고 보관합니다.

## 디렉터리 구조

```shell
├── README.md # 중국어 README
├── README.en.md # 영어 README
├── README.ja.md # 일본어 README
├── README.fr.md # 프랑스어 README
├── README.es.md # 스페인어 README
├── README.ru.md # 러시아어 README
├── README.ko.md # 한국어 README
├── index.html # GitHub Pages 표시 페이지
├── .nojekyll # GitHub Pages 설정 파일
├── WeChatSetup # WeChat 설치 패키지 임시 디렉터리
│   └── temp # 임시 디렉터리
└── scripts # 스크립트 디렉터리
    └── destVersionForMac.sh # 설치 패키지 다운로드, 버전 번호, hash 값을 가져오는 스크립트
```

## 이전 설치 패키지 다운로드 방법

> 자세한 사용 방법은 [Wiki 페이지](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions)를 참고하세요.  
> 온라인에서 releases를 보려면 [GitHub Pages](https://rodert.github.io/wechat-mac-versions/)에서 모든 보관 버전을 확인하고 직접 다운로드할 수 있습니다.

이 저장소는 GitHub Releases를 통해 WeChat의 이전 설치 패키지를 보관합니다. 다운로드 방법은 다음과 같습니다.

1. 이 저장소의 [Releases 페이지](https://github.com/Rodert/wechat-mac-versions/releases)를 엽니다.
2. Releases 목록에서 필요한 버전을 찾습니다. 목록은 최신순으로 정렬되어 있으며 최신 버전이 맨 위에 표시됩니다.
3. 해당 버전의 Release 페이지를 엽니다.
4. `.dmg` 설치 패키지 파일을 다운로드합니다.
5. 필요하면 `.sha256` 파일도 다운로드하여 설치 패키지의 무결성을 확인합니다.

### 데모

아래 GIF는 전체 다운로드 과정을 보여 줍니다.

![이전 설치 패키지 다운로드 방법](如何下载历史安装包.gif)

## 설명

- 2024-10-01 업데이트: 이제 DMG를 IMG로 변환한 뒤 압축을 풀어 `3.8.9.xx`와 같은 정확한 WeChat 버전 번호를 가져옵니다. 이 업데이트 전에는 마지막 두 자리의 마이너 버전 번호를 가져올 수 없었기 때문에, 같은 메이저 버전 안의 세부 버전을 구분하기 위해 업데이트 날짜 접미사를 추가했습니다. 이전 버전을 다운로드하기 전에 직접 확인해 주세요.

이 프로젝트는 GitHub Actions를 사용해 WeChat 공식 사이트의 최신 설치 패키지를 자동으로 다운로드하고, hash 값을 계산한 뒤 GitHub Releases에 게시합니다. 현재 App Store 설치 패키지를 보관할 계획은 없습니다.

각 버전의 변경 로그는 공식 WeChat [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true)를 참고하세요.

질문이나 권리 침해 관련 문제가 있으면 issue로 알려 주세요.
