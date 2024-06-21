./scripts/stop_worker.sh
echo "load Model: worker_79_qinshu_all_in_one_14"  > /platform_tech/logs/worker_79_qinshu_all_in_one_14.log
nohup env CUDA_VISIBLE_DEVICES=0,1 python3 -m fastchat.serve.vllm_worker \
    --controller-address http://192.168.190.79:22001 \
    --host 192.168.190.79 --port 22014  \
    --worker-address http://192.168.190.79:22014 \
    --model-path /platform_tech/xiongrongkang/checkpoint/qinshu/qwen14b_all_in_one_11000/test_model_1600  \
    --model-name "qinshu_all_in_one_14" \
    --num-gpus 2 \
    --gpu_memory_utilization 0.95 \
    --enforce-eager \
    --max-model-len 32000 --worker-use-ray \
    --limit-worker-concurrency 10 \
    > /platform_tech/logs/worker_79_qinshu_all_in_one_14.log 2>&1 &
