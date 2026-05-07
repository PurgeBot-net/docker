# docker

Deployment repository for PurgeBot. Contains the Docker Compose stack and environment configuration.

## Services

| Service        | Image                               | Description               |
| -------------- | ----------------------------------- | ------------------------- |
| `interactions` | `ghcr.io/purgebot-net/interactions` | HTTP interactions service |
| `gateway`      | `ghcr.io/purgebot-net/gateway`      | Discord gateway service   |
| `purger`       | `ghcr.io/purgebot-net/purger`       | Purge job worker          |
| `postgres`     | `postgres:16-alpine`                | Primary database          |
| `redis`        | `redis:7-alpine`                    | Job queue and guild locks |
| `kafka`        | `apache/kafka`                      | Event bus                 |

## Setup

1. Copy `.env.example` to `.env` and fill in all values.
2. Run the stack:

```sh
docker compose up -d
```

To update to the latest images:

```sh
docker compose pull && docker compose up -d
```

## Configuration

| Variable                 | Description                                                    |
| ------------------------ | -------------------------------------------------------------- |
| `DISCORD_TOKEN`          | Bot token                                                      |
| `DISCORD_PUBLIC_KEY`     | Ed25519 public key for signature verification                  |
| `DISCORD_APPLICATION_ID` | Application ID                                                 |
| `DATABASE_HOST`          | PostgreSQL host                                                |
| `DATABASE_PORT`          | PostgreSQL port                                                |
| `DATABASE_NAME`          | Database name                                                  |
| `DATABASE_USER`          | Database user                                                  |
| `DATABASE_PASSWORD`      | Database password                                              |
| `POSTGRES_PORT`          | Host port binding for postgres (default `5432`)                |
| `REDIS_PORT`             | Host port binding for Redis (default `6379`)                   |
| `KAFKA_PORT`             | Host port binding for Kafka (default `9092`)                   |
| `INTERACTIONS_PORT`      | Host port binding for the interactions service (default `8080`)|
| `REDIS_ADDR`             | Redis address (default `redis:6379`)                           |
| `REDIS_PASSWORD`         | Redis password                                                 |
| `REDIS_DB`               | Redis database index                                           |
| `KAFKA_BROKERS`          | Kafka broker list                                              |
| `KAFKA_EVENTS_TOPIC`     | Topic for guild lifecycle events                               |
| `SENTRY_DSN`             | Sentry error reporting (optional)                              |
| `LOG_LEVEL`              | `debug`, `info`, `warn`, `error`                               |
| `LOG_JSON`               | `true` for JSON log output                                     |
| `INTERACTIONS_IMAGE`     | Pinned interactions image                                      |
| `GATEWAY_IMAGE`          | Pinned gateway image                                           |
| `PURGER_IMAGE`           | Pinned purger image                                            |
| `INTERACTIONS_ADDR`      | Listen address for the interactions service (default `:8080`)  |
| `PREMIUM_SKU_ID`         | Discord premium SKU ID (optional)                              |
| `FREE_PREMIUM_GUILD_IDS` | Comma-separated guild IDs with free premium (optional)         |
