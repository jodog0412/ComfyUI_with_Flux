#!/bin/bash

echo "Downloading Janus-Pro-1B model"

dir="/ComfyUI/models/Janus-Pro/Janus-Pro-1B"
file="Janus-Pro-1B.bin"
mkdir -p $dir

if [ -f "$dir/$file" ]; then
    echo "$dir/$file already exists."
else
    echo "Downloading $file"
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download deepseek-ai/Janus-Pro-1B --include $file --local-dir $dir
fi