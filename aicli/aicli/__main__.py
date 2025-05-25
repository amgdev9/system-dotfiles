from aicli.model import request_model

def main():
    prompt = input("Enter your prompt: ")
    print("\nResponse:\n")
    for chunk in request_model(prompt):
        print(chunk, end='', flush=True)
    print()

if __name__ == "__main__":
    main()
