export version=0.2.5
sudo docker stop fastchat-worker && sudo docker rm fastchat-worker
# Controller地址
export FASTCHAT_CONTROLLER_ADDRESS='192.168.190.79'
export FASTCHAT_CONTROLLER_PORT=22001
export FASTCHAT_OPENAI_API_PORT=28000
# worker端口
export FASTCHAT_WORKER_ADDRESS='192.168.190.79'
export FASTCHAT_WORKER_PORT=22003
export FASTCHAT_WORKER_MODEL_NAMES='fastchat-worker'
export docker_name='fastchat-worker'
export FASTCHAT_CONV_TEMPLATE=''
export model_path='/platform_tech/models/Qwen1.5-1.8B-Chat'

sudo docker run --rm -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    --gpus '"device=6"' -e NUM_GPUS=1 \
    -e TZ=Asia/Shanghai \
    -e NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    --cpus="10" --memory="20g" --shm-size="8gb" \
    -e FASTCHAT_CONTROLLER_ADDRESS=${FASTCHAT_CONTROLLER_ADDRESS} \
    -e FASTCHAT_CONTROLLER_PORT=${FASTCHAT_CONTROLLER_PORT} \
    -e FASTCHAT_OPENAI_API_PORT=${FASTCHAT_OPENAI_API_PORT} \
    -e FASTCHAT_WORKER_ADDRESS=${FASTCHAT_WORKER_ADDRESS} \
    -e FASTCHAT_WORKER_PORT=${FASTCHAT_WORKER_PORT} \
    -p ${FASTCHAT_WORKER_PORT}:${FASTCHAT_WORKER_PORT}\
    -e FASTCHAT_WORKER_MODEL_NAMES=${FASTCHAT_WORKER_MODEL_NAMES} \
    -e FASTCHAT_WORKER_MODEL_PATH='/app/models/' \
    -e FASTCHAT_CONV_TEMPLATE=${FASTCHAT_CONV_TEMPLATE} \
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
    -v /home/xiongrongkang/WorkSpace/Code/llm/FastChat/scripts:/app/scripts \
    -v /platform_tech/xiongrongkang/FastChat/logs:/app/logs \
    -v ${model_path}:/app/models \
    -v /platform_tech/xiongrongkang/FastChat/model_logs:/app/model_logs \
    --network="host" \
    --name ${docker_name} fastchat-worker:${version}