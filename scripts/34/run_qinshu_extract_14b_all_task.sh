./scripts/stop_worker.sh

export NODE_RANK=1,2
export NUM_GPUS=2
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_llm-qwen-alltask-eval" > /platform_tech/logs/worker_79_qinshu_llm-qwen-alltask-eval.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.72.34 --port 22086  \
    --worker-address http://192.168.72.34:22086 \
    --model-path /platform_tech/readpaper-models/paper-gpt/20240517-llm-qwen-alltask-eval-v2 \
    --model-name "llm-qwen-alltask-eval" \
    --conv-template qwen-7b-chat \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.7 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> /platform_tech/logs/worker_79_qinshu_llm-qwen-alltask-eval.log 2>&1 &