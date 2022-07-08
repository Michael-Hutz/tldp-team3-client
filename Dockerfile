FROM node:18-alpine AS build-environment

RUN apk update
WORKDIR /app

COPY . .
RUN npm install
RUN npm run build

FROM alpine
RUN apk update
RUN apk add nginx
WORKDIR /app
COPY --from=build-environment /app/build /app
COPY ./default.conf /etc/nginx/http.d/default.conf
EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
