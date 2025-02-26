ARG CUDA_VERSION="12.1.1"
ARG CUDNN_VERSION="8"
ARG UBUNTU_VERSION="22.04"
ARG DOCKER_FROM=nvidia/cuda:$CUDA_VERSION-cudnn$CUDNN_VERSION-devel-ubuntu$UBUNTU_VERSION

# Base NVidia CUDA Ubuntu image
FROM $DOCKER_FROM AS base

ENV HF_TOKEN ""
ENV CIVITAI_API_TOKEN ""

# Install Python plus openssh, which is our minimum set of required packages.
RUN apt-get update -y && \
    apt-get install -y python3 python3-pip python3-venv && \
    apt-get install -y --no-install-recommends openssh-server openssh-client git git-lfs wget vim zip unzip curl && \
    python3 -m pip install --upgrade pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install hf_transfer

# Install nginx
RUN apt-get update && \
    apt-get install -y nginx

# Copy the 'default' configuration file to the appropriate location
COPY default /etc/nginx/sites-available/default

ENV PATH="/usr/local/cuda/bin:${PATH}"

# Install pytorch
ARG PYTORCH="2.4.0"
ARG CUDA="121"
RUN pip3 install --no-cache-dir -U torch==$PYTORCH torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu$CUDA

COPY --chmod=755 start-ssh-only.sh /start.sh
COPY --chmod=755 start-original.sh /start-original.sh
COPY --chmod=755 comfyui-on-workspace.sh /comfyui-on-workspace.sh
COPY --chmod=755 ai-toolkit-on-workspace.sh /ai-toolkit-on-workspace.sh
COPY --chmod=755 check_files.sh /check_files.sh

# Clone the git repo and install requirements in the same RUN command to ensure they are in the same layer
RUN git clone https://github.com/comfyanonymous/ComfyUI.git && \
    cd ComfyUI && \
    pip3 install -r requirements.txt && \
    cd custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Manager.git && \
    git clone https://github.com/pythongosssss/ComfyUI-Custom-Scripts.git && \
    cd /ComfyUI && \
    mkdir pysssss-workflows

COPY --chmod=644 workflows/ /ComfyUI/pysssss-workflows/
COPY --chmod=644 comfy.settings.json /ComfyUI/user/default/comfy.settings.json
COPY --chmod=644 character_sheet_example.png /ComfyUI/input/character_sheet_example.png
COPY --chmod=644 example_photo.png /ComfyUI/input/example_photo.png
COPY --chmod=644 example_photo_small.png /ComfyUI/input/example_photo_small.png
COPY --chmod=644 example_pose.png /ComfyUI/input/example_pose.png
COPY --chmod=644 example2.png /ComfyUI/input/example2.png
COPY --chmod=644 driving_video.mp4 /ComfyUI/input/driving_video.mp4

WORKDIR /workspace

EXPOSE 8188

# Download and move flux_dev_example.png
RUN wget "https://github.com/comfyanonymous/ComfyUI_examples/blob/master/flux/flux_dev_example.png" -P /ComfyUI

# Install Xlabs-AI/flux-RealismLora
RUN apt-get install -y libgl1-mesa-glx libglib2.0-0 --fix-missing
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/XLabs-AI/x-flux-comfyui.git && \
    cd x-flux-comfyui && \
    python3 setup.py

# This is a hacky way to change the default workflow on startup, but it works
COPY --chmod=644 defaultGraph.json /defaultGraph.json
COPY --chmod=755 replaceDefaultGraph.py /replaceDefaultGraph.py
# Run the Python script
RUN python3 /replaceDefaultGraph.py

# Add Jupyter Notebook
RUN pip3 install jupyterlab
EXPOSE 8888

# Add download scripts for additional models
COPY --chmod=755 download_Florence-2.sh /download_Florence-2.sh
COPY --chmod=755 download_Janus-Pro.sh /download_Janus-Pro.sh
COPY --chmod=755 download_Upscalers.sh /download_Upscalers.sh
COPY --chmod=755 download_ALL.sh /download_ALL.sh
COPY --chmod=755 make_venv.sh /make_venv.sh
COPY --chmod=755 disable_mixlab.sh /disable_mixlab.sh

# KJNodes
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-KJNodes.git && \
    cd ComfyUI-KJNodes && \
    pip3 install -r requirements.txt

# rgthree
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/rgthree/rgthree-comfy.git && \
    cd rgthree-comfy && \
    pip3 install -r requirements.txt

# JPS-Nodes
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/JPS-GER/ComfyUI_JPS-Nodes.git

# Comfyroll Studio
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Suzie1/ComfyUI_Comfyroll_CustomNodes.git

# ComfyUI-Impact-Pack
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Pack.git && \
    cd ComfyUI-Impact-Pack && \
    pip3 install -r requirements.txt && \
    python3 install.py

# ComfyUI-Impact-Subpack
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/ltdrdata/ComfyUI-Impact-Subpack.git && \
    cd ComfyUI-Impact-Subpack && \
    pip3 install -r requirements.txt && \
    python3 install.py

# ComfyUI-Impact-controlnet_aux
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git && \
    cd comfyui_controlnet_aux && \
    pip3 install -r requirements.txt

# ComfyUI-Easy-Use
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/yolain/ComfyUI-Easy-Use.git && \
    cd ComfyUI-Easy-Use && \
    pip3 install -r requirements.txt

# was-node-suite-comfyui
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/WASasquatch/was-node-suite-comfyui.git && \
    cd was-node-suite-comfyui && \
    pip3 install -r requirements.txt

# ComfyUI_essentials
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/cubiq/ComfyUI_essentials.git && \
    cd ComfyUI_essentials && \
    pip3 install -r requirements.txt

# cg-image-picker
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/chrisgoringe/cg-image-picker.git

# ComfyUI_LayerStyle
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/chflame163/ComfyUI_LayerStyle.git && \
    cd ComfyUI_LayerStyle && \
    pip3 install -r requirements.txt

# cg-use-everywhere
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/chrisgoringe/cg-use-everywhere.git

# Florence2
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/kijai/ComfyUI-Florence2.git && \
    cd ComfyUI-Florence2 && \
    pip3 install -r requirements.txt

# ComfyUI-Janus-Pro
RUN cd /ComfyUI/custom_nodes && \
    git clone https://github.com/CY-CHENYUE/ComfyUI-Janus-Pro.git && \
    cd ComfyUI-Janus-Pro && \
    pip3 install -r requirements.txt

CMD [ "/start.sh" ]
