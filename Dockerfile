FROM nvidia/cuda:12.6.2-base-ubuntu24.04

RUN apt-get update && \
    apt-get install -y --allow-unauthenticated --no-install-recommends nvidia-open wget git && \
    apt-get autoremove -y && \
    apt-get clean -y && \
    rm -rf /var/lib/apt/lists/*

ENV HOME "/root"

ENV CONDA_DIR "${HOME}/miniconda"

ENV PATH="$CONDA_DIR/bin":$PATH

ENV CONDA_AUTO_UPDATE_CONDA=false

ENV PIP_DOWNLOAD_CACHE="$HOME/.pip/cache"

ENV TORTOISE_MODELS_DIR="$HOME/tortoise-tts/build/lib/tortoise/models"

RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/miniconda3.sh \
    && bash /tmp/miniconda3.sh -b -p "${CONDA_DIR}" -f -u \
    && "${CONDA_DIR}/bin/conda" init bash \
    && rm -f /tmp/miniconda3.sh \
    && echo ". '${CONDA_DIR}/etc/profile.d/conda.sh'" >> "${HOME}/.profile"

# --login option used to source bashrc (thus activating conda env) at every RUN statement
SHELL ["/bin/bash", "--login", "-c"]

WORKDIR /tortoise

COPY . ./

RUN conda create --yes --name tortoise python=3.10 numba inflect && \
    conda activate tortoise && \
    conda install --yes pytorch torchvision torchaudio pytorch-cuda=12.4 -c pytorch -c nvidia && \
    conda install --yes transformers=4.29.2 && \
    conda install --yes spacy && \
    cd /tortoise && \
    pip install .

CMD ["conda", "run", "-n", "tortoise", "python", "tortoise/server.py"]