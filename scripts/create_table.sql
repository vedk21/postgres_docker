create table if not exists employee (id int, dept char(5), salary int);

truncate table employee;

insert into employee (id, dept, salary)
values ('1', 'SALES', '100');

insert into employee (id, dept, salary)
values ('2', 'IT', '200');

insert into employee (id, dept, salary)
values ('3', 'ADMIN', '300');

insert into employee (id, dept, salary)
values ('4', 'SALES', '200');

insert into employee (id, dept, salary)
values ('5', 'ADMIN', '300');

-- CREATE TABLE statement
CREATE TABLE if not exists orders (
  cust_id INTEGER,
  order_id INTEGER,
  order_ts TIMESTAMP,
  region VARCHAR(50)
);

INSERT INTO orders (cust_id, order_id, order_ts, region)
VALUES (1, 101, '2023-01-15 10:00:00', 'North'),
  (2, 102, '2023-01-15 11:30:00', 'South'),
  (3, 103, '2023-01-15 12:45:00', 'East'),
  (4, 104, '2023-01-15 14:00:00', 'West'),
  (5, 105, '2023-01-15 15:15:00', 'Central'),
  (1, 101, '2023-01-15 16:30:00', 'North'),
  -- Duplicate cust_id, order_id
  (2, 106, '2023-01-16 09:00:00', 'South'),
  (3, 107, '2023-01-16 10:15:00', 'East'),
  (4, 108, '2023-01-16 11:30:00', 'West'),
  (5, 109, '2023-01-16 12:45:00', 'Central'),
  (1, 110, '2023-01-16 14:00:00', 'North'),
  (2, 102, '2023-01-16 15:15:00', 'South'),
  -- Duplicate cust_id, order_id
  (3, 103, '2023-01-17 10:00:00', 'East'),
  -- Duplicate cust_id, order_id
  (4, 111, '2023-01-17 11:30:00', 'West'),
  (5, 112, '2023-01-17 12:45:00', 'Central'),
  (1, 113, '2023-01-17 14:00:00', 'North'),
  (2, 114, '2023-01-17 15:15:00', 'South'),
  (3, 115, '2023-01-18 09:00:00', 'East'),
  (4, 104, '2023-01-18 10:15:00', 'West'),
  -- Duplicate cust_id, order_id
  (5, 105, '2023-01-18 11:30:00', 'Central'),
  -- Duplicate cust_id, order_id
  (1, 116, '2023-01-18 12:45:00', 'North'),
  (2, 117, '2023-01-18 14:00:00', 'South'),
  (3, 118, '2023-01-19 10:00:00', 'East'),
  (4, 119, '2023-01-19 11:30:00', 'West'),
  (5, 120, '2023-01-19 12:45:00', 'Central');