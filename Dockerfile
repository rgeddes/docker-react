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
COPY --from=builder /app/build /usr/share/nginx/html

# the nginx container automatically starts nginx