./scripts/stop_worker.sh
# Qwen-14B-Chat
# vllm方式启动
# echo "load Model: Qwen-14B-Chat" > ./logs/worker_73_Qwen-14B-Chat.log
# nohup env CUDA_VISIBLE_DEVICES=1,2,3,4 python3  -m fastchat.serve.vllm_worker \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.190.73 --port 22011 \
#     --worker-address http://192.168.190.73:22011 \
#     --model-path /platform_tech/models/Qwen1.5-14B-Chat \
#     --model-name "Qwen1.5-14B-Chat" \
#     --num-gpus 4 \
#     --conv-template qwen-7b-chat \
#     --gpu_memory_utilization 0.25 \
#     --max-model-len 4096 --worker-use-ray \
#     --enforce-eager \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker_73_Qwen-14B-Chat.log 2>&1 &


echo "load Model: Qwen-7B-Chat" > ./logs/worker_73_Qwen-7B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=1,2,3,4 python3  -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.73 --port 22011 \
    --worker-address http://192.168.190.73:22011 \
    --model-path /platform_tech/models/Qwen1.5-7B-Chat \
    --model-name "Qwen1.5-7B-Chat" \
    --num-gpus 4 \
    --conv-template qwen-7b-chat \
    --gpu_memory_utilization 0.25 \
    --max-model-len 4096 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_73_Qwen-7B-Chat.log 2>&1 &