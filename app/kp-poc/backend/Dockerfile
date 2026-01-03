FROM node:10-alpine

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

RUN apk add curl

EXPOSE 3001

CMD ["node", "server.js"]