FROM jodog0412/jdg-comfyui:1.1.0

RUN pip3 install imageio-ffmpeg

# RUN git clone https://github.com/thu-ml/SageAttention.git && \
#     cd SageAttention && \
#     python3 setup.py install 

RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-WanVideoWrapper.git && \
    cd ComfyUI-WanVideoWrapper && \
    pip3 install -r requirements.txt

RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite.git && \
    cd ComfyUI-VideoHelperSuite && \
    pip3 install -r requirements.txt
    
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/orssorbit/ComfyUI-wanBlockswap.git

RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Fannovel16/ComfyUI-Frame-Interpolation.git && \
    cd ComfyUI-Frame-Interpolation && \
    python3 install.py

COPY --chmod=755 download_WAN_models.sh /download_WAN_models.sh
COPY --chmod=755 download_WAN_LoRAs.sh /download_WAN_LoRAs.sh