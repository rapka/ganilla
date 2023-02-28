FROM nvcr.io/nvidia/pytorch:23.01-py3

ENV PATH="/root/miniconda3/bin:${PATH}"
ARG PATH="/root/miniconda3/bin:${PATH}"

# RUN apt-get update
# RUN apt-get install -y wget && rm -rf /var/lib/apt/lists/*
# RUN wget \
#    https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#    && mkdir /root/.conda \
#    && bash Miniconda3-latest-Linux-x86_64.sh -b \
#    && rm -f Miniconda3-latest-Linux-x86_64.sh
# RUN conda --version

# RUN conda install numpy pyyaml mkl mkl-include setuptools cmake cffi typing
# RUN conda install visdom dominate -c conda-forge # install visdom and dominate

COPY . .

RUN bash ./datasets/download_cyclegan_dataset.sh monet2photo

RUN pip install dominate>=2.3.1 visdom>=0.1.8.3 scipy>=1.1.0 pillow

RUN python test.py --dataroot datasets/monet2photo/testB --name hm_pretrained --model test
