# 根目录下一键build docker脚本
export version=0.2.5
# 步骤1: 追加内容到 .dockerignore
# echo "model_logs/" >> .dockerignore
# echo "logs/" >> .dockerignore
# echo "wheel_cache/" >> .dockerignore
# 步骤2: 执行Docker构建或其他操作

sudo docker build  --build-arg BUILD_DATE=$(date +%Y-%m-%d:%H:%M:%S) -t fastchat-worker:${version} -f ./docker/${version}/Worker/Dockerfile.Worker .

# 步骤3: 删除 .dockerignore 中的 "wheel_cache/" 行
# sed -i '/model_logs\//d' .dockerignore
# sed -i '/logs\//d' .dockerignore
# sed -i "/wheel_cache\//d" .dockerignore


# 对于需要 wheel_cache 的构建，确保 .dockerignore 不包含对它的忽略
# 可以是删除该行，或完全重新生成 .dockerignore 文件