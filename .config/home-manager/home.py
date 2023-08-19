#!/usr/bin/env python3

# Usage: ./home.py [install|remove] [package]

import sys
import os
import subprocess

HOME_MANAGER_CONFIG_PATH = os.path.expanduser("~/.config/home-manager/home.nix")
MAX_SEARCH_RESULTS = 5

def switch(data):
	with open(HOME_MANAGER_CONFIG_PATH, "w") as file:
		file.writelines(data)
	return_code = os.system("home-manager switch")
	if return_code != 0:
		print("error: failed to switch, reverting changes")
		with open(HOME_MANAGER_CONFIG_PATH, "w") as file:
			file.writelines(original_data)
	sys.exit(return_code)

# check if the file exists
if not os.path.isfile(HOME_MANAGER_CONFIG_PATH):
	print("error: home.nix file not found")
	sys.exit(1)

# check for install or uninstall subcommand and package name after
if len(sys.argv) == 2:
	print("error: no package specified")
	sys.exit(1)
elif len(sys.argv) > 3:
	print("error: too many arguments")
	sys.exit(1)

# make sure first argument is install or remove
if sys.argv[1] not in ["install", "remove"]:
	print("error: invalid subcommand (must be install or remove)")
	sys.exit(1)

do_install = sys.argv[1] == "install"
pkg_name = sys.argv[2]

# verify the package exists
try:
	subprocess.check_output(["nix", "search", "nixpkgs#" + pkg_name])
except subprocess.CalledProcessError as e:
	sys.exit(e.returncode)

with open(HOME_MANAGER_CONFIG_PATH, "r") as file:
	data = file.readlines()

original_data = data.copy()

# find the line number of the list start
start = next((i for i, line in enumerate(data) if "home.packages = with pkgs; [" in line), -1)

if start == -1:
	print("error: home.packages list not found in " + HOME_MANAGER_CONFIG_PATH)
	sys.exit(1)

# find the line number of the list end
end = -1
indentation = ""
for i in range(start, len(data)):
	if "];" in data[i]:
		end = i
		break
	if not data[i].isspace():
		indentation = max(
			data[i].replace(data[i].lstrip(' '), ''),
			data[i].replace(data[i].lstrip('\t'), ''),
			key=len
		)
	if data[i].strip() == pkg_name:
		if do_install:
			print(f"error: {pkg_name} is already installed")
			sys.exit(1)
		else:
			data.pop(i)
			print(f"Removing {pkg_name}...")
			switch(data)


if not do_install:
	print(f"{pkg_name} is not installed")
	sys.exit(1)

if data[end - 1].isspace():
	end -= 1

# add the package to the end of the list
data.insert(end, f"{indentation}{pkg_name}\n")

print(f"Installing {pkg_name}...")
switch(data)