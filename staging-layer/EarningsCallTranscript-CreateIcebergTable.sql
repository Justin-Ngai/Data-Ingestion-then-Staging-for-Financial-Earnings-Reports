CREATE TABLE equity_research.earnings_call_transcripts (
    symbol STRING,
    quarter STRING,
    transcript ARRAY<STRUCT<speaker: STRING, title: STRING, content: STRING, sentiment: DOUBLE>>,
    ingestion_date DATE,
    last_updated TIMESTAMP
)
--LOCATION 's3://stage-us-east-1-jngai-dev/iceberg/earnings_call_transcripts/'
TBLPROPERTIES (
    'table_type' = 'ICEBERG',
    'format' = 'parquet',
    'write_compression' = 'snappy',
    'optimize_rewrite_delete_file_threshold' = '10'
);
