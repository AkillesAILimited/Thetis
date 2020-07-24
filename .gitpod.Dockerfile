FROM gitpod/workspace-full-vnc

USER gitpod

RUN wget https://atom.io/download/deb
RUN mv deb atom.deb
RUN sudo apt-get -q update && \
  sudo bash -c "export DEBIAN_FRONTEND=noninteractive; apt-get install -f -y keyboard-configuration; echo \$DEBIAN_FRONTEND" && \
  sudo apt install -f -y ./atom.deb && \ 
  sudo apt-get install -f -y julia && \
  sudo apt-get install -f -y gpg && \
  curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg && \
  sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/ && \
  sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' && \
  sudo apt-get install -y -f apt-transport-https && \
  sudo apt-get update && \
  sudo apt-get install -y -f code && \
  sudo apt-get install -y -f xxgdb && \
  sudo rm -rf /var/lib/apt/lists/* && \
  rm atom.deb

USER root

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
