from pprint import pprint
from pathlib import Path
from typing import Optional, Literal
from dataclasses import dataclass, field
import json
import transformers
import pandas as pd
from tqdm import tqdm
import time
tokenizer = transformers.AutoTokenizer.from_pretrained('/platform_tech/xiongrongkang/checkpoint/qinshu/qwen14b_mulu_0530_add_special_token_all_in_one_12000/test_model_1700', use_fast=False)  
# data_path = "/home/xiongrongkang/WorkSpace/Code/llm/FastChat/temp/data.txt"
data_path = '/home/xiongrongkang/WorkSpace/Code/llm/FastChat/temp/data.json'

time_start = time.time()
def count_tokens(texts):
    inputs = tokenizer.batch_encode_plus(texts)
    input_ids = inputs["input_ids"]
    return [len(x) for x in input_ids]

def read_json(file_path: str) -> dict: # type: ignore
    """
    读取JSON文件并返回字典
    :param file_path: JSON文件的路径
    :return: JSON文件内容转换后的字典
    """
    try:
        with open(file_path, 'r', encoding='utf-8') as file:
           data = json.load(file)
        return data
    except Exception as e:
        print(f"读取JSON文件失败：{file_path}，错误信息：{e}")
        raise BaseException(f"读取JSON文件失败：{file_path}，错误信息：{e}")

with open(data_path, "r") as f:
    text = f.read()

text_json = read_json(data_path)

text_trunk =  ['段落id'+str(item['id'])+'\n'+item['goldenContent'] for item in text_json]

num = count_tokens(text_trunk)
total_num = sum(num)
time_end = time.time()
print(f"tiem:{time_end-time_start},Number of text:{len(text)}, Number of tokens: {total_num}")


# 字符 token
# 21746,15730
# 63113,37840

# @dataclass
# class Arguments:
#     # tokenizer_name_or_path: str = field(default="/platform_tech/models/deepseek-llm-7b-base-ckpt")
#     tokenizer_name_or_path: str = field(default="/platform_tech/models/Qwen1.5-14B-ckpt")
#     data_path: str = field(default="./temp/data.txt")
# def main():
#     parser = transformers.HfArgumentParser((Arguments,))
#     args, = parser.parse_args_into_dataclasses()

#     # tokenizer = transformers.AutoTokenizer.from_pretrained(args.tokenizer_name_or_path, use_fast=False)  
#     print(f"Began loaded tokenizer: {args.tokenizer_name_or_path}")
#     tokenizer = transformers.AutoTokenizer.from_pretrained(args.tokenizer_name_or_path)  # deepseek use_fast=False会报错
#     print(f"loaded tokenizer: {args.tokenizer_name_or_path}")
#     data_path = args.data_path
    


#     with open(data_path, "r") as f:
#         text = f.read()

#     num = _count_tokens([text])
#     print(f"Number of tokens: {num[0]}")

# python ./scripts/cal_token.py --data_path ./temp/data.txt