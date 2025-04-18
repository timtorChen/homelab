CREATE TABLE <table_name>
(
    // Common metadata fields
    _namespace      String,
    _timestamp      Int64,
    hostname        String,
    zone            String,
    ...

    // Raw log event
    _source         String,

    // Type-specific field names and field values
    string.names    Array(String),
    string.values   Array(String),

    number.names    Array(String),
    number.values   Array(Float64),

    bool.names      Array(String),
    bool.values     Array(UInt8),

    // Materialized fields (optional denormalized columns for faster querying)
    bar.String      String,
    foo.Number      Float64,
    ...
)