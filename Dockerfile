FROM debian:buster
WORKDIR /app
RUN apt-get update && apt-get install -y apache2-utils python3.7 python3-pip
RUN apt-get install -y curl && curl -sL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs

ADD python/requirements.txt /app/python/
RUN pip3 install -r python/requirements.txt

ADD node/package.json node/package-lock.json /app/node/
RUN cd node && npm install

ADD . /app

CMD ["/app/entrypoint.sh"]
