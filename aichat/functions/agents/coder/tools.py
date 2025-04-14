import os

def fs_create(path, contents):
    with open(path, "w") as f:
        f.write(contents)

def fs_mkdir(path):
    os.makedirs(path, exist_ok=True)

def fs_ls(path):
    return os.listdir(path)

def fs_cat(path):
    with open(path, "r") as f:
        return f.read()

