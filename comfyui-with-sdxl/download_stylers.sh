#!/bin/bash

download_file() {
    local repository=$1
    local file=$2
    local dir=$3

    mkdir -p $dir
    if [ -f "$dir/$file" ]; then
        echo "File $dir/$file already exists, skipping download."
    else
        hf download $repository --include $file --local-dir $dir --token $HF_TOKEN
    fi
}

download_file "h94/IP-Adapter" "sdxl_models/image_encoder/model.safetensors" "/ComfyUI/models/clip_vision"
download_file "h94/IP-Adapter" "sdxl_models/ip-adapter_sdxl.safetensors" "/ComfyUI/models/ipadapter"
download_file "h94/IP-Adapter-FaceID" "ip-adapter-faceid-plusv2_sdxl.bin" "/ComfyUI/models/ipadapter"
download_file "h94/IP-Adapter-FaceID" "ip-adapter-faceid-plusv2_sdxl_lora.safetensors" "/ComfyUI/models/loras"
download_file "Minthy/RouWei-Gemma" "t5gemma-2b-2b-ul2_*" "/ComfyUI/models/LLM"
download_file "Minthy/Rouwei-T5Gemma-adapter_v0.2" "rw_t5g_adapter_101k.safetensors" "/ComfyUI/models/llm_adapters"