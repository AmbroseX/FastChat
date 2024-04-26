# ./scripts/stop_worker.sh

export NODE_RANK=7
export NUM_GPUS=1
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_global_step848_merge" > ./logs/worker_79_global_step848_merge.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22081  \
    --worker-address http://192.168.190.79:22081 \
    --model-path /platform_tech/sunshuanglong/outputs/20240403_qinshu_step1_qwen1_5_14b_13000/global_step848_merge \
    --model-name "global_step848_merge" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.85 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_global_step848_merge.log 2>&1 &