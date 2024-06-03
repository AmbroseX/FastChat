#!/bin/bash

# 定义要查找和终止的进程名称
process_names=(
    "run_qwen_14B.sh")

# 遍历每个进程名称
for name in "${process_names[@]}"; do
    echo "正在查找和终止所有相关的 $name 进程..."

    # 使用 pgrep 查找所有匹配的进程 ID
    pids=$(pgrep -f $name)

    # 检查是否找到了进程 ID
    if [ -z "$pids" ]; then
        echo "没有找到与 $name 相关的进程。"
    else
        # 遍历并终止每个找到的进程
        for pid in $pids; do
            echo "终止进程 $pid (属于 $name)"
            kill -9 $pid
        done
    fi
done

echo "所有指定进程已处理完毕。"
env CUDA_VISIBLE_DEVICES=4 python3 ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.33 --port 22004  \
    --worker-address http://192.168.80.33:22004 \
    --model-path /platform_tech/models/Qwen-14B-Chat  \
    --model-name "Qwen-14B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.95 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20
    > ./logs/worker_Qwen_14B.log 2>&1 &

# nohup env CUDA_VISIBLE_DEVICES=4 python3 ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22004  \
#     --worker-address http://192.168.80.33:22004 \
#     --model-path /platform_tech/models/Qwen-14B-Chat  \
#     --model-name "Qwen-14B-Chat" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.95 \
#     --max-model-len 8192 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     > ./logs/worker_Qwen-14B-Chat.log 2>&1 &

# # # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=7 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.190.73 --port 22004  \
#     --worker-address http://192.168.190.73:22004 \
#     --model-path /platform_tech/models/Qwen-14B-Chat \
#     --model-name "Qwen-14B-Chat" \
#     --dtype half \
#     --gpu_memory_utilization 0.95 \
#     --max-model-len 32768 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     --enforce-eager \
#     > ./logs/worker_Qwen-14B-Chat.log 2>&1 &