#!/bin/bash

# 检查是否以root用户运行
if [ "$(id -u)" != "0" ]; then
   echo "此脚本必须以root用户身份运行" 1>&2
   exit 1
fi

# 卸载旧版本 Docker（如果存在）
apt-get remove -y docker docker-engine docker.io containerd runc

# 更新系统包
apt-get update

# 安装必要的依赖
apt-get install -y \
    ca-certificates \
    curl \
    gnupg

# 添加Docker官方GPG密钥
install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
chmod a+r /etc/apt/keyrings/docker.gpg

# 设置Docker仓库
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  bookworm stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null

# 更新apt包索引
apt-get update

# 安装Docker
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 启动Docker服务
systemctl start docker
systemctl enable docker

# 验证安装
docker --version

echo "Docker 安装完成！"