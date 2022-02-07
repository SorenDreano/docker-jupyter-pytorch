FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
         libsm6 \
         libxext6 \
         libxrender-dev \
         ffmpeg && \
     rm -rf /var/lib/apt/lists/*

RUN /opt/conda/bin/conda install -y opencv Cython pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
    /opt/conda/bin/conda clean -ya

RUN pip install --upgrade --upgrade-strategy only-if-needed scikit-image scikit-learn-intelex

RUN pip uninstall -y torch Pillow
RUN pip install Pillow==6.2
RUN pip uninstall -y torch
RUN pip install torch==1.9.0+cu102 -f https://nelsonliu.me/files/pytorch/whl/torch_stable.html
RUN pip install torchvision

RUN mkdir -p /home/me && chmod 1777 /home/me

ENV HOME /home/me

# jupyter notebook
EXPOSE 8888

COPY start.sh /

CMD ["/start.sh"]

