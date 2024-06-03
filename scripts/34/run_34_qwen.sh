#!/bin/bash
./scripts/stop_worker.sh

# Qwen-1_8B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --num-gpus 4 --host 192.168.72.34 --port 22002 --worker http://192.168.72.34:22002 --controller-address http://192.168.72.34:22001 --model-name "Qwen-1_8B-Chat" --model-path /platform_tech/models/Qwen-1_8B-Chat  --max-gpu-memory '80Gib' --limit-worker-concurrency 20 > ./logs/worker.log 2>&1 &

# vllm方式启动
# 1个任务可以跑35tokens/s
# 一张A100 80G可以跑 接近50个并行，1810tokens/s
echo "load Model: Qwen-14B-Chat"  > ./logs/worker_34_Qwen-1_8B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=2 python3 ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22002  \
    --worker-address http://192.168.72.34:22002 \
    --model-path /platform_tech/models/Qwen-1_8B-Chat  \
    --model-name "Qwen-1_8B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.5 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 50 \
    > ./logs/worker_34_Qwen-1_8B-Chat.log 2>&1 &

# Qwen-7B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5 python3 ./fastchat/serve/model_worker.py --num-gpus 2 --host 192.168.72.34 --port 22004 --worker http://192.168.72.34:22004  --controller-address http://192.168.72.34:22001 --model-name "Qwen-7B-Chat" --model-path /platform_tech/models/Qwen-7B-Chat  --max-gpu-memory '80Gib' >> ./logs/worker.log 2>&1 &

# vllm方式启动
echo "load Model: Qwen-14B-Chat"  > ./logs//worker_34_Qwen-7B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=2 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22003  \
    --worker-address http://192.168.72.34:22003 \
    --model-path /platform_tech/models/Qwen-7B-Chat \
    --model-name "Qwen-7B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.75 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> ./logs//worker_34_Qwen-7B-Chat.log 2>&1 &

# Qwen-14B-Chat
# nohup env CUDA_VISIBLE_DEVICES=5 python3 ./fastchat/serve/model_worker.py --num-gpus 2 --host 192.168.72.34 --port 22003 --worker http://192.168.72.34:22004  --controller-address http://192.168.72.34:22001 --model-name "Qwen-14B-Chat" --model-path /platform_tech/models/Qwen-14B-Chat  --max-gpu-memory '80Gib' >> ./logs/worker.log 2>&1 &
# # vllm方式启动
echo "load Model: Qwen-14B-Chat"  > ./logs/worker_34_Qwen-14B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=6 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22004  \
    --worker-address http://192.168.72.34:22004 \
    --model-path /platform_tech/xiongrongkang/models/Qwen-14B-Chat \
    --model-name "Qwen-14B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.7 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_34_Qwen-14B-Chat.log 2>&1 &


# Yi-34B-200K
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --host 192.168.72.34 --port 22003 --worker http://192.168.72.34:22003 --controller-address http://192.168.72.34:22001   --max-gpu-memory '80Gib' > ./logs/worker.log 2>&1 &

# # # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=6,7 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.72.34 --port 22005  \
#     --worker-address http://192.168.72.34:22005 \
#     --model-path /platform_tech/models/Yi-34B-200K \
#     --model-name "Yi-34B-200K" \
#     --num-gpus 2 \
#     --gpu_memory_utilization 0.95 \
#     --max-model-len 200000 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker.log 2>&1 &


# Qwen-72B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --host 192.168.72.34 --port 22003 --worker http://192.168.72.34:22003 --controller-address http://192.168.72.34:22001   --max-gpu-memory '80Gib' > ./logs/worker.log 2>&1 &

# # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=5,6 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.72.34 --port 22006  \
#     --worker-address http://192.168.72.34:22006 \
#     --model-path /platform_tech/models/Qwen-72B-Chat \
#     --model-name "Qwen-72B-Chat" \
#     --num-gpus 2 \
#     --tensor-parallel-size 2 \
#     --gpu_memory_utilization 0.98 \
#     --dtype bfloat16 \
#     --max-model-len 32768 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker.log 2>&1 &
