#!/bin/bash
# ./scripts/stop_worker.sh

echo "load Model: Meta-Llama-3-8B-Instruct "  > ./logs/worker_34_Meta-Llama-3-8B-Instruct.log
nohup env CUDA_VISIBLE_DEVICES=2 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22002  \
    --worker-address http://192.168.72.34:22002 \
    --model-path /platform_tech/models/Meta-Llama-3-8B-Instruct   \
    --model-name "Meta-Llama-3-8B-Instruct" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20 \
    > ./logs/worker_34_Meta-Llama-3-8B-Instruct.log 2>&1 &

