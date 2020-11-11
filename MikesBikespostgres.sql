DROP TABLE IF EXISTS SuppliedItems,addresses,customers,manufacturer,SUPPLIER, bikes, inventory
CREATE TABLE addresses (
  id serial PRIMARY KEY,
  street_one varchar(255),
  street_two varchar(255),
  street_three varchar(255),
  city varchar(255),
  state varchar(2),
  zip varchar(10));
  
CREATE TABLE customers (
  id serial primary key,
  first_name varchar(255),
  last_name varchar(255),
  address_id int REFERENCES addresses(id) 
  );
  
CREATE TABLE manufacturer(
  manufacturerID integer NOT NULL,
  name varchar(255),
  CONSTRAINT manufacturer_pk PRIMARY KEY (manufacturerID),
  address_id int REFERENCES addresses(id),
  supplier_id int
);
CREATE TABLE supplier (
  supplier_id integer NOT NULL,
  name varchar(30),
  phone_number varchar(20) not null unique,
  email varchar(320),
  address_id int REFERENCES addresses(id),
  manufacturer_id int,
  CONSTRAINT supplier_pk PRIMARY KEY (supplier_id)
);
ALTER TABLE manufacturer
    ADD CONSTRAINT fk_supplier FOREIGN KEY (supplier_id) REFERENCES supplier (supplier_id);
ALTER TABLE supplier
    ADD CONSTRAINT fk_manufacturer FOREIGN KEY (manufacturer_id) REFERENCES manufacturer(manufacturerID);

CREATE TABLE bikes (
  SKU integer NOT NULL,
  brand varchar(250),
  color varchar(30),
  model smallint,
  price decimal,
  CONSTRAINT bike_pk PRIMARY KEY (SKU),
  manufacturer_id int REFERENCES manufacturer(manufacturerID),
  supplier_id int REFERENCES supplier(supplier_id)
); 

CREATE TABLE SuppliedItems (
  available_items varchar(255),
  supplier_id int REFERENCES supplier(supplier_id),
  manufacturer_id int REFERENCES manufacturer(manufacturerID),
  SKU int REFERENCES bikes(SKU)
);


CREATE TABLE inventory (
  SKU int REFERENCES bikes(SKU),
  name varchar(50),
  description varchar(254),
  price decimal (10,2),
  manufacturer_id int REFERENCES manufacturer(manufacturerID),
  supplier_id int REFERENCES supplier(supplier_id)
); 

SELECT supplier.supplier_id, manufacturer.manufacturerID,
FROM supplier
INNER JOIN manufacturer ON supplier.supplier_id = manufacturer.supplier_id;

SELECT supplier.supplier_id, inventory.SKU, inventory.name 
FROM supplier
INNER JOIN inventory ON supplier.supplier_id = inventory.supplier_id;

