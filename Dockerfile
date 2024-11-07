FROM oven/bun:alpine AS base
  WORKDIR /app

  # By copying only the package.json and bun.lockb here,
  # we ensure that the following `-deps` steps are independent of the source code.
  # Therefore, the `-deps` steps will be skipped if only the source code changes.
  COPY package.json bun.lockb ./


FROM base AS prod-deps
  RUN bun install --production


FROM base AS build-deps
  RUN bun install


FROM build-deps AS build
  COPY . .
  RUN bun run build


FROM base AS runtime
  COPY --from=prod-deps /app/node_modules ./node_modules
  COPY --from=build /app/dist ./dist

  ENV HOST="0.0.0.0" \
      PORT="4321"

  EXPOSE 4321
  CMD ["bun", "--bun", "./dist/server/entry.mjs"]
