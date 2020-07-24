FROM gitpod/workspace-full-vnc

USER gitpod

RUN wget https://atom.io/download/deb
RUN sudo apt install deb
RUN rm deb

#RUN sudo apt-get -q update && \
#    sudo apt-get install -yq atom && \
#    sudo rm -rf /var/lib/apt/lists/*

# Install custom tools, runtime, etc. using apt-get
# For example, the command below would install "bastet" - a command line tetris clone:
#
# RUN sudo apt-get -q update && \
#     sudo apt-get install -yq bastet && \
#     sudo rm -rf /var/lib/apt/lists/*
#
# More information: https://www.gitpod.io/docs/config-docker/
