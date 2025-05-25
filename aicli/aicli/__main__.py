from aicli.ChatSession import ChatSession
from aicli.tools.create_file import register as register_create_file 

GRAY = "\033[90m"
RESET = "\033[0m"

def main() -> None:
    chat = ChatSession(
        system_prompt="You are an expert programmer. You must use your available tools. Do not answer directly.",
        model="mistralai/mistral-small-3.1-24b-instruct:free"
    )
    register_create_file(chat)

    while True:
        prompt = input("\n> ")
        if prompt.lower() in {"exit", "quit"}:
            break

        print()
        for kind, value in chat.ask(prompt):
            if kind == "content":
                print(value, end='', flush=True)
            elif kind == "tool_call":
                print(f"{GRAY}[Tool call] {value}{RESET}")

        print()
