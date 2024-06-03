# ./scripts/stop_worker.sh

export NODE_RANK=2,3
export NUM_GPUS=2
export RAY_memory_monitor_refresh_ms=0
echo "load Model: worker_79_qinshu_worker_llm-qwen-catalog-eval" > /platform_tech/logs/worker_79_qinshu_llm-qwen-catalog-eval.log
# '/platform_tech/readpaper-models/paper-gpt/20240428-llm-qwen-catalog-eval'
# /platform_tech/sunshuanglong/outputs/qwen14b_12000_mulu_0425/global_step12_merge
# /platform_tech/readpaper-models/paper-gpt/20240517-llm-qwen-catalog-eval-v2 \
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.72.34:22001 \
    --host 192.168.190.79 --port 22085  \
    --worker-address http://192.168.190.79:22085 \
    --model-path  /platform_tech/readpaper-models/paper-gpt/20240428-llm-qwen-catalog-eval \
    --model-name "llm-qwen-catalog-eval" \
    --conv-template qwen-7b-chat \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.9 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 20 \
    >> /platform_tech/logs/worker_79_qinshu_llm-qwen-catalog-eval.log 2>&1 &