
FROM slingdata/sling:latest

WORKDIR /app

USER sling


# If you want to specify a duckdb version:
ENV DUCKDB_VERSION=1.3.2

# Run a dummy run to force sling to download duckdb
RUN echo -e "id,name,age\n1,Alice,30\n2,Bob,25\n3,Charlie,35" > /tmp/sample.csv

RUN cat <<EOF > /tmp/replication.yml
source: file
target: file
streams:
  file:///tmp/sample.csv:
    object: file:///tmp/sample.out.parquet
EOF

RUN sling run -r /tmp/replication.yml

# Set the entrypoint
ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
