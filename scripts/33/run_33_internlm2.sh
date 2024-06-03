# internlm2
# internlm2-chat-7b
echo "load Model: internlm2-chat-7b" > ./logs/worker_internlm2-chat-7b.log
nohup env CUDA_VISIBLE_DEVICES=2 python3 ./fastchat/serve/model_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.33 --port 22011 \
    --worker-address http://192.168.80.33:22011 \
    --model-path /platform_tech/models/internlm2-chat-7b \
    --model-names internlm2-chat-7b \
    --limit-worker-concurrency 10 \
    >> ./logs/worker_internlm2-chat-7b.log 2>&1 &

# internlm2-chat-20b
echo "load Model: internlm2-chat-20b" > ./logs/worker_internlm2-chat-20b.log
nohup env CUDA_VISIBLE_DEVICES=2 python3 ./fastchat/serve/model_worker.py \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.80.33 --port 22012 \
    --worker-address http://192.168.80.33:22012 \
    --model-path /platform_tech/models/internlm2-chat-20b \
    --model-names internlm2-chat-20b \
    --limit-worker-concurrency 10 \
    >> ./logs/worker_internlm2-chat-20b.log 2>&1 &

# # internlm2-chat-20b
# # vllm方式启动
# nohup env CUDA_VISIBLE_DEVICES=5 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.72.34:22001 \
#     --host 192.168.80.33 --port 22008  \
#     --worker-address http://192.168.80.33:22008 \
#     --model-path /platform_tech/xiongrongkang/models/internlm2-chat-20b \
#     --model-name "internlm2-chat-20b" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.65 \
#     --max-model-len 32768 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     >> ./logs/worker_33.log 2>&1 &