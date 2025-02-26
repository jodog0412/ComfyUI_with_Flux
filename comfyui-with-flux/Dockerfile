FROM jodog0412/jdg-comfyui:1.1.0

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
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download city96/FLUX.1-dev-gguf --include "flux1-dev-Q8_0.gguf" --local-dir /ComfyUI/models/diffusion_models/FLUX1

# Download text_encoder models
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download comfyanonymous/flux_text_encoders --include "*.safetensors" --exclude "*_fp8_*.*" --local-dir /ComfyUI/models/clip

# Download clip_vision models
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download openai/clip-vit-large-patch14 --include "model.safetensors" --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/clip_vit.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/siglip-so400m-patch14-384 --include "model.safetensors" --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/siglip-so400m.safetensors

# 2. helpful-components
COPY --chmod=755 download_LoRAs.sh /download_LoRAs.sh
COPY --chmod=755 download_Stylers /download_Stylers

# comfyui-ipadapter-flux
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux comfyui-ipadapter-flux && \
    cd comfyui-ipadapter-flux && \
    pip3 install -r requirements.txt

# AdvancedRefluxContorl
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git

# 3. optional-components
# CatVTON    
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/chflame163/ComfyUI_CatVTON_Wrapper.git && \
    cd ComfyUI_CatVTON_Wrapper && \
    pip3 install -r requirements.txt

# IDM-VTON    
# RUN cd /ComfyUI/custom_nodes && \
#     git clone https://github.com/TemryL/ComfyUI-IDM-VTON.git && \
#     cd ComfyUI-IDM-VTON && \
#     python3 install.py

CMD [ "/start.sh" ]
