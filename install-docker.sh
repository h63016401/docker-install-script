#!/bin/bash

# 檢查是否為 root 用戶
if [ "$EUID" -eq 0 ]; then
    echo "請勿以 root 用戶執行此腳本，使用一般用戶即可"
    exit 1
fi

# 安裝 Docker
echo "正在安裝 Docker..."
curl -sSL https://get.docker.com | sh || {
    echo "Docker 安裝失敗"
    exit 1
}

# 將當前用戶加入 docker 群組
sudo gpasswd -a ${USER} docker || {
    echo "添加 docker 群組失敗"
    exit 1
}

# 下載 Docker Compose
echo "正在安裝 Docker Compose..."
sudo curl -L "https://github.com/docker/compose/releases/download/v2.25.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose || {
    echo "Docker Compose 下載失敗"
    exit 1
}

# 給予執行權限
sudo chmod +x /usr/local/bin/docker-compose

echo "安裝完成！請登出並重新登入以使 docker 群組權限生效"
echo "之後即可無需 sudo 直接使用 docker 命令"