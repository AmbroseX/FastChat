export version=0.2.7
sudo docker build  --build-arg BUILD_DATE=$(date +%Y-%m-%d:%H:%M:%S) -t fastchat-all:${version} -f ./docker/${version}/All/Dockerfile.all .

