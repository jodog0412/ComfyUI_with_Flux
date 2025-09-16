FROM jodog0412/jdg-comfyui:1.1.0

RUN pip3 install hf_transfer 
RUN pip3 install insightface    

# Download IP-Adapter
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git

COPY --chmod=755 download_stylers.sh /download_stylers.sh
COPY --chmod=755 download_models.sh /download_models.sh

CMD [ "/start.sh" ]