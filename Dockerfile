FROM node:4-alpine

RUN apk add libzmq3-dev build-essential

RUN groupadd bitcore
RUN useradd bitcore -m -s /bin/bash -g bitcore
ENV HOME /home/bitcore
USER bitcore

WORKDIR /home/bitcore
COPY bitcore-node.json ./bitcore-node.json

RUN npm install -g bitcore

EXPOSE 3001 3232 6667 8333 18333
HEALTHCHECK --interval=5s --timeout=5s --retries=10 CMD curl -f http://localhost:3001/insight/

VOLUME /home/bitcore/datadir

ENTRYPOINT ["./.npm/node_modules/.bin/bitcore-node start ./bitcore-node.json"]