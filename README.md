# Quick

Linux 用户级 AI 开发工具一键安装脚本（无需 sudo）。

适用于外网受限环境：优先使用国内镜像（npmmirror），GitHub 推荐 SSH。

## 包含工具

| 工具 | 说明 |
|------|------|
| **Node.js** | 用户级安装到 `~/.local/node` |
| **Claude Code** | `@anthropic-ai/claude-code` |
| **Codex CLI** | `@openai/codex` |

## 快速开始

```bash
git clone git@github.com:qhy991/Quick.git
cd Quick
bash install-ai-tools.sh
source ~/.profile

claude --version
codex --version
```

## 脚本说明

| 脚本 | 作用 |
|------|------|
| `install-ai-tools.sh` | 一键安装 Node.js + Claude Code + Codex + PATH |
| `install-node.sh` | 仅安装 Node.js |
| `install-claude-codex.sh` | 仅安装 Claude Code 和 Codex |
| `setup-shell-path.sh` | 写入 `~/.profile` PATH 配置 |
| `DOWNLOAD-METHODS.md` | 外网受限时的下载与离线安装方法 |

## 首次登录

```bash
claude    # Anthropic 账号或 ANTHROPIC_API_KEY
codex     # OpenAI 账号或 OPENAI_API_KEY
```

## 环境变量（可选）

```bash
NODE_VERSION=22.16.0          # Node.js 版本
NODE_MIRROR=https://npmmirror.com/mirrors/node
NPM_REGISTRY=https://registry.npmmirror.com
CLAUDE_VERSION=latest
CODEX_VERSION=latest
```

## 离线安装

详见 [DOWNLOAD-METHODS.md](./DOWNLOAD-METHODS.md)。
