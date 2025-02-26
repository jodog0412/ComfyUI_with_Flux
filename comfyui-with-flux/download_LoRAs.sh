#!/bin/bash

# Define the download function
dir = "/ComfyUI/models/loras"
download_file() {
    local url=$1
    local file=$2

    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        wget -O $dir/$file $url --progress=bar:force:noscroll
    fi
}

download_file_HF() {
    local repository=$1
    local file=$2

    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $repository --include $file --local-dir $dir --token $HF_TOKEN
    fi
}

# 1. Download detail-LoRA
download_file_HF "strangerzonehf/Flux-Super-Realism-LoRA" "super-realism.safetensors"
download_file_HF "strangerzonehf/Flux-Midjourney-Mix2-LoRA" "*.safetensors"
download_file_HF "Shakker-Labs/FLUX.1-dev-LoRA-add-details" "*.safetensors"
download_file_HF "Shakker-Labs/FilmPortrait" "*.safetensors"
download_file "https://civitai.com/api/download/models/804967?type=Model&format=SafeTensor&fp=fp16&token=$CIVITAI_API_TOKEN" "detailed_hands.safetensors"
download_file "https://civitai.com/api/download/models/755549?type=Model&format=SafeTensor&fp=fp16&token=$CIVITAI_API_TOKEN" "sinfully_stylish.safetensors"

# 2. Download concept-LoRA
download_file_HF "ali-vilab/In-Context-LoRA" "*.safetensors"
download_file_HF "tryonlabs/FLUX.1-dev-LoRA-Outfit-Generator" "outfit-generator.safetensors"
download_file_HF "multimodalart/product-design" "product-design.safetensors"
download_file_HF "strangerzonehf/Flux-Creative-Stocks-LoRA" "Creative-Stocks.safetensors"
download_file "https://civitai.com/api/download/models/1077005?type=Model&format=SafeTensor&fp=fp16&token=$CIVITAI_API_TOKEN" "Minimalist_Flat_Color_Illustration.safetensors"
download_file "https://civitai.com/api/download/models/880820?type=Model&format=SafeTensor&fp=fp16&token=$CIVITAI_API_TOKEN" "vector_Illustration.safetensors"
download_file "https://civitai.com/api/download/models/940211?type=Model&format=SafeTensor&fp=fp16&token=$CIVITAI_API_TOKEN" "IlluLoRA.safetensors"