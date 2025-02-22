-- Create table for Units (to be reused across attributes)
CREATE TABLE units (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

-- Create table for Reading Types (pseudo-table)
CREATE TABLE reading_types (
    id INTEGER PRIMARY KEY,
    name TEXT UNIQUE NOT NULL
);

-- Create table for Readings (individual entries)
CREATE TABLE readings (
    id INTEGER PRIMARY KEY,
    type_id INTEGER NOT NULL, -- The type this reading belongs to
    created_at INTEGER DEFAULT (unixepoch()), -- UNIX Time at INSERT
    note TEXT,
    FOREIGN KEY (type_id) REFERENCES reading_types(id) ON DELETE CASCADE -- If type is deleted, all data is deleted
);

-- Create table for Reading Attributes (user-defined columns per type, or pseudo-column)
CREATE TABLE reading_attributes (
    id INTEGER PRIMARY KEY,
    type_id INTEGER NOT NULL, -- The type this attribute is defining a pseudo-column for
    unit_id INTEGER NULL,
    name TEXT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES reading_types(id) ON DELETE CASCADE,
    FOREIGN KEY (unit_id) REFERENCES units(id),
    CONSTRAINT unique_name UNIQUE (type_id, name)
);

-- Create table for Reading Values (stores actual data)
CREATE TABLE reading_values (
    reading_id INTEGER NOT NULL,
    attribute_id INTEGER NOT NULL,
    value TEXT,
    FOREIGN KEY (reading_id) REFERENCES readings(id) ON DELETE CASCADE,
    FOREIGN KEY (attribute_id) REFERENCES reading_attributes(id) ON DELETE CASCADE,
    UNIQUE (reading_id, attribute_id)
);
