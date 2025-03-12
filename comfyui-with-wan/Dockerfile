FROM jodog0412/jdg-comfyui:1.1.0

RUN pip3 install imageio-ffmpeg

RUN git clone https://github.com/thu-ml/SageAttention.git && \
    cd SageAttention && \
    python3 setup.py install 

RUN git clone https://github.com/thu-ml/SpargeAttn.git && \
    cd SpargeAttn && \
    python3 setup.py install 

RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    cd ComfyUI-WanVideoWrapper && \
    pip3 install -r requirements.txt

RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/WanVideo_comfy --include "umt5-xxl-enc-bf16.safetensors"  --local-dir ComfyUI/models/text_encoders && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/WanVideo_comfy --include "open-clip-xlm-roberta-large-vit-huge-14_visual_fp16.safetensors"  --local-dir ComfyUI/models/text_encoders && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/WanVideo_comfy --include "Wan2_1_VAE_bf16.safetensors"  --local-dir ComfyUI/models/vae && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/WanVideo_comfy --include "Wan2_1-I2V-14B-480P_fp8_e4m3fn.safetensors"  --local-dir ComfyUI/models/diffusion_models && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/WanVideo_comfy --include "Wan2_1-I2V-14B-720P_fp8_e4m3fn.safetensors"  --local-dir ComfyUI/models/diffusion_models && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Comfy-Org/Wan_2.1_ComfyUI_repackaged --include "split_files/clip_vision/clip_vision_h.safetensors"  --local-dir ComfyUI/models/clip_vision
    