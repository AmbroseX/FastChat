# Baichuan2-7B-Chat
# vllm方式启动
# echo "load Model: Baichuan2-7B-Chat" > ./logs/worker_Baichuan2-7B-Chat.log
# nohup env CUDA_VISIBLE_DEVICES=3 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22004  \
#     --worker-address http://192.168.80.33:22004 \
#     --model-path /platform_tech/models/Baichuan2-7B-Chat \
#     --model-name "Baichuan2-7B-Chat" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.85 \
#     --max-model-len 4096 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     --tokenizer-mode "auto" \
#     --enforce-eager \
#     >> ./logs/worker_Baichuan2-7B-Chat.log 2>&1 &


# Baichuan2-13B-Chat
# vllm方式启动
echo "load Model: Baichuan2-13B-Chat" > ./logs/worker_Baichuan2-13B-Chat.log
nohup env CUDA_VISIBLE_DEVICES=3 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.33 --port 22007  \
    --worker-address http://192.168.80.33:22007 \
    --model-path /platform_tech/models/Baichuan2-13B-Chat \
    --model-name "Baichuan2-13B-Chat" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.85 \
    --max-model-len 4096 --worker-use-ray \
    --limit-worker-concurrency 20 \
    --tokenizer-mode "auto" \
    --enforce-eager \
    >> ./logs/worker_Baichuan2-13B-Chat.log 2>&1 &