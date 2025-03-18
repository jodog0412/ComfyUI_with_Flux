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

download_file "Kijai/WanVideo_comfy" "umt5-xxl-enc-fp8_e4m3fn.safetensors" "ComfyUI/models/text_encoders"
download_file "Kijai/WanVideo_comfy" "open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors" "ComfyUI/models/text_encoders"
download_file "Kijai/WanVideo_comfy" "Wan2_1_VAE_bf16.safetensors" "ComfyUI/models/vae"
download_file "Kijai/WanVideo_comfy" "Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors" "ComfyUI/models/diffusion_models"
download_file "Kijai/WanVideo_comfy" "Wan2_1-I2V-14B-720P_fp8_e4m3fn.safetensors" "ComfyUI/models/diffusion_models"
download_file "Comfy-Org/Wan_2.1_ComfyUI_repackaged" "split_files/clip_vision/clip_vision_h.safetensors" "ComfyUI/models/clip_vision"