#!/bin/bash

echo "Downloading Florence 2 models"
mkdir -p /ComfyUI/models/LLM/

file="Florence-2-large-ft.bin"

if [ -f "$file" ]; then
    echo "$file already exists."
else
    echo "Downloading $file"
    wget -O $file $url --progress=bar:force:noscroll
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download microsoft/Florence-2-large-ft --local-dir /ComfyUI/models/LLM
fi