# create a file named Dockerfile
FROM node:argon
RUN mkdir /app
WORKDIR /app
COPY . /app
RUN npm install

EXPOSE 4201
CMD ["node", "index.js"]
