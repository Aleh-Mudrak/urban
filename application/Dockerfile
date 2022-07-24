FROM node:17-slim

# Create app directory
WORKDIR /opt/app

COPY package*.json /opt/app/
RUN npm install
COPY . /opt/app/

# Add Prometheus metrics
RUN npm add express-prometheus-metrics
RUN npm add pkginfo

# Build packages
RUN npm run build

# Exposing port for service
EXPOSE 3000

# Serve service
# ENTRYPOINT node .
CMD npm start
