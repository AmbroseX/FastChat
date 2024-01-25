#!/bin/bash
./scripts/stop_worker.sh

# Yi-34B-200K
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --host 192.168.80.34 --port 22003 --worker http://192.168.80.34:22003 --controller-address http://192.168.80.34:22001   --max-gpu-memory '80Gib' > ./logs/worker.log 2>&1 &

# # vllm方式启动
# # 1个任务可以跑35tokens/s
# # 一张A100 80G可以跑 接近50个并行，1810tokens/s
# nohup env CUDA_VISIBLE_DEVICES=1,2 python3 ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.190.73:22001 \
#     --host 192.168.190.73 --port 22002  \
#     --worker-address http://192.168.190.73:22002 \
#     --model-path /platform_tech/models/Qwen-1_8B-Chat  \
#     --model-name "Qwen-1_8B-Chat" \
#     --num-gpus 2 \
#     --gpu_memory_utilization 0.15 \
#     --max-model-len 8192 --worker-use-ray \
#     --limit-worker-concurrency 50 \
#     >> ./logs/worker_73.log 2>&1 &

# # # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.190.73:22001 \
#     --host 192.168.190.73 --port 22005  \
#     --worker-address http://192.168.190.73:22005 \
#     --model-path /platform_tech/models/Yi-34B-200K \
#     --model-name "Yi-34B-200K" \
#     --tensor-parallel-size 4 \
#     --gpu_memory_utilization 0.95 \
#     --dtype float16 \
#     --max-model-len 32768 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     > ./logs/worker_73_Yi.log 2>&1 &


# # vllm方式启动
nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.73 --port 22006  \
    --worker-address http://192.168.190.73:22006 \
    --model-path /platform_tech/models/Yi-34B-Chat \
    --model-name "Yi-34B-Chat" \
    --dtype half \
    --tensor-parallel-size 4 \
    --gpu_memory_utilization 0.95 \
    --max-model-len 32768 --worker-use-ray \
    --limit-worker-concurrency 20 \
    --enforce-eager \
    > ./logs/worker_73.log 2>&1 &
