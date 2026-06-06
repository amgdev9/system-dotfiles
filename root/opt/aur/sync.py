#!/usr/bin/env python

import urllib.request
import json
import os
import glob
import subprocess

packages = [
    { "owner": "brave", "name": "brave-browser", "package-name": "brave-origin-bin" },
]

def get_latest_version(owner, repo):
    url = f"https://api.github.com/repos/{owner}/{repo}/releases/latest"
    req = urllib.request.Request(url, headers={"Accept": "application/vnd.github.v3+json"})

    with urllib.request.urlopen(req) as resp:
        data = json.loads(resp.read().decode())

    tag = data.get("tag_name")
    if tag and tag.startswith("v"):
        tag = tag[1:]
    return tag

def compare_semver(v1, v2):
    parts1 = [int(x) for x in v1.split(".")]
    parts2 = [int(x) for x in v2.split(".")]

    # Extend shorter list with zeros
    length = max(len(parts1), len(parts2))
    parts1 += [0] * (length - len(parts1))
    parts2 += [0] * (length - len(parts2))

    if parts1 == parts2:
        return 0
    elif parts1 > parts2:
        return 1
    else:
        return -1

def get_pkgbuild_version(path):
    with open(path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('pkgver='):
                return line.split('=', 1)[1].strip().strip('"').strip("'")
    return None

def update_pkgbuild_version(path, new_version):
    lines = []
    with open(path, 'r') as f:
        for line in f:
            if line.strip().startswith('pkgver='):
                line = f'pkgver={new_version}\n'
            lines.append(line)
    with open(path, 'w') as f:
        f.writelines(lines)

print("Updating AUR packages...")

for pkg in packages:
    owner = pkg["owner"]
    name = pkg["name"]
    package_name = pkg["package-name"]
    max_version = pkg.get("max_version", None)

    latest_version = get_latest_version(owner, name)
    current_version = get_pkgbuild_version(f"/opt/aur/{package_name}/PKGBUILD")
    if compare_semver(latest_version, current_version) == 0:
        print(f"Package {package_name} is up to date, skipping")
        continue

    print(f"Updating {package_name}: {current_version} -> {latest_version}")

    update_pkgbuild_version(f"/opt/aur/{package_name}/PKGBUILD", latest_version)

    pkg_dir = f"/opt/aur/{package_name}"
    os.chdir(pkg_dir)
    subprocess.run(["makepkg", "-si"]) 
    subprocess.run(f'rm -rf {pkg_dir}/*.zip {pkg_dir}/*.zst {pkg_dir}/pkg {pkg_dir}/src', shell=True)

print("AUR packages updated!")
