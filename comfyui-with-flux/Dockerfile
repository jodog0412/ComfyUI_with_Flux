FROM jodog0412/comfyuiwithoutflux:latest

# Due to the fact that the models are in a gated repository, we need to download them separately BEFORE building this image and store them locally in a folder called flux
# https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/ae.sft
# RUN wget -O /ComfyUI/models/vae/FLUX1/vae.safetensors "https://huggingface.co/black-forest-labs/FLUX.1-dev/resolve/main/vae/diffusion_pytorch_model.safetensors?download=true" --progress=bar:force:noscroll

# install hf_transfer
RUN pip3 install hf_transfer

# comfyui-gguf
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/city96/ComfyUI-GGUF.git && \
    cd ComfyUI-GGUF && \
    pip3 install -r requirements.txt

# Download and move flux1_dev_Q8.gguf
RUN mkdir -p /ComfyUI/models/diffusion_models/FLUX1
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download city96/FLUX.1-dev-gguf --include flux1-dev-Q8_0.gguf --local-dir ./ComfyUI/models/diffusion_models/FLUX1

# Download and move taef1.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download madebyollin/taef1 --include "diffusion_pytorch_model.safetensors" --local-dir ./ComfyUI/models/vae_approx

# Download and move clip_l.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download comfyanonymous/flux_text_encoders --include "*.safetensors" --exclude "*_fp8_*.*" --local-dir ./ComfyUI/models/clip

# Download and move t5xxl_fp16.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download comfyanonymous/flux_text_encoders --include t5xxl_fp16.safetensors --local-dir ./ComfyUI/models/clip

# Download and move clip-vit.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download openai/clip-vit-large-patch14 --include model.safetensors --local-dir ./ComfyUI/models/clip_vision

# download in-context-lora
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ali-vilab/In-Context-LoRA --include *.safetensors --local-dir ./ComfyUI/models/loras

# Download and move flux1_dev_controlnet_union_pro.safetensors
RUN mkdir -p /ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro --include diffusion_pytorch_model.safetensors --local-dir ./ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro

# download ip_adapter
RUN mkdir -p /ComfyUI/models/xlabs/ipadapters
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download XLabs-AI/flux-ip-adapter-v2 --include ip_adapter.safetensors --local-dir ./ComfyUI/models/xlabs/ipadapters

# make the xlabs directory
RUN mkdir -p /ComfyUI/models/xlabs/loras
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download XLabs-AI/flux-RealismLora --include lora.safetensors --local-dir ./ComfyUI/models/xlabs/loras

CMD [ "/start.sh" ]
