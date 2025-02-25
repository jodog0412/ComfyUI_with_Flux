#!/bin/bash

echo "Downloading Florence 2 models"
mkdir -p /ComfyUI/models/Janus-Pro/Janus-Pro-1B

file="Janus-Pro-1B.bin"

if [ -f "$file" ]; then
    echo "$file already exists."
else
    echo "Downloading $file"
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download deepseek-ai/Janus-Pro-1B --local-dir /ComfyUI/models/Janus-Pro/Janus-Pro-1B
    mv /ComfyUI/models/Janus-Pro/Janus-Pro-1B/pytorch_model.bin /ComfyUI/models/Janus-Pro/Janus-Pro-1B/Janus-Pro-1B.bin
fi