# ./scripts/stop_worker.sh

export FASTCHAT_WORKER_PORT=22002

sudo docker run --rm -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    --gpus '"device=1,6"' -e NUM_GPUS=2 \
    -e TZ=Asia/Shanghai \
    -e NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    --cpus="10" --memory="20g" --shm-size="8gb" \
    -e FASTCHAT_CONTROLLER_ADDRESS='192.168.190.79' \
    -e FASTCHAT_CONTROLLER_PORT='22001' \
    -e FASTCHAT_WORKER_ADDRESS='192.168.190.79' \
    -e FASTCHAT_WORKER_PORT=${FASTCHAT_WORKER_PORT} \
    -p ${FASTCHAT_WORKER_PORT}:${FASTCHAT_WORKER_PORT}\
    -e FASTCHAT_WORKER_MODEL_NAMES='qinshu_extract' \
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
    -v /home/xiongrongkang/WorkSpace/Code/llm/FastChat/scripts:/app/scripts \
    -v /platform_tech/xiongrongkang/FastChat/logs:/app/logs \
    -v /platform_tech/xiongrongkang/checkpoint/qinshu/qinshu_extract_all_v4_qwen1_5_4b:/app/models \
    -v /platform_tech/xiongrongkang/FastChat/model_logs:/app/model_logs \
    --network="host" \
    --name fastchat-worker fastchat-worker:0.1