#!/bin/bash

echo "Downloading Janus-Pro-1B model"
mkdir -p /ComfyUI/models/Janus-Pro/Janus-Pro-1B
cd /ComfyUI/models/Janus-Pro/Janus-Pro-1B

file="Janus-Pro-1B.bin"
url="https://huggingface.co/deepseek-ai/Janus-Pro-1B/resolve/main/pytorch_model.bin?download=true"

if [ -f "$file" ]; then
    echo "$file already exists."
else
    echo "Downloading $file"
    wget -O $file $url --progress=bar:force:noscroll
fi