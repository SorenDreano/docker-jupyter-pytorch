FROM pytorch/pytorch:1.9.0-cuda10.2-cudnn7-runtime

RUN apt-get update && apt-get install -y --no-install-recommends \
         libsm6 \
         libxext6 \
         libxrender-dev \
         git \
         wget\
         ffmpeg && \
     rm -rf /var/lib/apt/lists/*

RUN /opt/conda/bin/conda create -n py36 python=3.6 anaconda
RUN /opt/conda/bin/conda install -n py36 -y opencv Cython pandas scikit-learn matplotlib seaborn jupyter jupyterlab && \
    /opt/conda/bin/conda clean -ya

RUN /opt/conda/envs/py36/bin/python -m pip install --upgrade --upgrade-strategy only-if-needed scikit-image scikit-learn-intelex

RUN /opt/conda/envs/py36/bin/python -m pip uninstall -y torch Pillow
RUN /opt/conda/envs/py36/bin/python -m pip install Pillow==6.2
RUN /opt/conda/envs/py36/bin/python -m pip uninstall -y torch
#RUN pip install torch==1.9.0+cu102 -f https://nelsonliu.me/files/pytorch/whl/torch_stable.html
RUN /opt/conda/envs/py36/bin/python -m pip install torchvision
RUN /opt/conda/envs/py36/bin/python -m pip install torch==1.9.1+cu102 -f https://nelsonliu.me/files/pytorch/whl/torch_stable.html

RUN mkdir -p /home/me && chmod 1777 /home/me

ENV HOME /home/me

# jupyter notebook
EXPOSE 8888

COPY start_custom_python.sh /

CMD ["start_custom_python.sh"]

