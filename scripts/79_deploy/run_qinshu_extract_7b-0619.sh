# ./scripts/stop_worker.sh

export NODE_RANK=7
export NUM_GPUS=1


echo "load Model: worker_79_qinshu_extract_7b"  > /platform_tech/logs/worker_79_qinshu_extract_7b.log
nohup env CUDA_VISIBLE_DEVICES=2,3 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.190.79 --port 22007  \
    --worker-address http://192.168.190.79:22007 \
    --model-path /platform_tech/xiongrongkang/checkpoint/qinshu/qwen7b_all_in_one_extract_15000/test_model_60  \
    --model-name "qinshu_extract_7b" \
    --num-gpus 2 \
    --gpu_memory_utilization 0.75 \
    --enforce-eager \
    --max-model-len 32000 --worker-use-ray \
    --limit-worker-concurrency 10 \
    > /platform_tech/logs/worker_79_qinshu_extract_7b.log 2>&1 &
