import os
import re

home = os.environ['HOME']
path = f"{home}/.config/hypr/keybindings.conf"

with open (path, "r") as f:
    lines = f.readlines()

for line in lines:
    line: str = line.strip()
    if line.startswith("bind"):
        parts = line.removeprefix("bind = ").split(",")
        key = f"{parts[0]} + {parts[1]}"
        cmd = " ".join(parts[2:])
        print(key)
