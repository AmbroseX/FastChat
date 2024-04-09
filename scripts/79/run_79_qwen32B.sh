# Qwen-1_8B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --num-gpus 4 --host 192.168.80.34 --port 22002 --worker http://192.168.80.34:22002 --controller-address http://192.168.80.34:22001 --model-name "Qwen-1_8B-Chat" --model-path /platform_tech/models/Qwen-1_8B-Chat  --max-gpu-memory '80Gib' --limit-worker-concurrency 20 > ./logs/worker.log 2>&1 &

# vllm方式启动
# 1个任务可以跑35tokens/s
# 一张A100 80G可以跑 27.5 tokens/s
echo "load Model: Qwen1.5-32B-Chat" > ./logs/worker_79_Qwen1.5-32B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22032 \
    --worker-address http://192.168.190.79:22032 \
    --model-path /platform_tech/models/Qwen1.5-32B-Chat  \
    --model-name "Qwen1.5-32B-Chat" \
    --num-gpus 4 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_Qwen1.5-32B-Chat.log 2>&1 &