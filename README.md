# docker

Deployment repository for PurgeBot. Contains the Docker Compose stack and environment configuration.

## Services

| Service | Image | Description |
|---------|-------|-------------|

| `interactions` | `ghcr.io/purgebot-net/interactions` | HTTP interactions service |
| `gateway` | `ghcr.io/purgebot-net/gateway` | Discord gateway service |
| `purge` | `ghcr.io/purgebot-net/purge` | Purge job worker |
| `postgres` | `postgres:16-alpine` | Primary database |
| `redis` | `redis:7-alpine` | Job queue and guild locks |
| `kafka` | `apache/kafka` | Event bus |

## Setup

1. Copy `.env.example` to `.env` and fill in all values.
2. Run the stack:

```sh
docker compose up -d
```

Service images are pinned via the `*_IMAGE` variables in `.env`. These are updated automatically by the release workflow when a new version of a service is published.

## Configuration

| Variable | Description |
|----------|-------------|

| `DISCORD_TOKEN` | Bot token |
| `DISCORD_PUBLIC_KEY` | Ed25519 public key for signature verification |
| `DISCORD_APPLICATION_ID` | Application ID |
| `DATABASE_HOST` | PostgreSQL host |
| `DATABASE_PORT` | PostgreSQL port |
| `DATABASE_NAME` | Database name |
| `DATABASE_USER` | Database user |
| `DATABASE_PASSWORD` | Database password |
| `DATABASE_REPLICA_*` | Read replica connection (can point at same host for local dev) |
| `REPLICATOR_PASSWORD` | Password for the replication user (created on first start) |
| `REDIS_ADDR` | Redis address (default `redis:6379`) |
| `REDIS_PASSWORD` | Redis password |
| `REDIS_DB` | Redis database index |
| `KAFKA_BROKERS` | Kafka broker list |
| `KAFKA_EVENTS_TOPIC` | Topic for guild lifecycle events |
| `SENTRY_DSN` | Sentry error reporting (optional) |
| `LOG_LEVEL` | `debug`, `info`, `warn`, `error` |
| `LOG_JSON` | `true` for JSON log output |
| `INTERACTIONS_IMAGE` | Pinned interactions image |
| `GATEWAY_IMAGE` | Pinned gateway image |
| `PURGE_IMAGE` | Pinned purge image |
| `INTERACTIONS_ADDR` | Listen address for the interactions service (default `:8080`) |
| `PREMIUM_SKU_ID` | Discord premium SKU ID (optional) |
| `FREE_PREMIUM_GUILD_IDS` | Comma-separated guild IDs with free premium (optional) |
