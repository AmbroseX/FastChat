export version=0.2.9
sudo docker stop fastchat-controller-${version} && sudo docker rm fastchat-controller-${version}

export FASTCHAT_CONTROLLER_ADDRESS='0.0.0.0'
export FASTCHAT_CONTROLLER_PORT=21011
export FASTCHAT_OPENAI_API_PORT=21012

sudo docker run -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    --cpus="10" --memory="5g" \
    -e FASTCHAT_CONTROLLER_ADDRESS=${FASTCHAT_CONTROLLER_ADDRESS} \
    -e FASTCHAT_CONTROLLER_PORT=${FASTCHAT_CONTROLLER_PORT} \
    -e FASTCHAT_OPENAI_API_PORT=${FASTCHAT_OPENAI_API_PORT} \
    -e FASTCHAT_API_KEYS='123456' \
    -e FASTCHAT_LOG_LEVEL='debug' \
    -v /etc/localtime:/etc/localtime:ro \
    -v /platform_tech/logs/controller-debug:/app/logs \
    -v /platform_tech/logs/model_logs-debug:/app/model_logs \
    -e TZ=Asia/Shanghai \
    -v /etc/localtime:/etc/localtime:ro \
    -v /etc/timezone:/etc/timezone:ro   \
    --network="host" \
    --name fastchat-controller-${version} fastchat-controller:${version}