#multi step prozess
#naming of the first step
FROM node:16-alpine as builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

#new step (everytime you use FROM again)
FROM nginx
#copy from step builder, take /app/build-folder an copy it into the nginx-folder
#it takes just the /app/build-folder. everything else is not copied and dumped
COPY --from=builder /app/build /usr/share/nginx/html
