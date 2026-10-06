#!/usr/bin/env bash
set -e
cd "$(dirname "$0")"
nix flake update
home-manager switch --flake .
git add . && git commit -m "update flake" && git push
