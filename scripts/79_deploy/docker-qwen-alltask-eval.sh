# 单卡80G显存
export version=0.2.5
sudo docker stop llm-qwen-alltask-eval && sudo docker rm llm-qwen-alltask-eval
# sudo docker exec -it llm-qwen-alltask-eval /bin/bash
export FASTCHAT_CONTROLLER_PORT=28002
export FASTCHAT_OPENAI_API_PORT=28003
export FASTCHAT_WORKER_PORT=28004
export docker_name='llm-qwen-alltask-eval'
export FASTCHAT_WORKER_MODEL_NAMES='llm-qwen-alltask-eval'
export model_path='/platform_tech/readpaper-models/paper-gpt/20240428-llm-qwen-alltask-eval'
# 模板名称
export FASTCHAT_CONV_TEMPLATE='qwen-7b-chat'
export log_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}
export model_logs_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}

sudo docker run --rm -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    -e CUDA_VISIBLE_DEVICES=1,2 \
    --gpus all -e NUM_GPUS=2 \
    -e TZ=Asia/Shanghai \
    -e NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    --cpus="4" \
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
    -e FASTCHAT_CONV_TEMPLATE=${FASTCHAT_CONV_TEMPLATE} \
    -e RAY_USE_MULTIPROCESSING_CPU_COUNT= \
    -e RAY_DISABLE_DOCKER_CPU_WARNING=1 \
    -e RAY_memory_monitor_refresh_ms=0 \
    -e GPU_MEMORY_UTILIZATION=0.9 \
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