#!/bin/bash

echo "Donwloading Upscale models"
dir="/ComfyUI/models/upscale_models"

echo "Downloading RealESRGAN_x2.pth"
file="RealESRGAN_x2.pth"

if [ -f "$dir/$file" ]; then
    echo "$file already exists."
else
    echo "Downloading $file"
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ai-forever/Real-ESRGAN --include $file --local-dir $dir 
fi

echo "Downloading 4x-UltraSharp.pth"
file="4x-UltraSharp.pth"

if [ -f "$dir/$file" ]; then
    echo "$dir/$file already exists."
else
    echo "Downloading $file"
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download lokCX/4x-Ultrasharp --include $file --local-dir $dir 
fi