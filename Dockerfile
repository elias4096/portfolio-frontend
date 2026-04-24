# docker build -t bryrmiginte/portfolio-frontend:latest .
# docker push bryrmiginte/portfolio-frontend:latest

# docker run -p 80:80 bryrmiginte/portfolio-frontend:latest

FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

FROM caddy:2
WORKDIR /srv
COPY --from=builder /app/dist /srv
COPY Caddyfile /etc/caddy/Caddyfile
EXPOSE 80
EXPOSE 443
