#!/bin/bash

echo "Downloading Florence 2 models"

dir="/ComfyUI/models/LLM"
file="pytorch_model.bin"
mkdir -p $dir

if [ -f "$dir/$file" ]; then
    echo "$dir/$file already exists."
else
    echo "Downloading $file"
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download microsoft/Florence-2-large-ft --local-dir $dir
fi