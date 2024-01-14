

# 启动test Qwen-1_8B-Chat
python3 ./fastchat/serve/test_throughput.py \
    --controller-address http://192.168.80.34:22001 \
    --test-dispatch \
    --model-name "Qwen-1_8B-Chat" \
    --max-new-tokens 2048 \
    --n-thread 1 \
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