from openai import OpenAI
from typing import Generator
import os

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=os.environ["OPENROUTER_API_KEY"],
)

class ChatSession:
    def __init__(self) -> None:
        self.messages: list[dict[str, str]] = [
            {"role": "system", "content": "You are a helpful assistant."}
        ]
        self.tools: list[dict] = []
        self.tool_handlers: dict[str, Callable[[dict], str]] = {}

    def register_tool(self, name: str, description: str, parameters: dict, handler: Callable[[dict], str]) -> None:
        self.tools.append({
            "type": "function",
            "function": {
                "name": name,
                "description": description,
                "parameters": parameters,
            }
        })
        self.tool_handlers[name] = handler

    def ask(self, prompt: str) -> Generator[str, None, None]:
        self.messages.append({"role": "user", "content": prompt})

        stream = client.chat.completions.create(
            model="qwen/qwen3-30b-a3b:free",
            messages=self.messages,
            stream=True,
            tools=self.tools,
            tool_choice="auto",
        )

        reply = ""
        for chunk in stream:
            content = chunk.choices[0].delta.content
            if content:
                reply += content
                yield content

        self.messages.append({"role": "assistant", "content": reply})
