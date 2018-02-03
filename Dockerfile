FROM ruby:2.3

RUN apt-get update && \
    apt-get -y --no-install-recommends install apt-transport-https && \
    groupadd --gid 1000 app && \
    adduser --disabled-login --uid 1000 --gid 1000 --gecos '' app && \
    rm /etc/localtime && \
    ln -s /usr/share/zoneinfo/Europe/Berlin /etc/localtime && \
    wget -qO- https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add - && \
    echo 'deb https://deb.nodesource.com/node_7.x jessie main' > /etc/apt/sources.list.d/nodesource.list && \
    apt-get update && \
    apt-get -y install nodejs libatk-bridge2.0-0 libgtk-3-0 libx11-xcb1 libnss3 libxss1 libasound2 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p /usr/src/app/bower_components && \
    chown -R app:app /usr/src/app && \
    npm install -g bower grunt-cli

WORKDIR /usr/src/app

COPY Gemfile* ./
RUN bundle install -j4

COPY package.json ./
RUN npm install

COPY bower.json ./
USER app
RUN bower install

COPY . .
USER root
RUN chown -R app:app /usr/src/app
USER app

VOLUME ["/usr/src/app/node_modules", "/usr/src/app/.sass_cache", "/usr/src/app/bower_components"]
CMD "grunt serve"
