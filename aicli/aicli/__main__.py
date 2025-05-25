from aicli.ChatSession import ChatSession

def main() -> None:
    chat = ChatSession()

    while True:
        prompt = input("\n> ")
        if prompt.lower() in {"exit", "quit"}:
            break

        for chunk in chat.ask(prompt):
            print(chunk, end='', flush=True)
        print()
