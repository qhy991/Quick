# 外网受限环境下的下载方法

## 网络可达性参考

| 目标 | 推荐方式 |
|------|----------|
| GitHub | SSH `git@github.com:...`（HTTPS 易超时） |
| npm 包 | `registry.npmmirror.com` 优先，备用 `registry.npmjs.org` |
| Node.js | `npmmirror.com/mirrors/node` 优先，备用 `nodejs.org/dist` |
| Docker Hub | 部分环境不可达，需用厂商私有仓库或离线 tar |

---

## 1. 一键安装

```bash
git clone git@github.com:qhy991/Quick.git
cd Quick
bash install-ai-tools.sh
source ~/.profile
```

---

## 2. Node.js

**在线（国内镜像优先）：**

```bash
bash install-node.sh
```

**手动：**

```bash
wget https://npmmirror.com/mirrors/node/v22.16.0/node-v22.16.0-linux-x64.tar.xz
mkdir -p ~/.local/node
tar -xJf node-v22.16.0-linux-x64.tar.xz -C ~/.local/node --strip-components=1
```

**离线：** 在有网机器下载 tar.xz，`scp` 到目标机后解压到 `~/.local/node`。

---

## 3. Claude Code & Codex

**在线：**

```bash
export NPM_CONFIG_PREFIX="$HOME/.local"
export PATH="$HOME/.local/node/bin:$PATH"
bash install-claude-codex.sh
```

**离线：**

1. 有网机器：`npm pack @anthropic-ai/claude-code @openai/codex`
2. 将 `.tgz` 文件 `scp` 到目标机
3. `npm install -g ./anthropic-ai-claude-code-*.tgz ./openai-codex-*.tgz`

---

## 4. GitHub SSH（推荐）

```bash
ssh-keygen -t ed25519 -C "your@email" -f ~/.ssh/id_ed25519 -N ""
cat ~/.ssh/id_ed25519.pub   # 添加到 GitHub Settings -> SSH Keys

git config --global url."git@github.com:".insteadOf "https://github.com/"
```

---

## 5. Docker 镜像（MetaX 示例）

Docker Hub 不通时，使用厂商仓库：

```bash
docker login cr.metax-tech.com --username=<user> --password-stdin
docker pull cr.metax-tech.com/public-ai-release/maca/vllm-metax:...
```

---

## 6. 首次登录

```bash
claude    # Anthropic 账号或 ANTHROPIC_API_KEY
codex     # OpenAI 账号或 OPENAI_API_KEY
```
