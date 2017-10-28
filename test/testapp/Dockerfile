FROM node:6.11.5

# Create app directory
WORKDIR /usr/src/testapp

# Install app dependencies
COPY app/package.json .

RUN npm install

# Bundle app source
COPY app/. .

EXPOSE 3000
CMD [ "npm", "start" ]
