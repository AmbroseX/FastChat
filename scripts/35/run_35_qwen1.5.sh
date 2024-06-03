#!/bin/bash
./scripts/stop_worker.sh


echo "load Model: Qwen1.5-32B-Chat"  > ./logs/worker_35_Qwen1.5-32B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=3,4 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.35 --port 22032  \
    --worker-address http://192.168.80.35:22032 \
    --model-path /platform_tech/share_data/xiongrongkang/models/Qwen1.5-32B-Chat  \
    --model-name "Qwen1.5-32B-Chat" \
    --num-gpus 2 \
    --gpu_memory_utilization 0.8 \
    --max-model-len 8196 --worker-use-ray \
    --limit-worker-concurrency 20 \
    > ./logs/worker_35_Qwen1.5-32B-Chat.log 2>&1 &

echo "load Model: Qwen1.5-14B-Chat"  > ./logs/worker_35_Qwen1.5-14B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=5 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.35 --port 22014  \
    --worker-address http://192.168.80.35:22014 \
    --model-path /platform_tech/share_data/xiongrongkang/models/Qwen1.5-14B-Chat  \
    --model-name "Qwen1.5-14B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.8 \
    --max-model-len 8196 --worker-use-ray \
    --limit-worker-concurrency 20 \
    > ./logs/worker_35_Qwen1.5-14B-Chat.log 2>&1 &