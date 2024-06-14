#!/bin/bash
# ./scripts/stop_worker.sh

# # vllm方式启动
echo "load Model: Qwen1.5-14B-Chat"  > /platform_tech/logs/worker_34_Qwen1.5-14B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=1 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.72.34 --port 22004  \
    --worker-address http://192.168.72.34:22004 \
    --model-path /platform_tech/models/Qwen1.5-14B-Chat \
    --model-name "Qwen1.5-14B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.95 \
    --max-model-len 32000 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> /platform_tech/logs//worker_34_Qwen1.5-14B-Chat.log 2>&1 &
