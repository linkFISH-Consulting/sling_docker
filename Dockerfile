
FROM slingdata/sling:latest

WORKDIR /app

USER sling


# playing around
# ENV DUCKDB_VERSION=1.3.2
# ENV SLING_DUCKDB_COMPUTE=false

# Run a dummy run to force sling to download duckdb
# RUN echo -e "id,name,age\n1,Alice,30\n2,Bob,25\n3,Charlie,35" > /tmp/sample.csv
# RUN sling run --src-conn 'file:///tmp/sample.csv' --tgt-object 'file:///tmp/sample.out.parquet'


# Set the entrypoint
# ENTRYPOINT ["/bin/bash", "/app/entrypoint.sh"]
CMD ["tail", "-f", "/dev/null"]
