# 单卡80G显存
export version=0.2.5
# sudo docker exec -it llm-qwen-catalog-eval /bin/bash
sudo docker stop llm-qwen-catalog-eval && sudo docker rm llm-qwen-catalog-eval
export FASTCHAT_CONTROLLER_PORT=30001
export FASTCHAT_OPENAI_API_PORT=30002
export FASTCHAT_WORKER_PORT=30003
export docker_name='llm-qwen-catalog-eval'
export FASTCHAT_WORKER_MODEL_NAMES='llm-qwen-catalog-eval'
export model_path='/platform_tech/readpaper-models/paper-gpt/20240428-llm-qwen-catalog-eval'
# 模板名称
export FASTCHAT_CONV_TEMPLATE='qwen-7b-chat'
export log_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}
export model_logs_path=/platform_tech/logs/${FASTCHAT_WORKER_MODEL_NAMES}

sudo docker run --rm -d --security-opt seccomp:unconfined -e OPENBLAS_NUM_THREADS=1 \
    -e CUDA_VISIBLE_DEVICES=6,7 \
    --gpus all -e NUM_GPUS=2 \
    -e TZ=Asia/Shanghai \
    -e NVIDIA_DRIVER_CAPABILITIES="compute,utility" \
    --cpus="2" \
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
    -e LIMIT_WORKER=5 \
    -e LOG_LEVEL='DEBUG' \
    -e FASTCHAT_LOG_LEVEL='debug' \
    -e USE_WORKER='VLLM_WORKER' \
    -v /etc/localtime:/etc/localtime:ro \
    -v /home/xiongrongkang/WorkSpace/Code/llm/FastChat/docker:/app/docker \
    -v /platform_tech/xiongrongkang/checkpoint/qinshu/qinshu_extract_all_v4_qwen1_5_4b:/app/other_models \
    -v /platform_tech/models/Qwen1.5-14B-Chat:/app/other_models2 \
    -v ${model_path}:/app/models \
    -v ${log_path}:/app/logs \
    -v ${model_logs_path}:/app/model_logs \
    --name ${docker_name} fastchat-all:${version}