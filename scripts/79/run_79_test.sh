echo "load Model: Qwen1.5-1.8B-Chat" > ./logs/worker_79_Qwen1.5-1.8B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=6 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:23001 \
    --host 192.168.190.79 --port 23003 \
    --worker-address http://192.168.190.79:23003 \
    --model-path /platform_tech/models/Qwen1.5-1.8B-Chat  \
    --model-name "Qwen1.5-1.8B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 8192 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_Qwen1.5-1.8B-Chat.log 2>&1 &