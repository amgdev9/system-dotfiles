# Local dev
```
uv venv
source .venv/bin/activate
uv pip install -e . # Editable mode
export OPENROUTER_API_KEY=$(secret-read openrouter-api-key)
aicli   # Runs the app
```

# Install globally
```
sudo pacman -S python-pipx
pipx ensurepath
source ~/.bashrc # Adds ~/.local/bin to PATH
pipx install .
```
