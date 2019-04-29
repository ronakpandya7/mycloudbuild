FROM node
# Create app directory
RUN mkdir -p /usr/src/cloudapp
WORKDIR /usr/src/cloudapp

# Install server dependencies
COPY . /usr/src/cloudapp/
RUN npm install

# Install app dependencies
WORKDIR /usr/src/cloudapp/CB/
RUN npm install

# Build image 
RUN node --max_old_space_size=3048 ./node_modules/@angular/cli/bin/ng build --prod --aot --build-optimizer --vendor-chunk=true --output-hashing none

WORKDIR /usr/src/cloudapp

# Replace image
RUN rm -rf /usr/src/cloudapp/app && mv /usr/src/cloudapp/CB/dist/CB /usr/src/cloudapp/app

# Expose the port
EXPOSE 7000

# Start Node.js Application with server.js
CMD [ "node", "server.js" ]
