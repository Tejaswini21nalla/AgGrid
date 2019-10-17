FROM node:latest as build-step
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build
FROM ngnix:latest as prod-step
COPY --from=build-step /app/dist/aggridangular /usr/share/ngnix/html
EXPOSE 80
CMD ["ngnix","-g","daemon off;"]