# Copyright (c) Alibaba Cloud.
#
# This source code is licensed under the license found in the
# LICENSE file in the root directory of this source tree.

"""A simple web interactive chat demo based on gradio."""
import os
from argparse import ArgumentParser
from threading import Thread

import gradio as gr
import mdtex2html

import torch
from transformers import AutoModelForCausalLM, AutoTokenizer, TextIteratorStreamer
from transformers.generation import GenerationConfig

DEFAULT_CKPT_PATH = "/platform_tech/models/Qwen1.5-1.8B-Chat"

if os.path.exists(DEFAULT_CKPT_PATH):
    DEFAULT_CKPT_PATH = os.path.abspath(DEFAULT_CKPT_PATH)
else:
    DEFAULT_CKPT_PATH = 'Qwen/Qwen-7B-Chat'

def _get_args():
    parser = ArgumentParser()
    parser.add_argument("-c", "--checkpoint-path", type=str, default=DEFAULT_CKPT_PATH,
                        help="Checkpoint name or path, default to %(default)r")
    parser.add_argument("--cpu-only", action="store_true", help="Run demo with CPU only")

    parser.add_argument("--share", action="store_true", default=False,
                        help="Create a publicly shareable link for the interface.")
    parser.add_argument("--inbrowser", action="store_true", default=False,
                        help="Automatically launch the interface in a new tab on the default browser.")
    parser.add_argument("--server-port", type=int, default=8000,
                        help="Demo server port.")
    parser.add_argument("--server-name", type=str, default="127.0.0.1",
                        help="Demo server name.")

    args = parser.parse_args()
    return args


def _load_model_tokenizer(args):
    tokenizer = AutoTokenizer.from_pretrained(
        args.checkpoint_path, trust_remote_code=True, resume_download=True,
    )

    if args.cpu_only:
        device_map = "cpu"
    else:
        device_map = "auto"

    model = AutoModelForCausalLM.from_pretrained(
        args.checkpoint_path,
        device_map=device_map,
        trust_remote_code=True,
        resume_download=True,
    ).eval()

    config = GenerationConfig.from_pretrained(
        args.checkpoint_path, trust_remote_code=True, resume_download=True,
    )

    return model, tokenizer, config


def postprocess(self, y):
    if y is None:
        return []
    for i, (message, response) in enumerate(y):
        y[i] = (
            None if message is None else mdtex2html.convert(message),
            None if response is None else mdtex2html.convert(response),
        )
    return y


gr.Chatbot.postprocess = postprocess


def _parse_text(text):
    lines = text.split("\n")
    lines = [line for line in lines if line != ""]
    count = 0
    for i, line in enumerate(lines):
        if "```" in line:
            count += 1
            items = line.split("`")
            if count % 2 == 1:
                lines[i] = f'<pre><code class="language-{items[-1]}">'
            else:
                lines[i] = f"<br></code></pre>"
        else:
            if i > 0:
                if count % 2 == 1:
                    line = line.replace("`", r"\`")
                    line = line.replace("<", "&lt;")
                    line = line.replace(">", "&gt;")
                    line = line.replace(" ", "&nbsp;")
                    line = line.replace("*", "&ast;")
                    line = line.replace("_", "&lowbar;")
                    line = line.replace("-", "&#45;")
                    line = line.replace(".", "&#46;")
                    line = line.replace("!", "&#33;")
                    line = line.replace("(", "&#40;")
                    line = line.replace(")", "&#41;")
                    line = line.replace("$", "&#36;")
                lines[i] = "<br>" + line
    text = "".join(lines)
    return text


def _gc():
    import gc
    gc.collect()
    if torch.cuda.is_available():
        torch.cuda.empty_cache()


def _launch_demo(args, model, tokenizer, config):
    def history_to_messages(history):
        messages = [{'role': 'system', 'content': 'You are a helpful assistant.'}]
        for h in history:
            messages.append({'role': 'user', 'content': h[0]})
            messages.append({'role': 'assistant', 'content': h[1]})
        return messages
    def predict(_query, _chatbot, _task_history):
        print(f"User: {_parse_text(_query)}")
        _chatbot.append((_parse_text(_query), ""))
        full_response = ""

        prompt = _query
        messages = history_to_messages(_task_history)
        messages.append({'role': 'user', 'content': prompt})
        
        text = tokenizer.apply_chat_template(
            messages,
            tokenize=False,
            add_generation_prompt=True
        )
        model_inputs = tokenizer([text], return_tensors="pt").to("cuda")

        streamer = TextIteratorStreamer(tokenizer,skip_special_tokens=True)

        generation_kwargs = dict(model_inputs, streamer=streamer,max_new_tokens=8192)
        thread = Thread(target=model.generate, kwargs=generation_kwargs)
        thread.start()
        text=""
        flag=True
        for response in streamer: #model.chat_stream(tokenizer, _query, history=_task_history, generation_config=config):
            if flag:
                flag=False
                continue
            text+=response
            #print(text)
            #input()
            #text=''.join([outputs[len(model_inputs):] for inputs,outputs in zip(model_inputs,text)])
            _chatbot[-1] = (_parse_text(_query), _parse_text(text))

            yield _chatbot
            full_response = _parse_text(text)

        print(f"History: {_task_history}")
        _task_history.append((_query, full_response))
        print(f"Qwen-Chat: {_parse_text(full_response)}")

    def regenerate(_chatbot, _task_history):
        if not _task_history:
            yield _chatbot
            return
        item = _task_history.pop(-1)
        _chatbot.pop(-1)
        yield from predict(item[0], _chatbot, _task_history)

    def reset_user_input():
        return gr.update(value="")

    def reset_state(_chatbot, _task_history):
        _task_history.clear()
        _chatbot.clear()
        _gc()
        return _chatbot

    with gr.Blocks() as demo:
        gr.Markdown("""<p align="center">##<p>""")
        gr.Markdown("""<center><font size=8>Qwen-Chat Bot</center>""")
        gr.Markdown(
            """<center><font size=3>This WebUI is based on Qwen-Chat. 本WebUI基于Qwen-Chat打造，实现聊天机器人功能。</center>""")
        gr.Markdown("""<center><font size=4>
Qwen</center>""")

        chatbot = gr.Chatbot(label='Qwen-Chat', elem_classes="control-height")
        query = gr.Textbox(lines=2, label='Input')
        task_history = gr.State([])

        with gr.Row():
            empty_btn = gr.Button("Clear History (清除历史)")
            submit_btn = gr.Button(" Submit (发送)")
            regen_btn = gr.Button("Regenerate (重试)")

        submit_btn.click(predict, [query, chatbot, task_history], [chatbot], show_progress=True)
        submit_btn.click(reset_user_input, [], [query])
        empty_btn.click(reset_state, [chatbot, task_history], outputs=[chatbot], show_progress=True)
        regen_btn.click(regenerate, [chatbot, task_history], [chatbot], show_progress=True)

        gr.Markdown("""<font size=2>Note: This demo is governed by the original license of Qwen. """)

    demo.queue().launch(
        share=args.share,
        inbrowser=args.inbrowser,
        server_port=args.server_port,
        server_name=args.server_name,
    )


def main():
    args = _get_args()

    model, tokenizer, config = _load_model_tokenizer(args)

    _launch_demo(args, model, tokenizer, config)


if __name__ == '__main__':
    main()
