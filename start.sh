#!/bin/bash
source /app/config.sh

service ssh start
service nginx start

echo "set ngrok token: $NGROK_TOKEN"
ngrok authtoken $NGROK_TOKEN
echo "start ngrok service"
(ngrok tcp 22 --log=stdout > ngrok.log)&

cat /app/login.mc.rsync.pub >> ~/.ssh/authorized_keys

wget https://raw.githubusercontent.com/stilleshan/frpc/master/frpc_linux_install.sh && chmod +x frpc_linux_install.sh && ./frpc_linux_install.sh

(/usr/local/frp/frpc -c /app/frpc.ini)&

yes|apt install pwgen

PASSWORD=`pwgen -c -n -1 20`
echo "root:$PASSWORD" | chpasswd
echo "root:$PASSWORD"

#yes|apt update --no-install-recommends
#yes|apt install openjdk-17-jdk
#yes|apt install openjdk-17-jre 
#yes|apt install rsync
#cd /tmp/
#wget https://www.rarlab.com/rar/rarlinux-x64-623.tar.gz

apt install curl apt-transport-https
curl -s https://syncthing.net/release-key.txt | sudo apt-key add -
echo "deb https://apt.syncthing.net/ syncthing release" | sudo tee /etc/apt/sources.list.d/syncthing.list
apt update
apt install syncthing --no-install-recommends
syncthing --version
(/usr/bin/syncthing -no-browser -gui-address="0.0.0.0:8384" -no-restart -logflags=0)&
#yes|apt install openjdk-17-jdk --no-install-recommends
#yes|apt install openjdk-17-jre  --no-install-recommends

while true
do
    # 这里放你要循环执行的命令
    echo "脚本正在运行..."
    # sleep一段时间
    sleep 3600
done
