FROM node:alpine

LABEL maintainer="afs0030112@agderskolen.no"
LABEL greeting="takk for at du bruker mitt docker image"

WORKDIR /app

COPY /package.json /app/
RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]
