FROM ubuntu:bionic
RUN apt-get update && apt-get --no-install-recommends install -y curl git fontconfig apt-utils language-pack-en-base language-pack-zh-hant-base language-pack-zh-hant language-pack-en zsh python3 python3-pip gcc musl-dev
RUN apt-get install -y locales && rm -rf /var/lib/apt/lists/* \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
RUN mkdir -p /usr/local/fonts && cd /usr/local/fonts && curl --silent -fLo "Source Code Pro Regular Nerd Font Complete.ttf" https://github.com/ryanoasis/nerd-fonts/raw/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf
RUN sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


RUN cd /root
COPY zshrc-template /root/.zshrc
RUN  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
RUN mkdir -p /Pyproj && cd /Pyproj
WORKDIR /PyProj
ADD . /PyProj
ENV FLASK_APP app.py
ENV FLASK_RUN_HOST 0.0.0.0
RUN pip3 install -r requirements.txt
