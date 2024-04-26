# ./scripts/stop_worker.sh

export NODE_RANK=4,5
export NUM_GPUS=2
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_worker_global_step848_merge" > ./logs/worker_79_qinshu_worker_global_step848_merge.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22086  \
    --worker-address http://192.168.190.79:22086 \
    --model-path /platform_tech/sunshuanglong/outputs/20240417_qinshu_step1_qwen1_5_14b_13000_v2/global_step852_merge \
    --model-name "global_step848_merge" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.9 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_qinshu_worker_global_step848_merge.log 2>&1 &