#!/bin/bash

# Define the download function
download_file() {
    local url=$1
    local file=$2
    local dir="/ComfyUI/models/checkpoints"

    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        wget -O $dir/$file $url --progress=bar:force:noscroll
    fi
}

download_file "https://civitai.com/api/download/models/2467972?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "Prefect_illustrious_XL.safetensors"
download_file "https://civitai.com/api/download/models/2337366?type=Model&format=SafeTensor&token=$CIVITAI_API_TOKEN" "Hassaku_XL.safetensors"