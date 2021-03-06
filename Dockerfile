# base image
FROM node:12-alpine 

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /app/package.json 
COPY package-lock.json /app/package-lock.json 

# For vue/cli
COPY package.json /usr/local/package.json
COPY package-lock.json /usr/local/package-lock.json 
RUN npm i @vue/cli@4.0.5 -g

# install dep
RUN npm i

# start app
CMD ["npm", "run", "serve"] # dev
#CMD ["npm", "run", "build"] # build

# docker build -t meetingroom-frontend_vue .
# docker run -v ${PWD}:/app -v /app/node_modules -p 8081:8080 --rm my-app:dev

#ref. https://mherman.org/blog/dockerizing-a-vue-app/