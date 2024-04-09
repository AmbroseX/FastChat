# chatglm3-6b
# vllm方式启动
echo "load Model: chatglm3-6b" > ./logs/worker_chatglm3-6b.log
nohup env CUDA_VISIBLE_DEVICES=5 python3  ./fastchat/serve/vllm_worker.py \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.80.33 --port 22005  \
    --worker-address http://192.168.80.33:22005 \
    --model-path /platform_tech/models/chatglm3-6b \
    --model-name "chatglm3-6b" \
    --num-gpus 1 \
    --gpu_memory_utilization 0.5 \
    --max-model-len 8192 --worker-use-ray \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_chatglm3-6b.log 2>&1 &

# # chatglm3-6b-32k
# # vllm方式启动
# echo "load Model: chatglm3-6b-32k" > ./logs/worker_chatglm3-6b-32k.log
# nohup env CUDA_VISIBLE_DEVICES=5 python3  ./fastchat/serve/vllm_worker.py \
#     --controller-address http://192.168.80.34:22001 \
#     --host 192.168.80.33 --port 22006 \
#     --worker-address http://192.168.80.33:22006 \
#     --model-path /platform_tech/models/chatglm3-6b-32k \
#     --model-name "chatglm3-6b-32k" \
#     --num-gpus 1 \
#     --gpu_memory_utilization 0.85 \
#     --max-model-len 32768 --worker-use-ray \
#     --limit-worker-concurrency 20 \
#     --enforce-eager \
#     >> ./logs/worker_chatglm3-6b-32k.log 2>&1 &