-- startup_script https://clickhouse.com/docs/operations/startup-scripts
CREATE DATABASE log;
USE DATBABASE log;
CREATE TABLE IF NOT EXISTS app_logs {
  timestamp  
  hostname   STRING
  namespace  STRING
  pod        STRING
  container  STRING

  message    STRING
}

