#!/usr/bin/env python

import urllib.request
import json
import os
import glob
import subprocess

packages = [
    { "owner": "hyprwm", "name": "hyprlock", "gentoo-name": "gui-apps/hyprlock", "max_version": "0.8.2" },
    { "owner": "hyprwm", "name": "hypridle", "gentoo-name": "gui-apps/hypridle" },
    { "owner": "hyprwm", "name": "xdg-desktop-portal-hyprland", "gentoo-name": "gui-libs/xdg-desktop-portal-hyprland" },
    { "owner": "Hummer12007", "name": "brightnessctl", "gentoo-name": "app-misc/brightnessctl" },
    { "owner": "brave", "name": "brave-browser", "gentoo-name": "www-client/brave-bin" },
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

print("Syncing local repo packages...")

for pkg in packages:
    owner = pkg["owner"]
    name = pkg["name"]
    gentoo_name = pkg["gentoo-name"]
    gentoo_base_name = gentoo_name.split("/")[1] 
    max_version = pkg.get("max_version", None)

    latest_version = get_latest_version(owner, name)
    matches = (glob.glob(f"/var/db/repos/local/{gentoo_name}/{gentoo_base_name}-{latest_version}.ebuild") +
              glob.glob(f"/var/db/repos/local/{gentoo_name}/{gentoo_base_name}-{latest_version}-r*.ebuild"))
    if matches:
        print(f"Package {gentoo_name} is up to date, skipping")
        continue

    if max_version != None:
        print(f"\033[33mPackage {gentoo_name} has max version {max_version}, consider testing the new version!\033[0m")
        if(compare_semver(max_version, latest_version) < 0):
            print(f"\033[33mLatest version {latest_version} > Max version {max_version}, skipping update\033[0m")
            continue

    pattern_all = f"/var/db/repos/local/{gentoo_name}/{gentoo_base_name}-*.ebuild"
    existing_ebuilds = glob.glob(pattern_all)

    # Get existing version
    filename = os.path.basename(existing_ebuilds[0]).replace(".ebuild", "")
    current_version = filename[len(gentoo_base_name)+1:]
    if "-r" in current_version:
        current_version = current_version.split("-r")[0]
    
    print(f"Updating {gentoo_name}: {current_version} -> {latest_version}")

    old_ebuild = existing_ebuilds[0]
    new_ebuild = os.path.join(
        os.path.dirname(old_ebuild),
        f"{gentoo_base_name}-{latest_version}.ebuild"
    )
    os.rename(old_ebuild, new_ebuild)

    pkg_dir = f"/var/db/repos/local/{gentoo_name}"
    os.chdir(pkg_dir)
    subprocess.run(["pkgdev", "manifest"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)

print("Local repo synced!")

