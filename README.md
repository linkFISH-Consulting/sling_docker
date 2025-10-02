# Run sling as a docker container


## Getting Started
Currently only for ingesting to parquet files.


1. Place desired replication as `replication.yml` or use env vars below.
2. Run docker compose commands below.

**Environment variables:**
```bash
# source database connection string, required
export SLING_SRC_DB="..."

# path to replication.yml, optional, default ./replication.yml
export SLING_REPLICATION_PATH="./replication.yml"

# output directory for parquet files, optional, default ./data/
export SLING_OUTPUT_DIR="./data/"
```


**Docker commands:**
```bash
docker compose run --rm sling discover
docker compose run --rm sling ingest

# env vars can be passed inline too:
docker compose run --rm -e SLING_SRC_DB="..." sling discover
```

**Connection string examples** for `SLING_SRC_DB`:
```
sqlserver://myuser:mypass@host.ip:1433/my_instance?database=master&encrypt=true&TrustServerCertificate=true
postgresql://myuser:mypass@host.ip:5432/mydatabase?sslmode=require&role=<role>
duckdb:///path/to/file.db
```


## Replication Example

```yaml

source: SLING_SRC_DB # keep and use this as your connection name!
target: LOCAL

defaults:
  target_options:
    format: parquet

streams:
  raw_wwi.Invoices:
    object: file:///data/invoices.parquet
```


## Limitations
- DuckDB is currently installed on every container run. See [this issue](https://github.com/slingdata-io/sling-cli/issues/212)
