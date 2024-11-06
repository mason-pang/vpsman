#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" = "0" ]; then
   echo "请不要使用root用户运行此脚本" 1>&2
   exit 1
fi

# 安装必要的包
sudo apt-get update
sudo apt-get install -y zsh curl git autojump

# 安装 Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 安装插件
# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 配置插件
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions autojump zsh-syntax-highlighting)/' ~/.zshrc

# 切换默认shell为zsh
chsh -s $(which zsh)

# 应用更改
source ~/.zshrc

echo "=== 安装完成 ==="
echo "Oh My Zsh 已安装并配置完成！"
echo "已安装的插件："
echo "- git"
echo "- zsh-autosuggestions"
echo "- autojump"
echo "- zsh-syntax-highlighting"
echo ""
echo "请注销并重新登录以使shell更改生效"
echo "或者直接运行: exec zsh"