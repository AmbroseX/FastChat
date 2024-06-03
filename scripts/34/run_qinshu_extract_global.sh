./scripts/stop_worker.sh

export NODE_RANK=1
export NUM_GPUS=1
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_global" > ./logs/worker_79_qinshu_global.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22081  \
    --worker-address http://192.168.72.34:22081 \
    --model-path /platform_tech/xiongrongkang/checkpoint/global_step848_merge \
    --model-name "qinshu_global" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.85 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_qinshu_global.log 2>&1 &