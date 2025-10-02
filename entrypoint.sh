#!/bin/bash

# Sling Docker Runner Script

set -e

# Use provided SRC_DB or default
SLING_SRC_DB="${SLING_SRC_DB}"

if [ -z "$SLING_SRC_DB" ]; then
    echo "Error: SLING_SRC_DB environment variable is not set."
    echo "Please set SLING_SRC_DB to your source database connection string."
    exit 1
fi

# Check if action is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <action> [additional_args...]"
    echo ""
    echo "Actions:"
    echo "  discover - Discover database schema and connections"
    echo "  ingest   - Run full data ingestion"
    echo ""
    echo "Examples:"
    echo "  $0 discover"
    echo "  $0 ingest"
    echo ""
    echo "Environment variables:"
    echo "  SLING_SRC_DB - Source database connection string"
    exit 1
fi

ACTION=$1
shift  # Remove the first argument so $@ contains the remaining args

echo "Running Sling with action: $ACTION"

case $ACTION in
    discover)
        echo "Discovering connections using SLING_SRC_DB: $SLING_SRC_DB"
        sling conns discover SLING_SRC_DB
        ;;
    ingest)
        echo "Running data ingestion"
        sling run -r /app/replication.yml
        ;;
    *)
        echo "Unknown action: $ACTION"
        echo "Valid actions are: discover, ingest"
        exit 1
        ;;
esac

echo "Sling operation completed successfully!"

# do not shut down the container
# tail -f /dev/null
