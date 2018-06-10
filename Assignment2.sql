-- For part one of this assignment you are to make a database with the following specifications and run the following queries
-- Table creation queries should immediately follow the drop table queries, this is to facilitate testing on my end

SET FOREIGN_KEY_CHECKS=0;

-- Create a table called category with the following properties:
-- id - an auto incrementing integer which is the primary key
-- name - a varchar with a maximum length of 255 characters, cannot be null
-- subcategory - a carchar with a maximum length of 255 characters
-- the combinatino of a name and subcategory must be unique
DROP TABLE IF EXISTS category;

CREATE TABLE category
(
id int AUTO_INCREMENT,
name varchar(255) NOT NULL,
subcategory varchar(255),
CONSTRAINT name_subcategory UNIQUE (name, subcategory),
PRIMARY KEY (id)
);

SET FOREIGN_KEY_CHECKS=1;


-- Create a table called operating_system with the following properties:
-- id - an auto incrementing integer which is the primary key
-- name - a varchar of maximum length 255, cannot be null
-- version - a varchar of maximum length 255, cannot be null
-- name version combinations must be unique
DROP TABLE IF EXISTS operating_system;

CREATE TABLE operating_system
(
id int AUTO_INCREMENT,
name varchar(255) NOT NULL,
version varchar(255) NOT NULL,
CONSTRAINT name_version UNIQUE (name, version),
PRIMARY KEY (id)
);


-- Create a table called device with the following properties:
-- id - an auto incrementing integer which is the primary key
-- cid - an integer which is a foreign key reference to the category table
-- name - a varchar of maximum length 255 which cannot be null
-- received - a date type (you can read about it here http://dev.mysql.com/doc/refman/5.0/en/datetime.html)
-- isbroken - a boolean
DROP TABLE IF EXISTS device;

CREATE TABLE device
(
id int AUTO_INCREMENT,
cid int,
name_d varchar(255) NOT NULL,
received DATETIME,
isbroken BOOL,
CONSTRAINT fk_cid FOREIGN KEY (cid) REFERENCES category (id),
PRIMARY KEY (id)
);


-- Create a table called os_support with the following properties, this is a table representing a many-to-many relationship
-- between devices and operating systems:
-- did - an integer which is a foreign key reference to device
-- osid - an integer which is a foreign key reference to operating_system
-- notes - a text type
-- The primary key is a combination of did and osid
DROP TABLE IF EXISTS os_support;

CREATE TABLE os_support
(
did int,
osid int,
notes text,
PRIMARY KEY (did, osid),
CONSTRAINT fk_did FOREIGN KEY (did) REFERENCES device (id),
CONSTRAINT fk_osid FOREIGN KEY (osid) REFERENCES operating_system (id)
);


-- insert the following into the category table:
-- name: phone
-- subcategory: NULL
INSERT INTO category (name, subcategory)
VALUES ('phone', 'NULL');
-- name: phone
-- subcategory: maybe a tablet?
INSERT INTO category (name, subcategory)
VALUES ('phone', 'maybe a tablet?');

-- name: tablet
-- subcategory: but kind of a laptop
INSERT INTO category (name, subcategory)
VALUES ('tablet', 'but kind of a laptop');

-- name: tablet
-- subcategory: ereader
INSERT INTO category (name, subcategory)
VALUES ('tablet', 'ereader');

-- insert the folowing into the operating_system table:
-- name: Android
-- version: 1.0
INSERT INTO operating_system (name, version)
VALUES ('Andriod', '1.0');

-- name: Android
-- version: 2.0
INSERT INTO operating_system (name, version)
VALUES ('Andriod', '2.0');

-- name: iOS
-- version: 4.0
INSERT INTO operating_system (name, version)
VALUES ('iOS', '4.0');

-- insert the following devices instances into the device table (you should use a subquery to set up foriegn keys referecnes, no hard coded numbers):
-- cid - reference to name: phone subcategory: 'maybe a tablet'
-- name - Samsung Atlas
-- received - 1/2/1970
-- isbroken - True
INSERT INTO device (cid, name_d, received, isbroken) 
VALUES ((SELECT id FROM category WHERE subcategory  = 'maybe a tablet?'),  'Samsung Atlas', '1/2/1970', 'True');

-- cid - reference to name: phone subcategory: NULL
-- name - Nokia
-- received - 5/6/1999
-- isbroken - False
INSERT INTO device (cid, name_d, received, isbroken) VALUES ((SELECT id FROM category WHERE subcategory  = 'NULL'), 'Nokia', '5/6/1999', 'False');
-- cid - reference to name: tablet subcategory: ereader
-- name - jPad
-- received - 11/18/2005
-- isbroken - False
INSERT INTO device (cid, name_d, received, isbroken) VALUES ((SELECT id FROM category WHERE subcategory  = 'ereader'), 'jPad', '11/18/2005', 'False');

-- insert the following into the os_support table using subqueries to look up data as needed:
-- device: Samsung Atlas
-- os: Android 1.0
-- notes: Works poorly
INSERT INTO os_support(did, osid, notes)
SELECT id, id, 'Works poorly' FROM operating_system WHERE name = 'Android' AND version = '1.0';

-- device: Samsung Atlas
-- os: Android 2.0
-- notes: 
INSERT INTO os_support(did, osid, notes)
SELECT id, id, ' ' FROM operating_system WHERE name = 'Android' AND version = '2.0';

-- device: jPad
-- os: iOS 4.0
-- notes: 
INSERT INTO os_support(did, osid, notes)
SELECT id, id, ' ' FROM operating_system WHERE name = 'jPad' AND version = 'iOS 4.0';

