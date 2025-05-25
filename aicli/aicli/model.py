from openai import OpenAI
from typing import Generator
import os

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=os.environ["OPENROUTER_API_KEY"],
)

def request_model(prompt: str) -> Generator[str, None, None]:
    stream = client.chat.completions.create(
        model="qwen/qwen3-30b-a3b:free",
        messages=[{"role": "user", "content": prompt}],
        stream=True,
    )

    for chunk in stream:
        content = chunk.choices[0].delta.content
        if content:
            yield content
