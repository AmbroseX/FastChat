#!/bin/bash
./scripts/stop_worker.sh


# Qwen-1_8B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --num-gpus 4 --host 192.168.80.34 --port 22002 --worker http://192.168.80.34:22002 --controller-address http://192.168.80.34:22001 --model-name "Qwen-1_8B-Chat" --model-path /platform_tech/models/Qwen-1_8B-Chat  --max-gpu-memory '80Gib' --limit-worker-concurrency 20 > ./logs/worker.log 2>&1 &

# vllm方式启动
# 1个任务可以跑35tokens/s
# 一张A100 80G可以跑 接近50个并行，1810tokens/s
nohup env CUDA_VISIBLE_DEVICES=4 python3 ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host localhost --port 22002  \
    --worker-address http://localhost:22002 \
    --model-path /platform_tech/models/Qwen-1_8B-Chat  \
    --model-name "Qwen-1_8B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.5 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 50 \
    > ./logs/worker_33.log 2>&1 &

# Qwen-7B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5 python3 ./fastchat/serve/model_worker.py --num-gpus 2 --host 192.168.80.34 --port 22004 --worker http://192.168.80.34:22004  --controller-address http://192.168.80.34:22001 --model-name "Qwen-7B-Chat" --model-path /platform_tech/models/Qwen-7B-Chat  --max-gpu-memory '80Gib' >> ./logs/worker.log 2>&1 &

# vllm方式启动
nohup env CUDA_VISIBLE_DEVICES=4 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host localhost --port 22003  \
    --worker-address http://localhost:22003 \
    --model-path /platform_tech/models/Qwen-7B-Chat \
    --model-name "Qwen-7B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.75 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_33.log 2>&1 &

# Qwen-14B-Chat
# nohup env CUDA_VISIBLE_DEVICES=5 python3 ./fastchat/serve/model_worker.py --num-gpus 2 --host 192.168.80.34 --port 22003 --worker http://192.168.80.34:22004  --controller-address http://192.168.80.34:22001 --model-name "Qwen-14B-Chat" --model-path /platform_tech/models/Qwen-14B-Chat  --max-gpu-memory '80Gib' >> ./logs/worker.log 2>&1 &
# # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=5 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.80.34:22001 \
#     --host 192.168.80.34 --port 22004  \
#     --worker-address http://192.168.80.34:22004 \
#     --model-path /platform_tech/models/Qwen-14B-Chat \
#     --model-name "Qwen-14B-Chat" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.7 \
#     --max-model-len 8192 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker.log 2>&1 &