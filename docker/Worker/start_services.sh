#!/bin/bash
pip config set global.progress_bar off

# docker内部的id从0开始计数

export CUDA_VISIBLE_DEVICES=1,6

# 检查环境变量NUM_GPUS是否已经设置
if [ -z "$NUM_GPUS" ]; then
    echo "环境变量NUM_GPUS未设置。"
    exit 1
fi
# 检查NUM_GPUS是否为数字
if ! [[ "$NUM_GPUS" =~ ^[0-9]+$ ]]; then
    echo "环境变量NUM_GPUS必须是一个正整数。"
    exit 1
fi
# 生成从0到NUM_GPUS-1的序列
FASTCHAT_DOCKER_CUDA_DEVICE=$(seq -s ',' 0 $((NUM_GPUS - 1)))
# 设置环境变量FASTCHAT_DOCKER_CUDA_DEVICE
export FASTCHAT_DOCKER_CUDA_DEVICE
echo "已设置FASTCHAT_DOCKER_CUDA_DEVICE为$FASTCHAT_DOCKER_CUDA_DEVICE"

if [ ${USE_WORKER} == "VLLM_WORKER" ]; then
    echo "load Model: worker_${FASTCHAT_WORKER_MODEL_NAMES}" > ./logs/worker_${FASTCHAT_WORKER_MODEL_NAMES}.log
    nohup env CUDA_VISIBLE_DEVICES=${FASTCHAT_DOCKER_CUDA_DEVICE} python3 -m fastchat.serve.vllm_worker \
        --controller-address http://${FASTCHAT_CONTROLLER_ADDRESS}:${FASTCHAT_CONTROLLER_PORT} \
        --host ${FASTCHAT_WORKER_ADDRESS} --port ${FASTCHAT_WORKER_PORT} \
        --worker-address http://${FASTCHAT_WORKER_ADDRESS}:${FASTCHAT_WORKER_PORT} \
        --model-name ${FASTCHAT_WORKER_MODEL_NAMES} \
        --model-path ${FASTCHAT_WORKER_MODEL_PATH} \
        --num-gpus ${NUM_GPUS} \
        --gpu_memory_utilization ${GPU_MEMORY_UTILIZATION} \
        --max-model-len ${MAX_MODEL_LEN} --worker-use-ray \
        --enforce-eager \
        --limit-worker-concurrency ${LIMIT_WORKER} \
        --log-level ${FASTCHAT_LOG_LEVEL} \
        >> ./logs/worker_${FASTCHAT_WORKER_MODEL_NAMES}.log 2>&1 &
elif [ ${USE_WORKER} == "MODEL_WORKER" ]; then
    # 启动 fastchat-model-worker 服务
    echo "load Model: worker_${FASTCHAT_WORKER_MODEL_NAMES}" > ./logs/worker_${FASTCHAT_WORKER_MODEL_NAMES}.log
    env CUDA_VISIBLE_DEVICES="${FASTCHAT_DOCKER_CUDA_DEVICE}" python3 -m fastchat.serve.model_worker \
        --controller-address "http://${FASTCHAT_CONTROLLER_ADDRESS}:${FASTCHAT_CONTROLLER_PORT}" \
        --worker-address "http://${FASTCHAT_WORKER_ADDRESS}:${FASTCHAT_WORKER_PORT}" \
        --host ${FASTCHAT_WORKER_ADDRESS} --port ${FASTCHAT_WORKER_PORT} \
        --model-names "${FASTCHAT_WOKRER_MODEL_NAMES}" \
        --model-path "${FASTCHAT_WORKER_MODEL_PATH}" \
        --num-gpus ${NUM_GPUS} \
        --limit-worker-concurrency ${LIMIT_WORKER} \
        >> ./logs/worker_${FASTCHAT_WORKER_MODEL_NAMES}.log 2>&1 &
echo "Invalid USE_COMMAND value. Please set USE_WORKER to VLLM_WORKER or MODEL_WORKER"
fi

# 等待所有后台进程
wait