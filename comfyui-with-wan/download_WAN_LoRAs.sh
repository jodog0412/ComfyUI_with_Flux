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

download_file_HF Kijai/WanVideo_comfy Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_HIGH_fp16.safetensors
download_file_HF Kijai/WanVideo_comfy Wan22-Lightning/Wan2.2-Lightning_I2V-A14B-4steps-lora_LOW_fp16.safetensors
download_file_HF Kijai/WanVideo_comfy Lightx2v/lightx2v_I2V_14B_480p_cfg_step_distill_rank128_bf16.safetensors