# Build Phase

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# build will create the /app/build directory
# and that is what we will copy to the next
# step

#################

# Run Phase

FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# nginx container automatically starts nginx