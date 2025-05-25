def register(chat) -> None:
    def create_file(args: dict) -> str:
        filename = args["filename"]
        content = args["content"]

        with open(filename, "w", encoding="utf-8") as f:
            f.write(content)

        return f"File '{filename}' created."

    chat.register_tool(
        name="create_file",
        description="Create a new file with specific content",
        parameters={
            "type": "object",
            "properties": {
                "filename": {
                    "type": "string",
                    "description": "Name of the file to create (with extension)"
                },
                "content": {
                    "type": "string",
                    "description": "Content to write into the file"
                }
            },
            "required": ["filename", "content"]
        },
        handler=create_file
    )
