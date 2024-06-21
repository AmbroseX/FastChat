# ./scripts/stop_worker.sh

export NODE_RANK=0,1
export NUM_GPUS=2

echo "load Model: worker_79_qinshu_extract_4b" > /platform_tech/logs/worker_79_qinshu_extract_4b.log
nohup env CUDA_VISIBLE_DEVICES=${NODE_RANK} python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.190.79 --port 22014  \
    --worker-address http://192.168.190.79:22014 \
    --model-path /platform_tech/xiongrongkang/checkpoint/qinshu/qwen4b_all_in_one_extract_17000/test_model_60 \
    --model-name "qinshu_extract_4b" \
    --num-gpus ${NUM_GPUS} \
    --gpu_memory_utilization 0.7 \
    --max-model-len 32768 --worker-use-ray \
    --enforce-eager \
    --limit-worker-concurrency 10 \
    >> /platform_tech/logs/worker_79_qinshu_extract_4b.log 2>&1 &