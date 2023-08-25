#!/bin/bash
source /app/config.sh

service ssh start
service nginx start

echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
(ngrok tcp 22 --log=stdout > ngrok.log)&

sudo apt update 
sudo apt install openjdk-17-jdk
sudo apt install openjdk-17-jre

cp ./login.mc.rsync.pub ~/.ssh/

wget https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_install.sh && chmod +x frpc_linux_install.sh && ./frpc_linux_install.sh

(/usr/local/frp/frpc -c ./frpc.ini)&

echo "passwd123321" | passwd --stdin user

cd /tmp/
wget https://www.rarlab.com/rar/rarlinux-x64-623.tar.gz

while true
do
    # 这里放你要循环执行的命令
    echo "脚本正在运行..."
    # sleep一段时间
    sleep 3600
done
