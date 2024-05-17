# 根目录下一键build docker脚本
export version=0.2.7
# 步骤1: 追加内容到 .dockerignore
# echo "wheel_cache/" >> .dockerignore

# 步骤2: 执行Docker构建或其他操作
sudo docker build -t fastchat-controller:${version} -f ./docker/${version}/Controller/Dockerfile.Controller .

# 步骤3: 删除 .dockerignore 中的 "wheel_cache/" 行
# sed -i '/wheel_cache\//d' .dockerignore

# 对于需要 wheel_cache 的构建，确保 .dockerignore 不包含对它的忽略
# 可以是删除该行，或完全重新生成 .dockerignore 文件