./scripts/stop_worker.sh
# Qwen-1_8B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --num-gpus 4 --host 192.168.72.34 --port 22002 --worker http://192.168.72.34:22002 --controller-address http://192.168.72.34:22001 --model-name "Qwen-1_8B-Chat" --model-path /platform_tech/models/Qwen-1_8B-Chat  --max-gpu-memory '80Gib' --limit-worker-concurrency 20 > ./logs/worker.log 2>&1 &

# vllm方式启动
# 1个任务可以跑35tokens/s
# 一张A100 80G可以跑 接近50个并行，1810tokens/s
echo "load Model: Qwen1.5-4B-Chat" > ./logs/worker_79_Qwen1.5-4B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=1,2 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.79 --port 22002  \
    --worker-address http://192.168.190.79:22002 \
    --model-path /platform_tech/models/Qwen1.5-4B-Chat  \
    --model-name "Qwen1.5-4B-Chat" \
    --num-gpus 2 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 8192 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_Qwen1.5-4B-Chat.log 2>&1 &


echo "load Model: Qwen1.5-1.8B-Chat" > ./logs/worker_79_Qwen1.5-1.8B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=3 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.79 --port 22003 \
    --worker-address http://192.168.190.79:22003 \
    --model-path /platform_tech/models/Qwen1.5-1.8B-Chat  \
    --model-name "Qwen1.5-1.8B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 8192 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_Qwen1.5-1.8B-Chat.log 2>&1 &

# Qwen-7B-Chat
# vllm方式启动
# echo "load Model: Qwen-7B-Chat" > ./logs/worker_Qwen-7B-Chat.log
# nohup env CUDA_VISIBLE_DEVICES=4 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22003  \
#     --worker-address http://192.168.80.33:22003 \
#     --model-path /platform_tech/models/Qwen-7B-Chat \
#     --model-name "Qwen-7B-Chat" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.85 \
#     --max-model-len 8192 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker_Qwen-7B-Chat.log 2>&1 &



# Qwen1.5-14B-Chat
# 40个注意头
# vllm方式启动
echo "load Model: Qwen1.5-14B-Chat"  > ./logs/worker_79_Qwen1.5-14B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3  -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.79 --port 22010 \
    --worker-address http://192.168.190.79:22010   \
    --model-path /platform_tech/models/Qwen1.5-14B-Chat \
    --model-name "Qwen1.5-14B-Chat" \
    --num-gpus 4 \
    --gpu_memory_utilization 0.8 \
    --max-model-len 32768 --worker-use-ray \
    --limit-worker-concurrency 20 \
    --tokenizer-mode "auto" \
    --enforce-eager \
    >> ./logs/worker_79_Qwen1.5-14B-Chat.log 2>&1 &

# Qwen-14B-Chat
# echo "load Model: Qwen-14B-Chat"  > ./logs/worker_Qwen-14B-Chat.log
# nohup env CUDA_VISIBLE_DEVICES=4 python3 ./fastchat/serve/model_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22010 \
#     --worker http://192.168.80.33:22010   \
#     --model-name "Qwen-14B-Chat" \
#     --model-path /platform_tech/models/Qwen-14B-Chat \
#     >> ./logs/worker_Qwen-14B-Chat.log 2>&1 &


# Qwen-72B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --host 192.168.72.34 --port 22003 --worker http://192.168.72.34:22003 --controller-address http://192.168.72.34:22001   --max-gpu-memory '80Gib' > ./logs/worker.log 2>&1 &
# Qwen-72B模型半精度FP16载入需要144GB以上的显存（例如2xA100-80G或5xV100-32G）
# https://zhuanlan.zhihu.com/p/670484123
# # vllm方式启动
# echo "Qwen-72B-Chat" > ./logs/worker_Qwen-72B-Chat.log
# nohup env CUDA_VISIBLE_DEVICES=6,7,0,1 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22009  \
#     --worker-address http://192.168.80.33:22009 \
#     --model-path /platform_tech/models/Qwen-72B-Chat \
#     --model-name "Qwen-72B-Chat" \
#     --num-gpus 4 \
#     --tensor-parallel-size 4 \
#     --gpu_memory_utilization 0.6  \
#     --dtype bfloat16 \
#     --max-model-len 8192 \
#     --worker-use-ray \
#     --enforce-eager \
#     --limit-worker-concurrency 6 \
#     >> ./logs/worker_Qwen-72B-Chat.log 2>&1 &