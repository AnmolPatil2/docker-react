FROM node:13.12.0-alpine as builder

# set working directory
WORKDIR /app

# add `/app/node_modules/.bin` to $PATH
ENV PATH /app/node_modules/.bin:$PATH

# install app dependencies
COPY package.json ./
RUN npm install  
COPY . ./
RUN npm run build
# add app


# start app
from nginx
COPY --from=builder /app/build /usr/share/nginx/html
