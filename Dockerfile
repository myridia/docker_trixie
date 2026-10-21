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
pipx \
dnsutils \ 
redsocks \
iptables \
proxychains4 

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y 

RUN pipx install poetry && pipx ensurepath

RUN wget https://packages.microsoft.com/config/debian/13/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb 
RUN apt-get update
RUN apt-get install -y dotnet-sdk-10.0 aspnetcore-runtime-10.0

ENV PATH="/root/.local/bin:$PATH"



WORKDIR /app

CMD ["bash"]
