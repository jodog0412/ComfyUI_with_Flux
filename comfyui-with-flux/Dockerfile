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

# 2. helpful-components
COPY --chmod=755 download_LoRAs.sh /download_LoRAs.sh
COPY --chmod=755 download_Stylers.sh /download_Stylers.sh
COPY --chmod=755 download_ClipVisions.sh /download_ClipVisions.sh

# x-flux-comfyui
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/jodog0412/x-flux-comfyui.git && \
    cd x-flux-comfyui && \
    python3 setup.py

# AdvancedRefluxContorl
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kaibioinfo/ComfyUI_AdvancedRefluxControl.git

# TeaCache
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/welltop-cn/ComfyUI-TeaCache.git && \
    cd ComfyUI-TeaCache && \
    pip3 install -r requirements.txt
    
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
