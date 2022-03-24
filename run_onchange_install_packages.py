#!/usr/bin/python
import os
import shutil
from typing import Dict

cargo_packages: Dict[str, str] = {
    "fd": "fd-find",
    "fzf": "fzf",
    "rg": "ripgrep",
    "starship": "starship",
}
for package in cargo_packages.keys():
    if(shutil.which(package) is None):
        os.system(f"cargo install {cargo_packages[package]}")
