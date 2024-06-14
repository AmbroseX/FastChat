#!/bin/bash
./scripts/stop_worker.sh


echo "load Model: Qwen1.5-1.8B-Chat"  > /platform_tech/logs/worker_34_Qwen1.5-1.8B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=7 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.72.34 --port 22002  \
    --worker-address http://192.168.72.34:22002 \
    --model-path /platform_tech/models/Qwen1.5-1.8B-Chat  \
    --model-name "Qwen1.5-1.8B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.5 \
    --max-model-len 16000 --worker-use-ray \
    --limit-worker-concurrency 50 \
    > /platform_tech/logs/worker_34_Qwen1.5-1.8B-Chat.log 2>&1 &

# Qwen-7B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5 python3 ./fastchat/serve/model_worker.py --num-gpus 2 --host 192.168.72.34 --port 22004 --worker http://192.168.72.34:22004  --controller-address http://192.168.72.34:22001 --model-name "Qwen-7B-Chat" --model-path /platform_tech/models/Qwen-7B-Chat  --max-gpu-memory '80Gib' >> ./logs/worker.log 2>&1 &

# # vllm方式启动
echo "load Model: Qwen1.5-7B-Chat"  > /platform_tech/logs/worker_34_Qwen1.5-7B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=2 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.72.34 --port 22003  \
    --worker-address http://192.168.72.34:22003 \
    --model-path /platform_tech/models/Qwen1.5-7B-Chat \
    --model-name "Qwen1.5-7B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 16000 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> /platform_tech/logs//worker_34_Qwen1.5-7B-Chat.log 2>&1 &
