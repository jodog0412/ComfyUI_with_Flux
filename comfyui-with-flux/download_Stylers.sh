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
        HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download $repository --include $file --local-dir $dir --token $HF_TOKEN
    fi
}

download_file "InstantX/FLUX.1-dev-IP-Adapter" "ip-adapter.bin" "/ComfyUI/models/ipadapter-flux"
download_file "Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro" "diffusion_pytorch_model.safetensors" "/ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro"
download_file "YarvixPA/FLUX.1-Fill-dev-gguf" "flux1-fill-dev-Q4_K_S.gguf" "/ComfyUI/models/unet" 
download_file "black-forest-labs/FLUX.1-Redux-dev" "flux1-redux-dev.safetensors" "/ComfyUI/models/style_models" 