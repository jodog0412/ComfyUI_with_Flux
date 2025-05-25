#!/bin/bash

# Define the download function
download_file() {
    local url=$1
    local file=$2
    local dir="/ComfyUI/models/loras"

    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        wget -O $dir/$file $url --progress=bar:force:noscroll
    fi
}

download_file_HF() {
    local repository=$1
    local file=$2
    local dir="/ComfyUI/models/loras"

    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $repository --include $file --local-dir $dir
    fi
}

download_file "https://civitai.com/api/download/models/1516994?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "live_wallpaper.safetensors"
download_file "https://civitai.com/api/download/models/1794316?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "WAN_speedup.safetensors"
download_file "https://civitai.com/api/download/models/1565668?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "WAN_detail.safetensors"
# download_file "https://civitai.com/api/download/models/1403959?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "Motion_craft.safetensors"