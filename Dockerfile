FROM debian:latest

RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
        python2 \
        python-pip \
        libboost-graph-dev \
        git && \
    apt-get autoremove && \
    apt-get clean
    
RUN python -m pip install --upgrade \
        pip && \
    python -m pip install \
        networkx==1.1 && \
    python -m pip cache purge

RUN cd ~ \
    git https://github.com/marbl/SALSA.git && \
    cd SALSA && \
    make && \
    ln -s /root/SALSA/run_pipeline.py /root/SALSA/salsa 

ENV PATH="${PATH}:/root/SALSA"