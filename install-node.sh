#!/usr/bin/env bash
# 用户级安装 Node.js（无需 sudo）
# 用法: bash install-node.sh
# 可选环境变量:
#   NODE_VERSION   默认 22.16.0
#   NODE_PREFIX    默认 ~/.local/node
#   NODE_MIRROR    默认 https://npmmirror.com/mirrors/node （国内镜像）
#                  备用 https://nodejs.org/dist

set -euo pipefail

NODE_VERSION="${NODE_VERSION:-22.16.0}"
NODE_PREFIX="${NODE_PREFIX:-$HOME/.local/node}"
NODE_MIRROR="${NODE_MIRROR:-https://npmmirror.com/mirrors/node}"
ARCH="linux-x64"
TARBALL="node-v${NODE_VERSION}-${ARCH}.tar.xz"
TMP="/tmp/${TARBALL}"

mkdir -p "$NODE_PREFIX"

if [[ -x "$NODE_PREFIX/bin/node" ]]; then
  echo "Node.js 已安装: $($NODE_PREFIX/bin/node --version)"
  exit 0
fi

download() {
  local url="$1"
  echo "==> 尝试下载: $url"
  if command -v wget >/dev/null 2>&1; then
    wget -q --show-progress -O "$TMP" "$url"
  elif command -v curl >/dev/null 2>&1; then
    curl -fL --progress-bar -o "$TMP" "$url"
  elif python3 - <<'PY' "$url" "$TMP"
import sys, urllib.request
urllib.request.urlretrieve(sys.argv[1], sys.argv[2])
PY
  then
    :
  else
    return 1
  fi
}

URLS=(
  "${NODE_MIRROR}/v${NODE_VERSION}/${TARBALL}"
  "https://nodejs.org/dist/v${NODE_VERSION}/${TARBALL}"
)

ok=0
for url in "${URLS[@]}"; do
  if download "$url"; then
    ok=1
    break
  fi
  echo "    下载失败，尝试下一个源..."
done

if [[ "$ok" -ne 1 ]]; then
  echo "错误: 所有 Node.js 下载源均失败"
  echo "离线方案: 在有网络的机器下载 ${TARBALL}，scp 到本机 /tmp/ 后手动解压到 ${NODE_PREFIX}"
  exit 1
fi

EXTRACT="/tmp/node-v${NODE_VERSION}-${ARCH}"
rm -rf "$EXTRACT"
tar -xJf "$TMP" -C /tmp
cp -r "$EXTRACT"/* "$NODE_PREFIX/"
rm -rf "$TMP" "$EXTRACT"

echo "==> Node.js 安装完成"
"$NODE_PREFIX/bin/node" --version
"$NODE_PREFIX/bin/npm" --version

cat <<EOF

已写入 PATH（若尚未配置，运行 setup-shell-path.sh）:
  export PATH="\$HOME/.local/node/bin:\$PATH"
  export NPM_CONFIG_PREFIX="\$HOME/.local"
EOF
