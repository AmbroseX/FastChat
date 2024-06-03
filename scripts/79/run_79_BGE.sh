# ./scripts/stop_worker.sh

echo "load Model: bge-small-zh-v1.5" > ./logs/worker_79_bge-small-zh-v1.5.log
# nohup env CUDA_VISIBLE_DEVICES=6 python3 -m fastchat.serve.vllm_worker \
nohup env CUDA_VISIBLE_DEVICES=6 python3 -m fastchat.serve.model_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.79 --port 22092  \
    --worker-address http://192.168.190.79:22092 \
    --model-path /platform_tech/models/bge-small-zh-v1.5  \
    --model-name "bge-small-zh-v1.5" \
    --device cpu \
    --num-gpus 1 \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_bge-small-zh-v1.5.log 2>&1 &