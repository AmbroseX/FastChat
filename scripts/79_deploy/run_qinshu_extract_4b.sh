# ./scripts/stop_worker.sh

export NODE_RANK=7
export NUM_GPUS=1
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_extract" > ./logs/worker_79_qinshu_extract.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.80.34:22001 \
    --host 192.168.190.79 --port 22081  \
    --worker-address http://192.168.190.79:22081 \
    --model-path /platform_tech/xiongrongkang/checkpoint/qinshu/qinshu_extract_all_v4_qwen1_5_4b \
    --model-name "qinshu_extract" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.85 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> ./logs/worker_79_qinshu_extract.log 2>&1 &