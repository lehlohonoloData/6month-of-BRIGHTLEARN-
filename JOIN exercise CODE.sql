-- 1. Create Catalog
CREATE CATALOG IF NOT EXISTS brightlearn_catalog;
USE CATALOG brightlearn_catalog;

-- 2. Create Schema
CREATE SCHEMA IF NOT EXISTS brightlearn_schema;
USE SCHEMA brightlearn_schema;

-- 3. Create Tables
CREATE TABLE IF NOT EXISTS users (
    user_id INT,
    user_name STRING,
    country STRING
);

CREATE TABLE IF NOT EXISTS plans (
    plan_id INT,
    plan_name STRING,
    monthly_price INT
);

CREATE TABLE IF NOT EXISTS subscriptions (
    subscription_id INT,
    user_id INT,
    plan_id INT,
    start_date DATE
);

CREATE TABLE IF NOT EXISTS shows (
    show_id INT,
    show_title STRING,
    genre STRING
);

CREATE TABLE IF NOT EXISTS viewing_sessions (
    session_id INT,
    user_id INT,
    show_id INT,
    watch_minutes INT
);

-- 4. Insert Data (Populate Tables)
INSERT INTO users VALUES
(1, 'Nomvula', 'Johannesburg'),
(2, 'David', 'Cape Town'),
(3, 'Anele', 'Durban'),
(4, 'Kabelo', 'Pretoria'),
(5, 'Lerato', 'Port Elizabeth');

INSERT INTO plans VALUES
(10, 'Basic', 79),
(11, 'Standard', 129),
(12, 'Premium', 199),
(13, 'Family', 249),
(14, 'Mobile', 59);

INSERT INTO subscriptions VALUES
(501, 1, 10, '2026-01-15'),
(502, 2, 11, '2026-02-01'),
(503, 1, 12, '2026-03-10'),
(504, 6, 11, '2026-03-20'),
(505, 3, 13, '2026-04-05');

INSERT INTO shows VALUES
(701, 'Comedy Hour', 'Comedy'),
(702, 'Crime Time', 'Drama'),
(703, 'Tech Tales', 'Documentary'),
(704, 'Cooking Lab', 'Lifestyle'),
(706, 'Wild Earth', 'Documentary');

INSERT INTO viewing_sessions VALUES
(901, 1, 701, 45),
(902, 2, 703, 30),
(903, 1, 702, 60),
(904, 7, 701, 20),
(905, 3, 705, 90);


-- PART A: INNER JOIN

-- Question 1
--show every user who has a subscription.Match users to subscriptionssss
SELECT 
    u.user_id, 
    u.user_name, 
    s.subscription_id, 
    s.start_date
FROM users u
INNER JOIN subscriptions s ON u.user_id = s.user_id;

-- Question 2
--show every subscription with its matching plan name and monthly price
SELECT 
    s.subscription_id, 
    s.user_id, 
    p.plan_name, 
    p.monthly_price
FROM subscriptions s
INNER JOIN plans p ON s.plan_id = p.plan_id;

-- Question 3
--show every viewing session that has a matching show.Include the show title and genre

SELECT 
    v.session_id, 
    v.user_id, 
    s.show_title, 
    s.genre, 
    v.watch_minutes
FROM viewing_sessions v
INNER JOIN shows s ON v.show_id = s.show_id;

-- Question 4
---Show every viewing session with the user who watched it.Only show session with a matching user
SELECT 
    u.user_name, 
    u.country, 
    v.session_id, 
    v.show_id, 
    v.watch_minutes
FROM viewing_sessions v
INNER JOIN users u ON v.user_id = u.user_id;



-- Question 5
--Show users along with their subcriptions, the plan name, and the price .Use only users who have both a subscription and a valid plan
 
SELECT 
    u.user_name, 
    u.country, 
    p.plan_name, 
    p.monthly_price, 
    s.start_date
FROM users u
INNER JOIN subscriptions s ON u.user_id = s.user_id
INNER JOIN plans p ON s.plan_id = p.plan_id;

-- PART B: LEFT JOIN

-- Question 6
--show every user and any subscriptions they have.Uses without subscriptions must stil appear

SELECT 
    u.user_id, 
    u.user_name, 
    s.subscription_id, 
    s.start_date
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id;

-- Question 7
--show every plan and the subscriptions on it.Plans with no subscribers must stil appear

SELECT 
    p.plan_id, 
    p.plan_name, 
    s.subscription_id, 
    s.user_id
FROM plans p
LEFT JOIN subscriptions s ON p.plan_id = s.plan_id;

-- Question 8
--show every show and any viewing sessions on it.Shows that were never watched must still appear

SELECT 
    s.show_id, 
    s.show_title, 
    v.session_id, 
    v.watch_minutes
FROM shows s
LEFT JOIN viewing_sessions v ON s.show_id = v.show_id;

-- Question 9
--show every viewing session and the user who watched it.Session referencing users that do not exist must still appear
--(with user details)---

SELECT 
    v.session_id, 
    v.show_id, 
    v.watch_minutes, 
    u.user_id, 
    u.user_name
FROM viewing_sessions v
LEFT JOIN users u ON v.user_id = u.user_id;

-- Question 10
--show every user, the plan they are on (if any ),and the monthly price. Users without a subscription must still appear .

SELECT 
    u.user_name, 
    u.country, 
    p.plan_name, 
    p.monthly_price
FROM users u
LEFT JOIN subscriptions s ON u.user_id = s.user_id
LEFT JOIN plans p ON s.plan_id = p.plan_id;


-- PART C: FULL OUTER JOIN

-- Question 11
--show every user and every subscription, including users without subscriptions AND subscriptions referencing that do not exist----

SELECT 
    u.user_id, 
    u.user_name, 
    s.subscription_id, 
    s.start_date
FROM users u
FULL OUTER JOIN subscriptions s ON u.user_id = s.user_id;

-- Question 12
--show every plan and every subscription, including plans without subscribers AND any subscriptions referencing plans that do not----

SELECT 
    p.plan_id, 
    p.plan_name, 
    s.subscription_id, 
    s.user_id
FROM plans p
FULL OUTER JOIN subscriptions s ON p.plan_id = s.plan_id;

-- Question 13
--show every show and every viewing session, including shows that shows were never watched AND sessions referencing shows that do not exist----

SELECT 
    s.show_id, 
    s.show_title, 
    v.session_id, 
    v.watch_minutes
FROM shows s
FULL OUTER JOIN viewing_sessions v ON s.show_id = v.show_id;

-- Question 14
--show every user and every viewing session, including users with no sessions AND sessions referencing users that do not exist----


SELECT 
    u.user_id, 
    u.user_name, 
    v.session_id, 
    v.show_id, 
    v.watch_minutes
FROM users u
FULL OUTER JOIN viewing_sessions v ON u.user_id = v.user_id;

-- Queston  15 
--show every user, every subscription, and every plan in one query -using FULL OUTER JOIN throughout.This is the hardest question --get all gaps visible at once


SELECT 
    u.user_id, 
    u.user_name, 
    s.subscription_id, 
    p.plan_id, 
    p.plan_name
FROM users u
FULL OUTER JOIN subscriptions s ON u.user_id = s.user_id
FULL OUTER JOIN plans p ON s.plan_id = p.plan_id;
