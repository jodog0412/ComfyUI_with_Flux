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
        hf download $repository --include $file --local-dir $dir
    fi
}

# download_file "Kijai/WanVideo_comfy" "umt5-xxl-enc-fp8_e4m3fn.safetensors" "ComfyUI/models/text_encoders"
download_file "Comfy-Org/Wan_2.1_ComfyUI_repackaged" "split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" "ComfyUI/models/text_encoders"
download_file "Kijai/WanVideo_comfy" "Wan2_1_VAE_bf16.safetensors" "ComfyUI/models/vae"
download_file "Comfy-Org/Wan_2.2_ComfyUI_Repackaged" "split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors" "ComfyUI/models/diffusion_models"
download_file "Comfy-Org/Wan_2.2_ComfyUI_Repackaged" "split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors" "ComfyUI/models/diffusion_models"
download_file "Comfy-Org/Wan_2.1_ComfyUI_repackaged" "split_files/clip_vision/clip_vision_h.safetensors" "ComfyUI/models/clip_vision"