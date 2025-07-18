FROM node:18-alpine AS build

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

FROM nginx:stable-alpine

WORKDIR /app

COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

