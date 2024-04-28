export version=0.2.3
export docker_name='fastchat-all'
sudo docker stop ${docker_name} && sudo docker rm ${docker_name}
# sudo docker exec -it fastchat-all /bin/bash
export FASTCHAT_CONTROLLER_PORT=24001
export FASTCHAT_OPENAI_API_PORT=27000
export FASTCHAT_WORKER_PORT=24002
export FASTCHAT_WORKER_MODEL_NAMES='fastchat-all'
export model_path='/platform_tech/models/Qwen1.5-1.8B-Chat'
export log_path='/platform_tech/xiongrongkang/FastChat/logs'
export model_logs_path='/platform_tech/xiongrongkang/FastChat/model_logs'

sudo docker run --rm -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    --gpus '"device=6"' -e NUM_GPUS=1 \
    -e TZ=Asia/Shanghai \
    -e NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    --cpus="10" --memory="20g" --shm-size="8gb" \
    -e FASTCHAT_CONTROLLER_ADDRESS='0.0.0.0' \
    -e FASTCHAT_CONTROLLER_PORT=${FASTCHAT_CONTROLLER_PORT} \
    -e FASTCHAT_OPENAI_API_PORT=${FASTCHAT_OPENAI_API_PORT} \
    -e FASTCHAT_API_KEYS='123456' \
    -e FASTCHAT_WORKER_ADDRESS='127.0.0.1' \
    -e FASTCHAT_WORKER_PORT=${FASTCHAT_WORKER_PORT} \
    -p ${FASTCHAT_CONTROLLER_PORT}:${FASTCHAT_CONTROLLER_PORT} \
    -p ${FASTCHAT_OPENAI_API_PORT}:${FASTCHAT_OPENAI_API_PORT} \
    -p ${FASTCHAT_WORKER_PORT}:${FASTCHAT_WORKER_PORT}\
    -e FASTCHAT_WORKER_MODEL_NAMES=${FASTCHAT_WORKER_MODEL_NAMES} \
    -e FASTCHAT_WORKER_MODEL_PATH='/app/models/' \
    -e RAY_USE_MULTIPROCESSING_CPU_COUNT= \
    -e RAY_DISABLE_DOCKER_CPU_WARNING=1 \
    -e RAY_memory_monitor_refresh_ms=0 \
    -e GPU_MEMORY_UTILIZATION=0.85 \
    -e MAX_MODEL_LEN=32768 \
    -e LIMIT_WORKER=20 \
    -e LOG_LEVEL='DEBUG' \
    -e FASTCHAT_LOG_LEVEL='debug' \
    -e USE_WORKER='VLLM_WORKER' \
    -v /etc/localtime:/etc/localtime:ro \
    -v ${model_path}:/app/models \
    -v ${log_path}:/app/logs \
    -v ${model_logs_path}:/app/model_logs \
    --name ${docker_name} fastchat-all:${version}