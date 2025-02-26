#!/bin/bash

# Define the download function
download_file() {
    local repository=$1
    local file=$2
    local dir="/ComfyUI/models/clip_vision"
    
    mkdir -p $dir
    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $repository --include "*.safetensors" --local-dir $dir
        mv "$dir/*.safetensors" "$dir/$file" 
    fi
}

download_file "openai/clip-vit-large-patch14" "clip_vit-large.safetensors"
download_file "google/siglip-so400m-patch14-384" "siglip-so400m.safetensors"
download_file "Comfy-Org/sigclip_vision_384" "sigclip_vision_patch14_384.safetensors"