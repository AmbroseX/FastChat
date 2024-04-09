# Qwen-1_8B-Chat
# nohup env CUDA_VISIBLE_DEVICES=4,5,6,7 python3 ./fastchat/serve/model_worker.py --num-gpus 4 --host 192.168.80.34 --port 22002 --worker http://192.168.80.34:22002 --controller-address http://192.168.80.34:22001 --model-name "Qwen-1_8B-Chat" --model-path /platform_tech/models/Qwen-1_8B-Chat  --max-gpu-memory '80Gib' --limit-worker-concurrency 20 > ./logs/worker.log 2>&1 &

# vllm方式启动
# 1个任务可以跑35tokens/s
# 3张A100 40G可以跑 接近50个并行，1810tokens/s
echo "load Model: Qwen1.5-14B-Chat" > ./logs/worker_79_Qwen1.5-14B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=2,3 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22014 \
    --worker-address http://192.168.190.79:22014 \
    --model-path /platform_tech/models/Qwen1.5-14B-Chat  \
    --model-name "Qwen1.5-14B-Chat" \
    --num-gpus 2 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_Qwen1.5-14B-Chat.log 2>&1 &