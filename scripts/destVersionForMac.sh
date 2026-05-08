#!/usr/bin/env bash

set -eo pipefail

# ====================================================
# 配置变量
# ====================================================
TEMP_PATH="WeChatMac/temp"
DOWNLOAD_LINK=""
WEIXIN_HOME_URL="https://weixin.qq.com/"
RELEASE_FEED_URL="https://dldir1.qq.com/weixin/mac/mac-release.xml"
DOWNLOAD_PAGE_URL="https://mac.weixin.qq.com/"
LINUX_PAGE_URL="https://linux.weixin.qq.com/"
PACKAGE_LABELS=()
PACKAGE_URLS=()
PACKAGE_FILES=()
ASSET_FILES=()
RELEASE_NOTES_FILE=""
NOW_PACKAGE_SIGNATURE=""
LATEST_PACKAGE_SIGNATURE=""

# ====================================================
# 函数定义
# ====================================================

# 打印分隔线
print_separator() {
    printf '%*s\n' 60 | tr ' ' '#'
}

# 彩色输出函数
echo_color() {
    local color="$1"
    shift
    local message="$*"
    case "$color" in
        yellow)
            echo -e "\033[1;33m$message\033[0m"
            ;;
        red)
            echo -e "\033[1;31m$message\033[0m" >&2
            ;;
        green)
            echo -e "\033[1;32m$message\033[0m"
            ;;
        *)
            echo "$message"
            ;;
    esac
}

# 安装依赖项
install_depends() {
    print_separator
    echo_color "yellow" "Installing dependencies: wget, curl, git, gh, shasum"
    print_separator

    brew install wget curl git gh
}

add_package() {
    local label="$1"
    local url="$2"
    local filename="${3:-}"
    local existing_url
    local clean_url

    if [ -z "$url" ]; then
        return
    fi

    for existing_url in "${PACKAGE_URLS[@]}"; do
        if [ "$existing_url" = "$url" ]; then
            return
        fi
    done

    if [ -z "$filename" ]; then
        clean_url="${url%%\?*}"
        filename="${clean_url##*/}"
    fi

    PACKAGE_LABELS+=("$label")
    PACKAGE_URLS+=("$url")
    PACKAGE_FILES+=("$filename")
}

