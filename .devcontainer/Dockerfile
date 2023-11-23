# See here for image contents: https://github.com/microsoft/vscode-dev-containers/tree/v0.241.1/containers/ubuntu/.devcontainer/base.Dockerfile

# [Choice] Ubuntu version (use ubuntu-22.04 or ubuntu-18.04 on local arm64/Apple Silicon): ubuntu-22.04, ubuntu-20.04, ubuntu-18.04
ARG VARIANT="jammy"
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

SHELL ["/bin/bash", "-c"]

# Install all packages for c/c++ development and icecream distributed compiler.
RUN apt-get update --fix-missing && export DEBIAN_FRONTEND=noninteractive \
        && apt-get -y install --no-install-recommends --fix-missing \
        lldb gcc gdb cmake make ninja-build git clangd \
        htop wget fish zsh lld time parallel \
        icecc icecream-sundae libcolamd2 clang-tidy gcc-multilib \
        build-essential clang-format doxygen clang ccache llvm nasm

# [Optional] Uncomment this section to install additional OS packages.
#RUN apt-get update --fix-missing && export DEBIAN_FRONTEND=noninteractive \
#        && apt-get -y install --no-install-recommends --fix-missing \
#        some more packages

# Set environment variables
# ENV PATH=$PATH:

RUN echo "set completion-ignore-case on" >> /etc/inputrc

#Seting up icecc (icecream) distributed compiler.
#IceCream uses Ports: TCP: 10245 8765 8766 and for UDP 8765
EXPOSE 10245 8766 8765/TCP 8765/UDP
