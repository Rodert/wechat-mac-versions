为避免项目&数据被和谐，且用且珍惜。

- [点击下载 windows 微信历史版本](https://github.com/Rodert/wechat-win-versions)

- [点击下载 mac 微信历史版本](https://github.com/Rodert/wechat-mac-versions)



# Wechat-Versions-For-macOS
收集 Mac 微信版本并保存

## 目录结构
```shell
├── README.md # 自述文件
├── index.html # GitHub Pages 展示页面
├── .nojekyll # GitHub Pages 配置文件
├── WeChatSetup # 微信安装包临时目录
│   └── temp # 临时目录
└── scripts   # 脚本目录
    └── destVersioForMac.sh # 获取安装包及取得版本号与 hash 值的脚本
```



## 如何下载历史安装包

> 📖 详细使用说明请参考 [Wiki 页面](https://github.com/Rodert/wechat-mac-versions/wiki/%E5%A6%82%E4%BD%95%E4%B8%8B%E8%BD%BD%E5%8E%86%E5%8F%B2%E5%AE%89%E8%A3%85%E5%8C%85-instructions)  
> 🌐 **在线浏览 Releases**: [访问 GitHub Pages 页面](https://rodert.github.io/wechat-mac-versions/) 查看所有版本并直接下载

本仓库通过 GitHub Releases 保存所有历史版本的微信安装包。按照以下步骤即可下载：

### 使用说明

1. 进入本仓库的 [Releases 页面](https://github.com/Rodert/wechat-mac-versions/releases)
2. 在 Releases 列表中找到你需要的版本（按时间倒序排列，最新版本在顶部）
3. 点击进入对应版本的 Release 页面
4. 下载对应的 `.dmg` 安装包文件
5. （可选）同时下载 `.sha256` 文件来验证安装包的完整性

### 操作演示

下面的动图展示了完整的下载流程：

![如何下载历史安装包.gif](如何下载历史安装包.gif)


## 说明

* 2024.10.1 更新：通过转换dmg为img后解压，获取精确的微信版本号（例如：3.8.9.xx）；在此之前，后两位小版本号无法获取，所以通过添加更新日期后缀来区分大版本中的小版本，需在下载前自行判断。

项目使用 Github Action 自动下载微信**官网最新版本安装包**计算 Hash 值并推送至仓库 Release，目前暂无保留App Store安装包的想法。


各版本更新日志可参见官网 [changelog](https://weixin.qq.com/cgi-bin/readtemplate?lang=zh_CN&t=weixin_faq_list&head=true)

*如有问题/侵权，请直接提交 issue 告知。*
