FROM node:20-trixie
RUN apt-get update && apt-get install -y \
libfreetype-dev \
libjpeg62-turbo-dev \
libpng-dev \
emacs-nox \
ack \
build-essential \
checkinstall 

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 
