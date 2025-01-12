FROM jodog0412/jdg-comfyui:1.0.0

RUN pip3 install hf_transfer

# Download checkpoint models based on Illustrious-XL
RUN wget -O /ComfyUI/models/checkpoints/NTRMIX.safetensors "https://civitai.com/api/download/models/1166878?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9" && \
    wget -O /ComfyUI/models/checkpoints/NoobAI_VPred.safetensors "https://civitai.com/api/download/models/1190596?type=Model&format=SafeTensor&token=ff61c6fbf8c474895b34eddabb2e31f9"
    
# Download upscaler
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ai-forever/Real-ESRGAN --include "RealESRGAN_x2.pth" --local-dir /ComfyUI/models/upscale_models && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download lokCX/4x-Ultrasharp --include "*.pth" --local-dir /ComfyUI/models/upscale_models

# Download IP-Adapter
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download h94/IP-Adapter --include sdxl_models/image_encoder/model.safetensors --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/sdxl_models/image_encoder/model.safetensors /ComfyUI/models/clip_vision/CLIP-ViT-bigG-14-laion2B-39B-b160k.safetensors

RUN mkdir -p /ComfyUI/models/ipadapter && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download h94/IP-Adapter --include sdxl_models/ip-adapter_sdxl.safetensors --local-dir /ComfyUI/models/ipadapter && \    
    mv /ComfyUI/models/ipadapter/sdxl_models/ip-adapter_sdxl.safetensors /ComfyUI/models/ipadapter/ip-adapter_sdxl.safetensors

CMD [ "/start.sh" ]