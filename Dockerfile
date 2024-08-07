# Use the official Bun image
FROM oven/bun:alpine

# Set the working directory
WORKDIR /app

# Install curl for Kamal health checks
# RUN apk add --no-cache curl

# Copy package.json and install dependencies
COPY package.json bun.lockb /app/
RUN bun install

# Copy the rest of the application code
COPY . .

RUN bun run build

ENV HOST=0.0.0.0
ENV PORT=4321
EXPOSE 4321
CMD bun ./dist/server/entry.mjs
