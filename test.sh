

# 启动test Qwen-1_8B-Chat
# vllm 下 1个任务可以跑35tokens/s
# 一张A100 80G可以跑 接近50个并行，1810tokens/s
python3 ./fastchat/serve/test_throughput.py \
    --controller-address http://192.168.80.34:22001 \
    --test-dispatch \
    --model-name "Qwen-1_8B-Chat" \
    --max-new-tokens 2048 \
    --n-thread 100 \
    >> ./logs/test_throughput.log

# # 启动test Qwen-7B-Chat
# python3 ./fastchat/serve/test_throughput.py \
#     --controller-address http://192.168.80.34:22001 \
#     --test-dispatch \
#     --model-name "Qwen-7B-Chat" \
#     --max-new-tokens 2048 \
#     --n-thread 50 \
#     >> ./logs/test_throughput.log


# # 启动test Yi-34B-Chat
# python3 ./fastchat/serve/test_throughput.py \
#     --controller-address http://192.168.80.34:22001 \
#     --test-dispatch \
#     --model-name "Yi-34B-Chat" \
#     --max-new-tokens 2048 \
#     --n-thread 50 \
#     >> ./logs/test_throughput.log

# # 启动test Qwen-72B-Chat
# # 需要双卡A100 80G部署
# # vllm 下 1个任务可以跑 17tokens/s
# # 一张A100 80G可以跑 接近 12个并行，167tokens/s
# python3 ./fastchat/serve/test_throughput.py \
#     --controller-address http://192.168.80.34:22001 \
#     --test-dispatch \
#     --model-name "Qwen-72B-Chat" \
#     --max-new-tokens 2048 \
#     --n-thread 1 \
#     >> ./logs/test_throughput.log