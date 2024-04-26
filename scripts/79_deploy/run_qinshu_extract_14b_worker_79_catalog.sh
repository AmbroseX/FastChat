./scripts/stop_worker.sh

export NODE_RANK=2,3
export NUM_GPUS=2
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_worker_79_catalog" > ./logs/worker_79_qinshu_worker_79_catalog.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22085  \
    --worker-address http://192.168.190.79:22085 \
    --model-path /platform_tech/sunshuanglong/outputs/qwen14b_12000_mulu_0425/global_step12_merge \
    --model-name "worker_79_catalog" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.9 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_qinshu_worker_79_catalog.log 2>&1 &