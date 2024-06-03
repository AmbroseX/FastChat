

import asyncio
import json
import aiohttp

from fastchat.constants import ErrorCode

fetch_timeout = aiohttp.ClientTimeout(total=3 * 3600)

async def fetch_remote(url, pload=None, name=None):
    async with aiohttp.ClientSession(timeout=fetch_timeout) as session:
        async with session.post(url, json=pload) as response:
            chunks = []
            if response.status != 200:
                ret = {
                    "text": f"{response.reason}",
                    "error_code": ErrorCode.INTERNAL_ERROR,
                }
                return json.dumps(ret)

            async for chunk, _ in response.content.iter_chunks():
                chunks.append(chunk)
        output = b"".join(chunks)

    if name is not None:
        res = json.loads(output)
        if name != "":
            res = res[name]
        return res

    return output

async def test_fetch():
    controller_address = "192.168.72.34:22001"
    ret = await fetch_remote(controller_address + "/refresh_all_workers")
    print(f"list_models:{ret}")
    models = await fetch_remote(controller_address + "/list_models", None, "models")
    print(models)

if __name__ == "__main__":
    asyncio.run(test_fetch())