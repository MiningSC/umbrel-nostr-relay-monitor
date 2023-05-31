# Build Stage
FROM node:18-buster-slim AS umbrel-nostr-relay-builder

# Create app directory
WORKDIR /app

# Copy app files
COPY . .

# Install dependencies (npm ci makes sure the exact versions in the lockfile gets installed)
RUN npm ci

# Build project
RUN npm run build

# Final image
FROM node:18-buster-slim AS umbrel-nostr-relay

# Create app directory
WORKDIR /app

# Copy built code from build stage to '/app' directory
COPY --from=umbrel-nostr-relay-builder /app /app

# Start the server
CMD ["npm", "start"]
