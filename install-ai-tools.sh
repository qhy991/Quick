#!/usr/bin/env bash
# 一键安装 Node.js + Claude Code + Codex（用户级，无需 sudo）
# 用法: bash install-ai-tools.sh

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "========== [1/2] Node.js =========="
bash "$SCRIPT_DIR/install-node.sh"

echo ""
echo "========== [2/2] Claude Code & Codex =========="
bash "$SCRIPT_DIR/install-claude-codex.sh"

echo ""
bash "$SCRIPT_DIR/setup-shell-path.sh"

echo ""
echo "全部完成。新开终端或执行: source ~/.profile"
