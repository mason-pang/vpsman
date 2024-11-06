#!/bin/bash

# 安装必要的包
apt-get update
apt-get install -y zsh curl git autojump

# 为当前用户安装 Oh My Zsh
install_omz_for_user() {
    local user=$1
    local home_dir=$2
    
    # 安装 Oh My Zsh
    su - $user -c 'sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended'
    
    # 安装插件
    su - $user -c "git clone https://github.com/zsh-users/zsh-autosuggestions ${home_dir}/.oh-my-zsh/custom/plugins/zsh-autosuggestions"
    su - $user -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${home_dir}/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting"
    
    # 配置 .zshrc
    cat > ${home_dir}/.zshrc << 'EOL'
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# 设置主题
ZSH_THEME="agnoster"

# 设置插件
plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting)

# 设置历史记录
HIST_STAMPS="yyyy-mm-dd"
HISTSIZE=1000
SAVEHIST=1000

# 加载 oh-my-zsh
source $ZSH/oh-my-zsh.sh

# 设置提示符显示完整路径
PROMPT='%{$fg[white]%}%n@%m:%{$fg[blue]%}%~%{$reset_color%}$(git_prompt_info)
%{$fg[red]%}➜ %{$reset_color%}'

# 设置别名
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# 启用 autojump
. /usr/share/autojump/autojump.sh
EOL

    # 设置权限
    chown ${user}:${user} ${home_dir}/.zshrc
    
    # 切换默认shell为zsh
    chsh -s $(which zsh) $user
}

# 为root用户安装
install_omz_for_user root /root

# 如果当前用户不是root，也为当前用户安装
if [ "$(id -u)" != "0" ]; then
    install_omz_for_user $USER $HOME
fi

echo "=== 安装完成 ==="
echo "Oh My Zsh 已安装并配置完成！"
echo "已安装的插件："
echo "- git"
echo "- zsh-autosuggestions"
echo "- autojump"
echo "- zsh-syntax-highlighting"
echo ""
echo "已配置的功能："
echo "- agnoster 主题"
echo "- 显示完整路径"
echo "- 显示用户名和主机名"
echo "- 添加常用别名"
echo "- 配置历史记录格式"
echo ""
echo "请注销并重新登录以使shell更改生效"
echo "或者直接运行: exec zsh"

# 安装字体（可选，如果是在本地终端使用）
echo "注意：如果看到乱码，请安装 powerline 字体："
echo "https://github.com/powerline/fonts"