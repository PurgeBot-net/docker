#!/usr/bin/env bash
set -e

# Run this script on the Raspberry Pi to initialise it as a read replica.
# Usage: ./setup-replica.sh <primary-host>
#
# <primary-host> is the IP or hostname of the machine running Docker Compose.
# The REPLICATOR_PASSWORD env var must be set, or you will be prompted.

PRIMARY_HOST="${1:?Usage: $0 <primary-host>}"
PRIMARY_PORT="${DATABASE_PORT:-5432}"
PG_VERSION=16
PGDATA="/var/lib/postgresql/$PG_VERSION/main"

if [ -z "$REPLICATOR_PASSWORD" ]; then
    read -rsp "Replicator password: " REPLICATOR_PASSWORD
    echo
fi

echo "Stopping PostgreSQL..."
sudo systemctl stop postgresql

echo "Clearing data directory..."
sudo -u postgres rm -rf "$PGDATA"

echo "Pulling base backup from $PRIMARY_HOST:$PRIMARY_PORT..."
sudo -u postgres env PGPASSWORD="$REPLICATOR_PASSWORD" pg_basebackup \
    -h "$PRIMARY_HOST" \
    -U replicator \
    -p "$PRIMARY_PORT" \
    -D "$PGDATA" \
    -P -Xs -R

echo "Starting replica..."
sudo systemctl start postgresql

echo ""
echo "Done! Verify replication on the primary with:"
echo "  docker exec -it <postgres-container> psql -U \$DATABASE_USER -c 'SELECT * FROM pg_stat_replication;'"
