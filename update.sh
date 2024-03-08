#!/usr/bin/env bash
nix flake update && home-manager switch && git add . && git commit -am "update flake" && git push
