FROM ubuntu:focal

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt -y upgrade

# install essential packages
RUN apt-get -y install \
  curl \
  build-essential \
  software-properties-common \
  language-pack-en-base \
  gconf-service \
  libasound2 \
  libgtk-3-0 \
  libu2f-udev \
  libgconf-2-4 \
  libnspr4 \
  libx11-dev \
  fonts-liberation \
  xdg-utils \
  libnss3 \
  libxss1 \
  libappindicator3-1 \
  libindicator3-7 \
  libgbm1 \
  git \
  zip \
  unzip \
  xvfb \
  wget

# add Node.js, Yarn and PHP repos
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  LC_ALL=en_US.UTF-8 add-apt-repository -y ppa:ondrej/php && \
  apt-get update

# install Node.js, Yarn and PHP
RUN apt-get -y install \
  nodejs \
  yarn \
  php-xdebug \
  php8.1-fpm \
  php8.1-mbstring \
  php8.1-dom \
  php8.1-curl \
  php8.1-simplexml \
  php8.1-gd \
  php8.1-zip \
  php8.1-sqlite3 \
  php8.1-bcmath \
  php8.1-intl \
  php8.1-mysql

# install Composer
RUN curl -sS https://getcomposer.org/installer | php -- \
  --install-dir=/usr/local/bin --filename=composer

# install Google Chrome
RUN wget \
  https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb && \
  dpkg -i google-chrome*.deb && \
  apt-get install -f && \
  rm google-chrome-stable_current_amd64.deb
