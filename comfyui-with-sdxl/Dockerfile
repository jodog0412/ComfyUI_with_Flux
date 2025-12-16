FROM jodog0412/jdg-comfyui:2.0.0

RUN pip3 install insightface    

# Download IP-Adapter
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

# Download ComfyUI_LLM_SDXL_Adapter
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/NeuroSenko/ComfyUI_LLM_SDXL_Adapter.git

COPY --chmod=755 download_stylers.sh /download_stylers.sh
COPY --chmod=755 download_models.sh /download_models.sh

CMD [ "/start.sh" ]