FROM jodog0412/jdg-comfyui:1.2.0

LABEL "repository"="https://github.com/jodog0412/github-action"
LABEL "maintainer"="jodog0412 <jodog0412@gmail.com>"

# 1. essential-components
# comfyui-gguf
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/city96/ComfyUI-GGUF.git && \
    cd ComfyUI-GGUF && \
    pip3 install -r requirements.txt

# Download quantized FLUX.1 model
RUN mkdir -p /ComfyUI/models/diffusion_models/FLUX1 && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download city96/FLUX.1-dev-gguf --include flux1-dev-Q8_0.gguf --local-dir /ComfyUI/models/diffusion_models/FLUX1

# Download text_encoder model
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download comfyanonymous/flux_text_encoders --include "*.safetensors" --exclude "*_fp8_*.*" --local-dir /ComfyUI/models/clip

# Download clip_vision models
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download openai/clip-vit-large-patch14 --include model.safetensors --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/clip_vit.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/siglip-so400m-patch14-384 --include model.safetensors --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/siglip-so400m.safetensors

# Download upscalers
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ai-forever/Real-ESRGAN --include "RealESRGAN_x2.pth" --local-dir /ComfyUI/models/upscale_models && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download lokCX/4x-Ultrasharp --include "*.pth" --local-dir /ComfyUI/models/upscale_models

# 2. assistant-components
# comfyui-ipadapter-flux
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux comfyui-ipadapter-flux && \
    cd comfyui-ipadapter-flux && \
    pip3 install -r requirements.txt

# Download model for comfyui-ipadapter-flux
RUN mkdir -p /ComfyUI/models/ipadapter-flux && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download InstantX/FLUX.1-dev-IP-Adapter --include ip-adapter.bin --local-dir /ComfyUI/models/ipadapter-flux

# Download redux & fill model
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download YarvixPA/FLUX.1-Fill-dev-gguf --include "flux1-fill-dev-Q4_K_S.gguf" --local-dir /ComfyUI/models/unet
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download black-forest-labs/FLUX.1-Redux-dev --include "flux1-redux-dev.safetensors" --local-dir /ComfyUI/models/style_models

# Download controlnet model
RUN mkdir -p /ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro --include diffusion_pytorch_model.safetensors --local-dir /ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro

# 3. optional-components
# CatVTON    
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/chflame163/ComfyUI_CatVTON_Wrapper.git && \
    cd ComfyUI_CatVTON_Wrapper && \
    pip3 install -r requirements.txt

# Download models for CatVTON
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download zhengchong/CatVTON --local-dir /ComfyUI/models/CatVTON && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download stabilityai/sd-vae-ft-mse --local-dir /ComfyUI/models/CatVTON/sd-vae-ft-mse && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download stable-diffusion-v1-5/stable-diffusion-inpainting --include "unet/*" --local-dir /ComfyUI/models/CatVTON/stable-diffusion-inpainting && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download stable-diffusion-v1-5/stable-diffusion-inpainting --include "scheduler/*.json" --local-dir /ComfyUI/models/CatVTON/stable-diffusion-inpainting

# IDM-VTON    
# RUN cd /ComfyUI/custom_nodes && \
#     git clone https://github.com/TemryL/ComfyUI-IDM-VTON.git && \
#     cd ComfyUI-IDM-VTON && \
#     python3 install.py

# Download Concept-LoRA
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download tryonlabs/FLUX.1-dev-LoRA-Outfit-Generator --include "outfit-generator.safetensors" --local-dir /ComfyUI/models/loras

# Download Detail-LoRA
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download strangerzonehf/Flux-Super-Realism-LoRA --include "super-realism.safetensors" --local-dir /ComfyUI/models/loras && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FLUX.1-dev-LoRA-add-details --include "*.safetensors" --local-dir /ComfyUI/models/loras && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download strangerzonehf/Flux-Midjourney-Mix2-LoRA --include "*.safetensors" --local-dir /ComfyUI/models/loras && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FilmPortrait --include "*.safetensors" --local-dir /ComfyUI/models/loras && \
    wget -O /ComfyUI/models/loras/detailed_hands.safetensors "https://civitai.com/api/download/models/804967?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9" && \
    wget -O /ComfyUI/models/loras/sinfully_stylish.safetensors "https://civitai.com/api/download/models/755549?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"

CMD [ "/start.sh" ]