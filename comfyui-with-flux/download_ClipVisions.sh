#!/bin/bash

# Define the download function
download_file() {
    local repository=$1
    local file=$2
    local dir=$3
    
    mkdir -p $dir
    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $repository --include $file --local-dir $dir
    fi
}

download_file "openai/clip-vit-large-patch14" "model.safetensors" "/ComfyUI/models/clip_vision/clip-vit-large"
download_file "google/siglip-so400m-patch14-384" "model.safetensors" "/ComfyUI/models/clip_vision/siglip-so400m"
download_file "Comfy-Org/sigclip_vision_384" "sigclip_vision_patch14_384.safetensors" "/ComfyUI/models/clip_vision"