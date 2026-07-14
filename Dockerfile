FROM node:20-trixie
LABEL maintainer="info@myridia.com"

RUN apt-get update && apt-get upgrade -y 
RUN apt-get install -y \
libfreetype-dev \
libjpeg62-turbo-dev \
libpng-dev \
emacs-nox \
ack \
build-essential \
checkinstall \
cmake \                    
git \                      
curl \                     
wget \                     
pkg-config \               
libssl-dev \               
libcurl4-openssl-dev \     
libboost-all-dev \         
libxml2-dev \              
libjpeg-dev \              
libpng-dev \               
libtiff-dev \              
libsqlite3-dev \           
zlib1g-dev \               
libreadline-dev \          
libncurses5-dev \          
libncursesw5-dev \         
libgdbm-dev \              
libffi-dev \               
python3-dev \              
ruby-dev \
rsync \
tree \
pipx 


RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 

RUN pipx install poetry && pipx ensurepath
ENV PATH="/root/.local/bin:$PATH"



WORKDIR /app

CMD ["bash"]