# 从微信官网入口解析最新 WeChat 安装包
resolve_download_links() {
    local home_content
    local feed_content
    local page_content
    local linux_content
    local mac_page_url
    local package_url

    home_content=$(curl -fsSL "$WEIXIN_HOME_URL" || true)
    if [ -n "$home_content" ]; then
        DOWNLOAD_LINK=$(printf '%s' "$home_content" \
            | grep -Eo 'https?://[^"]+/[^"]*WeChatMac[^"]*\.dmg([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | grep '/Universal/Mac/' \
            | head -n 1 || true)

        mac_page_url=$(printf '%s' "$home_content" \
            | grep -Eo 'https?://mac\.weixin\.qq\.com/[^"]*' \
            | sed 's/&amp;/\&/g' \
            | head -n 1 || true)

        add_package "macOS" "$DOWNLOAD_LINK" "WeChatMac.dmg"

        package_url=$(printf '%s' "$home_content" \
            | grep -Eo 'https?://[^"]+/[^"]*WeChatWin[^"]*\.exe([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | grep '/Universal/Windows/' \
            | head -n 1 || true)
        add_package "Windows" "$package_url"

        while IFS= read -r package_url; do
            add_package "Android" "$package_url"
        done < <(printf '%s' "$home_content" \
            | grep -Eo 'https?://[^"]+/[^"]*weixin[^"]*\.apk([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | awk '!seen[$0]++' || true)
    fi

    if [ -z "$mac_page_url" ]; then
        mac_page_url="$DOWNLOAD_PAGE_URL"
    fi

    if [ -z "$DOWNLOAD_LINK" ]; then
        page_content=$(curl -fsSL "$mac_page_url" || true)
        DOWNLOAD_LINK=$(printf '%s' "$page_content" \
            | grep -Eo 'https?://[^"]+/[^"]*WeChatMac[^"]*\.dmg([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | grep '/Universal/Mac/' \
            | head -n 1 || true)
        add_package "macOS" "$DOWNLOAD_LINK" "WeChatMac.dmg"
    fi

    if [ -z "$DOWNLOAD_LINK" ]; then
        feed_content=$(curl -fsSL "$RELEASE_FEED_URL" || true)
        DOWNLOAD_LINK=$(printf '%s' "$feed_content" \
            | grep -Eo 'https?://[^"]+/[^"]*WeChatMac[^"]*\.dmg([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | grep '/Universal/Mac/' \
            | head -n 1 || true)
        add_package "macOS" "$DOWNLOAD_LINK" "WeChatMac.dmg"
    fi

    linux_content=$(curl -fsSL "$LINUX_PAGE_URL" || true)
    if [ -n "$linux_content" ]; then
        while IFS= read -r package_url; do
            add_package "Linux" "$package_url"
        done < <(printf '%s' "$linux_content" \
            | grep -Eo 'https?://[^"]+/[^"]*WeChatLinux[^"]*\.(deb|rpm|AppImage)([^"]*)?' \
            | sed 's/&amp;/\&/g' \
            | awk '!seen[$0]++' || true)
    fi

    if [ -z "$DOWNLOAD_LINK" ]; then
        echo_color "red" "Failed to resolve WeChat download link!"
        clean_data 1
    fi
}

# 下载 WeChat DMG
download_wechat() {
    local i

    resolve_download_links

    print_separator
    echo_color "yellow" "Downloading WeChat packages..."
    print_separator

    mkdir -p "$TEMP_PATH"

    for i in "${!PACKAGE_URLS[@]}"; do
        echo "Downloading ${PACKAGE_LABELS[$i]} from ${PACKAGE_URLS[$i]}"
        wget -q "${PACKAGE_URLS[$i]}" -O "${TEMP_PATH}/${PACKAGE_FILES[$i]}"
        if [ "$?" -ne 0 ]; then
            echo_color "red" "Download Failed, please check your network!"
            clean_data 1
        fi
    done
}

# 从 Info.plist 提取版本信息
get_version() {
    print_separator
    echo_color "yellow" "Extracting version from DMG (macOS)..."
    print_separator

    # 挂载 dmg
    MOUNT_DIR=$(hdiutil attach "${TEMP_PATH}/WeChatMac.dmg" -nobrowse | sed -n 's/^.*\(\/Volumes\/.*\)$/\1/p' | tail -n1)

    if [ -z "$MOUNT_DIR" ]; then
        echo_color "red" "Failed to mount DMG!"
        clean_data 1
    fi

    # 定位 Info.plist
    # INFO_PLIST=$(find "${MOUNT_DIR}" -type f -name "Info.plist" | head -n 1)
    INFO_PLIST="${MOUNT_DIR}/WeChat.app/Contents/Info.plist"

    if [ ! -f "$INFO_PLIST" ]; then
        echo_color "red" "Info.plist not found in mounted volume!"
        hdiutil detach "$MOUNT_DIR"
        clean_data 1
    fi

    # 使用 grep 和 sed 提取版本号
    VERSION=$(grep -A1 '<key>CFBundleShortVersionString</key>' "$INFO_PLIST" | grep '<string>' | sed -E 's/.*<string>([^<]+)<\/string>.*/\1/')

    # 卸载 dmg
    hdiutil detach "$MOUNT_DIR"

    if [ -z "$VERSION" ]; then
        echo_color "red" "Version information not found in Info.plist!"
        clean_data 1
    fi

    echo "Version: $VERSION"
}


# 计算 SHA256
compute_sha256() {
    local file_path="$1"
    shasum -a 256 "$file_path" | awk '{print $1}'
}

# 准备发布资产并创建 .sha256 文件
prepare_commit() {
    local i
    local source_file
    local asset_name
    local asset_path
    local package_hash
    local signature_source

    print_separator
    echo_color "yellow" "Preparing to commit new version..."
    print_separator

    VERSION_DIR="WeChatMac/$VERSION"
    mkdir -p "$VERSION_DIR"

    RELEASE_NOTES_FILE="$VERSION_DIR/WeChat-$VERSION.sha256"
    signature_source="${TEMP_PATH}/package-signature.txt"
    : > "$signature_source"

    for i in "${!PACKAGE_URLS[@]}"; do
        source_file="${TEMP_PATH}/${PACKAGE_FILES[$i]}"
        asset_name="${PACKAGE_FILES[$i]}"

        if [ "$asset_name" = "WeChatMac.dmg" ]; then
            asset_name="WeChatMac-$VERSION.dmg"
        fi

        asset_path="$VERSION_DIR/$asset_name"
        cp "$source_file" "$asset_path"

        package_hash=$(compute_sha256 "$asset_path")
        ASSET_FILES+=("$asset_path")

        if [ "${PACKAGE_LABELS[$i]}" = "macOS" ]; then
            NOW_SUM256="$package_hash"
        fi

        printf '%s  %s  %s\n' "$asset_name" "$package_hash" "${PACKAGE_URLS[$i]}" >> "$signature_source"
    done

    NOW_PACKAGE_SIGNATURE=$(compute_sha256 "$signature_source")

    cat > "$RELEASE_NOTES_FILE" <<EOF
DestVersion: $VERSION
Sha256: $NOW_SUM256
PackageSignature: $NOW_PACKAGE_SIGNATURE
UpdateTime: $(date -u '+%Y-%m-%d %H:%M:%S') (UTC)

EOF

    for i in "${!PACKAGE_URLS[@]}"; do
        asset_name="${PACKAGE_FILES[$i]}"
        if [ "$asset_name" = "WeChatMac.dmg" ]; then
            asset_name="WeChatMac-$VERSION.dmg"
        fi

        package_hash=$(compute_sha256 "$VERSION_DIR/$asset_name")
        cat >> "$RELEASE_NOTES_FILE" <<EOF
Package: ${PACKAGE_LABELS[$i]}
File: $asset_name
Sha256: $package_hash
DownloadFrom: ${PACKAGE_URLS[$i]}

EOF
    done

    echo "SHA256: $NOW_SUM256"
    echo "Package Signature: $NOW_PACKAGE_SIGNATURE"
}

# 获取最新的 GitHub Release 信息
get_latest_release_info() {
    print_separator
    echo_color "yellow" "Getting latest GitHub release info..."
    print_separator

    LATEST_BODY=$(gh release view --json body --jq ".body" || true)

    if [ -z "$LATEST_BODY" ]; then
        LATEST_SUM256=""
        LATEST_VERSION=""
        LATEST_PACKAGE_SIGNATURE=""
    else
        LATEST_SUM256=$(echo "$LATEST_BODY" | grep 'Sha256:' | awk -F': ' '{print $2}')
        LATEST_VERSION=$(echo "$LATEST_BODY" | grep 'DestVersion:' | awk -F': ' '{print $2}')
        LATEST_PACKAGE_SIGNATURE=$(echo "$LATEST_BODY" | grep 'PackageSignature:' | awk -F': ' '{print $2}')
    fi

    echo "Latest Version: $LATEST_VERSION"
    echo "Latest SHA256: $LATEST_SUM256"
    echo "Latest Package Signature: $LATEST_PACKAGE_SIGNATURE"
}

# 创建新的 GitHub Release
create_release() {
    print_separator
    echo_color "yellow" "Creating new GitHub release..."
    print_separator

    if [ "$VERSION" = "$LATEST_VERSION" ]; then
        VERSION_TAG="${VERSION}_$(date -u '+%Y%m%d')"
    else
        VERSION_TAG="$VERSION"
    fi

    gh release create "v$VERSION_TAG" "${ASSET_FILES[@]}" "$RELEASE_NOTES_FILE" -F "$RELEASE_NOTES_FILE" -t "Wechat v$VERSION_TAG"
}

# 清理临时数据并退出
clean_data() {
    print_separator
    echo_color "yellow" "Cleaning runtime and exiting..."
    print_separator

    rm -rf "WeChatMac"
    exit "$1"
}

# ====================================================
# 主流程
# ====================================================
main() {
    # 创建临时目录
    mkdir -p "$TEMP_PATH"

    # 安装依赖项
    install_depends

    # 下载 WeChat 安装包
    download_wechat

    # 提取版本信息
    get_version

    # 准备提交（复制 DMG 并创建 .sha256 文件）
    prepare_commit

    # 获取最新的 GitHub Release 信息
    get_latest_release_info

    # 比较 SHA256 值
    if [ "$NOW_PACKAGE_SIGNATURE" = "$LATEST_PACKAGE_SIGNATURE" ] && [ -n "$LATEST_PACKAGE_SIGNATURE" ]; then
        echo_color "green" "This is the newest Version!"
        clean_data 0
    fi

    # 创建新的 GitHub Release
    create_release

    # 清理临时数据并退出
    clean_data 0
}

# 执行主流程
main
