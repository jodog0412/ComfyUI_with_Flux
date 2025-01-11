FROM jodog0412/comfyuiwithoutflux:1.0.0

LABEL "repository"="https://github.com/jodog0412/github-action"
LABEL "maintainer"="jodog0412 <jodog0412@gmail.com>"

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

# comfyui-ipadapter-flux
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Shakker-Labs/ComfyUI-IPAdapter-Flux comfyui-ipadapter-flux && \
    cd comfyui-ipadapter-flux && \
    pip3 install -r requirements.txt

# Download and move flux1_dev_Q8.gguf
RUN mkdir -p /ComfyUI/models/diffusion_models/FLUX1 && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download city96/FLUX.1-dev-gguf --include flux1-dev-Q8_0.gguf --local-dir /ComfyUI/models/diffusion_models/FLUX1

# Download and move taef1.safetensors
# RUN wget -O /ComfyUI/models/vae_approx/taef1_decoder.pth "https://github.com/madebyollin/taesd/blob/main/taef1_decoder.pth" --progress=bar:force:noscroll
# RUN wget -O /ComfyUI/models/vae_approx/taef1_encoder.pth "https://github.com/madebyollin/taesd/blob/main/taef1_encoder.pth" --progress=bar:force:noscroll

# Download and move clip_l.safetensors
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download comfyanonymous/flux_text_encoders --include "*.safetensors" --exclude "*_fp8_*.*" --local-dir /ComfyUI/models/clip

# Download and move clip_vision models
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download openai/clip-vit-large-patch14 --include model.safetensors --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/clip_vit.safetensors

RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download google/siglip-so400m-patch14-384 --include model.safetensors --local-dir /ComfyUI/models/clip_vision && \
    mv /ComfyUI/models/clip_vision/model.safetensors /ComfyUI/models/clip_vision/siglip-so400m.safetensors

# Download upscaler
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ai-forever/Real-ESRGAN --include "RealESRGAN_x2.pth" --local-dir /ComfyUI/models/upscale_models
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download lokCX/4x-Ultrasharp --include "*.pth" --local-dir /ComfyUI/models/upscale_models

# Download and move controlnet
RUN mkdir -p /ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FLUX.1-dev-ControlNet-Union-Pro --include diffusion_pytorch_model.safetensors --local-dir /ComfyUI/models/controlnet/FLUX.1/Shakker-Labs-ControlNet-Union-Pro

# Donwload redux & fill model
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download black-forest-labs/FLUX.1-Fill-dev --include "flux1-fill-dev.safetensors" --local-dir /ComfyUI/models/diffusion_models/FLUX1
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download black-forest-labs/FLUX.1-Redux-dev --include "flux1-redux-dev.safetensors" --local-dir /ComfyUI/models/style_models

# Download Concept-LoRA
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download ali-vilab/In-Context-LoRA --include "*.safetensors" --local-dir /ComfyUI/models/loras
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download multimodalart/product-design --include product-design.safetensors --local-dir /ComfyUI/models/loras
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download strangerzonehf/Flux-Creative-Stocks-LoRA --include Creative-Stocks.safetensors --local-dir /ComfyUI/models/loras
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download tryonlabs/FLUX.1-dev-LoRA-Outfit-Generator --include "outfit-generator.safetensors" --local-dir /ComfyUI/models/loras
# RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download TTPlanet/Migration_Lora_flux --include "Migration_Lora_cloth.safetensors" --local-dir /ComfyUI/models/loras
# RUN wget -O /ComfyUI/models/loras/simply_try_on.safetensors "https://civitai.com/api/download/models/1063742?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"
# RUN wget -O /ComfyUI/models/loras/cute_robot.safetensors "https://civitai.com/api/download/models/856914?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"
# RUN wget -O /ComfyUI/models/loras/Minimalist_Flat_Color_Illustration.safetensors "https://civitai.com/api/download/models/1077005?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"

# Download Detail-LoRA
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download strangerzonehf/Flux-Super-Realism-LoRA --include "super-realism.safetensors" --local-dir /ComfyUI/models/loras
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Shakker-Labs/FLUX.1-dev-LoRA-add-details --include "*.safetensors" --local-dir /ComfyUI/models/loras
RUN wget -O /ComfyUI/models/loras/ultrarealistic-lora-project.safetensors "https://civitai.com/api/download/models/1026423?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"
RUN wget -O /ComfyUI/models/loras/detailed_hands.safetensors "https://civitai.com/api/download/models/804967?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"
# RUN wget -O /ComfyUI/models/loras/sinfully_stylish.safetensors "https://civitai.com/api/download/models/755549?type=Model&format=SafeTensor&fp=fp16&token=ff61c6fbf8c474895b34eddabb2e31f9"

# Donwload Turbo-LoRA
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download alimama-creative/FLUX.1-Turbo-Alpha --include "diffusion_pytorch_model.safetensors" --local-dir /ComfyUI/models/loras

# Download ip_adapter
RUN mkdir -p /ComfyUI/models/ipadapter-flux && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download InstantX/FLUX.1-dev-IP-Adapter --include ip-adapter.bin --local-dir /ComfyUI/models/ipadapter-flux

RUN mkdir -p /ComfyUI/models/xlabs/ipadapters && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download XLabs-AI/flux-ip-adapter-v2 --include ip_adapter.safetensors --local-dir /ComfyUI/models/xlabs/ipadapters

# # make the xlabs directory
# RUN mkdir -p /ComfyUI/models/xlabs/loras && \
#     HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download XLabs-AI/flux-RealismLora --include lora.safetensors --local-dir /ComfyUI/models/xlabs/loras

CMD [ "/start.sh" ]
