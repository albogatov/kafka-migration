CREATE TABLE readings (
    readings_id Int32 Codec(DoubleDelta, LZ4),
    time DateTime Codec(DoubleDelta, LZ4),
    date ALIAS toDate(time),
    temperature Decimal(5,2) Codec(T64, LZ4)
) Engine = MergeTree
PARTITION BY toYYYYMM(time)
ORDER BY (readings_id, time);

CREATE TABLE readings_queue (
    readings_id Int32,
    time DateTime,
    temperature Decimal(5,2)
) ENGINE=Kafka('broker:29092', 'readings', 'readings_consumer_group1', 'CSV');

CREATE MATERIALIZED VIEW readings_queue_mv TO readings AS
SELECT readings_id, time, temperature
FROM readings_queue
SETTINGS
stream_like_engine_allow_direct_select = 1;