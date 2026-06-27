#!/usr/bin/env bash
# 安装 Claude Code 与 OpenAI Codex CLI（用户级，无需 sudo）
# 用法: bash install-claude-codex.sh
# 可选环境变量:
#   NPM_REGISTRY   默认 https://registry.npmmirror.com （国内 npm 镜像）
#                  备用 https://registry.npmjs.org
#   CLAUDE_VERSION 默认 latest
#   CODEX_VERSION  默认 latest

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
NODE_PREFIX="${NODE_PREFIX:-$HOME/.local/node}"
export PATH="$NODE_PREFIX/bin:$HOME/.local/bin:$PATH"
export NPM_CONFIG_PREFIX="${NPM_CONFIG_PREFIX:-$HOME/.local}"

PRIMARY_REGISTRY="${NPM_REGISTRY:-https://registry.npmmirror.com}"
FALLBACK_REGISTRY="${NPM_FALLBACK_REGISTRY:-https://registry.npmjs.org}"
CLAUDE_PKG="${CLAUDE_PKG:-@anthropic-ai/claude-code@${CLAUDE_VERSION:-latest}}"
CODEX_PKG="${CODEX_PKG:-@openai/codex@${CODEX_VERSION:-latest}}"

if ! command -v npm >/dev/null 2>&1; then
  echo "未找到 npm，请先运行: bash ${SCRIPT_DIR}/install-node.sh"
  exit 1
fi

npm_install() {
  local registry="$1"
  echo "==> npm install -g (registry=$registry)"
  npm install -g --registry="$registry" "$CLAUDE_PKG" "$CODEX_PKG"
}

if ! npm_install "$PRIMARY_REGISTRY"; then
  echo "主镜像失败，尝试备用源..."
  npm_install "$FALLBACK_REGISTRY"
fi

echo ""
echo "==> 验证安装"
claude --version
codex --version

mkdir -p "$HOME/.claude"

cat <<'EOF'

==> 首次使用需登录

Claude Code:
  claude
  # 或设置 API Key:
  # export ANTHROPIC_API_KEY="your-key"

Codex CLI:
  codex
  # 或设置 API Key:
  # export OPENAI_API_KEY="your-key"

可选: 写入 ~/.profile 持久化 API Key（勿提交到 Git）
EOF
