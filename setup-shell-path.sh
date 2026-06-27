#!/usr/bin/env bash
# 将 Node / Claude / Codex 写入 shell 配置
set -euo pipefail

PROFILE="$HOME/.profile"
MARKER="# ai-tools-path"

if grep -q "$MARKER" "$PROFILE" 2>/dev/null; then
  echo "PATH 已配置，跳过"
  exit 0
fi

cat >> "$PROFILE" <<'EOF'

# ai-tools-path
if [ -d "$HOME/.local/node/bin" ] ; then
    PATH="$HOME/.local/node/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export NPM_CONFIG_PREFIX="$HOME/.local"
# 国内 npm 镜像（可按需注释）
export NPM_CONFIG_REGISTRY="${NPM_CONFIG_REGISTRY:-https://registry.npmmirror.com}"
EOF

echo "已写入 ~/.profile，执行 source ~/.profile 生效"
