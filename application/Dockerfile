FROM node:17-slim

# Create app directory
WORKDIR /opt/app

COPY package*.json /opt/app/
RUN npm install
COPY . /opt/app/

# Build packages
RUN npm run build

# Exposing port for service
EXPOSE 3000

# Serve service
ENTRYPOINT node .