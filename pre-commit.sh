#!/bin/sh
# docker run -e "USERID=$(id -u):$(id -g)" -v $(pwd):/lint -w /lint ghcr.io/antonbabenko/pre-commit-terraform:latest run --all-files
pre-commit run -a