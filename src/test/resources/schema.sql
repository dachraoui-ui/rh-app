-- make sure the APP schema exists
CREATE SCHEMA IF NOT EXISTS app;

-- tell H2 to use it for the remainder of the session
SET SCHEMA app;
