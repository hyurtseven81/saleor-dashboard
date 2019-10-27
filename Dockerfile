FROM nginx:alpine

RUN apk add --update nodejs npm yarn

WORKDIR /usr/share/nginx/html

COPY . /usr/share/nginx/html
RUN npm i

ARG APP_MOUNT_URI
ARG API_URI
ARG STATIC_URL

ENV APP_MOUNT_URI=${APP_MOUNT_URI}
ENV API_URI=${API_URI}
ENV STATIC_URL=${STATIC_URL}

RUN echo "APP_MOUNT_URI $APP_MOUNT_URI"
RUN echo "API_URI $API_URI"
RUN echo "STATIC_URL $STATIC_URL"

RUN npm run build

COPY ./default.conf /etc/nginx/conf.d/

EXPOSE 8080
CMD ["nginx", "-g", "daemon off;"]

