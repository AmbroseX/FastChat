# 根目录下一键build docker脚本
export version=0.2.8
sudo docker build  --build-arg BUILD_DATE=$(date +%Y-%m-%d:%H:%M:%S) -t fastchat-worker:${version} -f ./docker/${version}/Worker/Dockerfile.Worker .