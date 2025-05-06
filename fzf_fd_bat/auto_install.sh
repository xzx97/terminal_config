#!/usr/bin/bash

# 安装 fd
sudo apt install fd-find        # Ubuntu
# 软链接 fd（有些系统中它叫 fdfind）
ln -s $(which fdfind) ~/.local/bin/fd

# 安装 bat
sudo apt install bat
ln -s $(which batcat) ~/.local/bin/bat   # Ubuntu 下有些叫 batcat

# 安装 fzf
sudo apt install fzf


# 创建备份
cp ~/.zshrc ~/.zshrc.backup.$(date +%s)

# 要添加的配置内容
read -r -d '' CONFIG << 'EOF'

### >>> Modern Terminal Workflow: fzf + fd + bat + ripgrep ###
# 确保 fd 可调用（某些系统叫 fdfind）
if command -v fdfind &>/dev/null && ! command -v fd &>/dev/null; then
  alias fd="$(which fdfind)"
fi

# 确保 bat 可调用（某些系统叫 batcat）
if command -v batcat &>/dev/null && ! command -v bat &>/dev/null; then
  alias bat="$(which batcat)"
fi

# 模糊查找任意文件，右侧预览内容，回车用 nvim 打开
f() {
  local file
  file=$(fd . --type f | fzf --preview 'bat --style=numbers --color=always {} | head -100' --preview-window=right:60%)
  [[ -n "$file" ]] && nvim "$file"
}

# 快速搜索文件名
alias sf='fd . --type f | fzf'

# 查找并打开 Markdown 文件（带预览）
fm() {
  local file
  file=$(fd . -e md | fzf --preview 'bat --style=numbers --color=always {} | head -100')
  [[ -n "$file" ]] && nvim "$file"
}

# 使用 ripgrep 搜索文件内容并预览跳转
rgf() {
  RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
  local file
  file=$(eval "$RG_PREFIX $1" | fzf --ansi --delimiter : \
        --preview 'bat --style=numbers --color=always {1} --line-range {2}: {2}' \
        --preview-window='up,60%,border-bottom,+{2}+3/3,~3')
  if [[ -n "$file" ]]; then
    file=$(echo "$file" | cut -d: -f1)
    nvim "$file"
  fi
}
### <<< End Modern Terminal Workflow ###
EOF

# 检查是否已经添加过（避免重复）
if grep -q "Modern Terminal Workflow" ~/.zshrc; then
  echo "❗ 配置已存在，跳过添加。"
else
  echo "$CONFIG" >> ~/.zshrc
  echo "✅ 配置已成功添加到 ~/.zshrc"
  echo "请运行 'source ~/.zshrc' 以生效。"
fi
