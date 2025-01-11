FROM jodog0412/jdg-comfyui:1.0.0

RUN pip3 install hf_transfer

# Download HunyuanVideo
RUN HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/HunyuanVideo_comfy --include hunyuan_video_720_cfgdistill_fp8_e4m3fn.safetensors  --local-dir /ComfyUI/models/diffusion_models && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/HunyuanVideo_comfy --include hunyuan_video_vae_bf16.safetensors  --local-dir /ComfyUI/models/vae && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download Kijai/llava-llama-3-8b-text-encoder-tokenizer --local-dir /ComfyUI/models/LLM/llava-llama-3-8b-text-encoder-tokenizer && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download xtuner/llava-llama-3-8b-v1_1-transformers --local-dir /ComfyUI/models/LLM/llava-llama-3-8b-v1_1-transformers && \
    HF_HUB_ENABLE_HF_TRANSFER=1 huggingface-cli download openai/clip-vit-large-patch14 --include model.safetensors  --local-dir /ComfyUI/models/clip/clip-vit-large-patch14

CMD [ "/start.sh" ]