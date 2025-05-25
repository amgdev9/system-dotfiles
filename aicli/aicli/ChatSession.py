from openai import OpenAI
from typing import Callable, Generator, Tuple, Union
import os
import json

client = OpenAI(
    base_url="https://openrouter.ai/api/v1",
    api_key=os.environ["OPENROUTER_API_KEY"],
)

class ChatSession:
    def __init__(self, system_prompt: str, model: str) -> None:
        self.messages: list[dict] = [
            {"role": "system", "content": system_prompt}
        ]
        self.tools: list[dict] = []
        self.tool_handlers: dict[str, Callable[[dict], str]] = {}
        self.model = model

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

    def ask(self, prompt: str) -> Generator[Tuple[str, Union[str, dict]], None, None]:
        if prompt: self.messages.append({"role": "user", "content": prompt})

        stream = client.chat.completions.create(
            model=self.model,
            messages=self.messages,
            stream=True,
            tools=self.tools,
            tool_choice="auto",
        )

        reply = ""
        tool_call_delta: dict[str, dict] = {}
        last_call_id = None

        for chunk in stream:
            delta = chunk.choices[0].delta

            if delta.content:
                reply += delta.content
                yield ("content", delta.content)

            if delta.tool_calls:
                for call in delta.tool_calls:
                    call_id = call.id if call.id else last_call_id
                    tool_call = tool_call_delta.setdefault(call_id, {
                        "id": call_id,
                        "type": "function",
                        "function": {"name": "", "arguments": ""}
                    })
                    if call.function.name:
                        tool_call["function"]["name"] = call.function.name
                    if call.function.arguments:
                        tool_call["function"]["arguments"] += call.function.arguments

                    last_call_id = call_id

        if tool_call_delta:
            tool_calls_list = list(tool_call_delta.values())
            self.messages.append({"role": "assistant", "tool_calls": tool_calls_list})
            for call in tool_calls_list:
                yield ("tool_call", call)
        elif reply:
            self.messages.append({"role": "assistant", "content": reply})

        for call in tool_call_delta.values():
            name = call["function"]["name"]
            args = json.loads(call["function"]["arguments"])
            call_id = call["id"]

            handler = self.tool_handlers.get(name)
            if not handler:
                continue

            result = handler(args)

            self.messages.append({
                "role": "tool",
                "tool_call_id": call_id,
                "content": result
            })

        if tool_call_delta:
            yield from self.ask("")
