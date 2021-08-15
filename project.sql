DROP SCHEMA IF EXISTS workspace CASCADE;
CREATE SCHEMA workspace;

drop table workspace.natural_person;
create table workspace.natural_person
(
    person_id       integer   not null,
    passport_series text      not null,
    passport_num    text      not null,
    last_nm         text      not null,
    first_nm        text      not null,
    middle_nm       text,
    birth_dt        date      not null,
    valid_from_dttm timestamp not null default (current_timestamp),
    valid_to_dttm   timestamp not null default (to_date('01.01.2100 23:59:59', 'DD.MM.YYYY HH24:MI:SS')),

    constraint pk_key_natural_person primary key (person_id, valid_from_dttm)
);

create table workspace.juridical_person
(
    company_nm      text      not null,
    owner_id        integer   not null,
    valid_from_dttm timestamp not null default (current_timestamp),
    valid_to_dttm   timestamp not null default (to_date('01.01.2100 23:59:59', 'DD.MM.YYYY HH24:MI:SS')),

    constraint pk_key_juridical_person primary key (company_nm, valid_from_dttm)
);

create table workspace.delivery
(
    deliver_id       integer unique primary key,
    company_owner_nm text not null,
    deliver_dt       date,
    deliver_desc     text
);


create table workspace.delivery_canteen_distribution
(
    deliver_id   integer not null,
    canteen_id   integer not null,
    deliver_desc text,

    constraint pk_key_delivery_canteen_distribution primary key (deliver_id, canteen_id)

);

create table workspace.canteen
(
    canteen_id  integer unique primary key,
    canteen_nm  text,
    company_nm  text    not null,
    building_nm text    not null,
    floor_num   integer not null
);


create table workspace.employee
(
    employee_id     integer   not null,
    person_id       integer   not null,
    canteen_id      integer   not null,
    status_desc     text      not null,
    valid_from_dttm timestamp not null default (current_timestamp),
    valid_to_dttm   timestamp not null default (to_date('01.01.2100 23:59:59', 'DD.MM.YYYY HH24:MI:SS')),

    constraint pk_key_employee primary key (employee_id, valid_from_dttm)
);
drop table workspace.dish;

create table workspace.dish
(
    dish_id          integer unique primary key,
    canteen_id       integer          not null,
    is_now_in_menu   bool,
    dish_nm          text             not null,
    hot_flg          bool,
    price_amt        double precision not null,
    calories_amt     integer,
    weight_amt       integer,
    description_desc text
);

drop table workspace.dish_order;

create table workspace.dish_order
(
    dish_id      integer not null,
    order_id     integer not null,
    quantity_num integer not null,
    constraint pk_key_dish_order primary key (dish_id, order_id)

);

create table workspace.order
(
    order_id     integer unique primary key,
    canteen_id   integer          not null,
    employee_id  integer,
    payment_amt  double precision not null,
    discount_amt double precision not null default (0),
    order_dttm   timestamp        not null default (current_timestamp)
);


alter table workspace.order
    add check (discount_amt between 0 and 1);


create table workspace.order_payment
(
    transaction_id   integer unique primary key,
    order_id         integer          not null,
    payment_amt      double precision not null,
    method_desc      text             not null default ('наличные'),
    transaction_dttm timestamp        not null default (current_timestamp)
);

alter table workspace.order_payment
    add check (method_desc = 'наличные' or method_desc = 'перевод' or method_desc = 'карта');


INSERT INTO workspace.natural_person
VALUES (1, 'HB', '2941871', 'Печёнкин', 'Александр', 'Алексеевич', '2002-04-30');
INSERT INTO workspace.natural_person
VALUES (2, 'HB', '2281337', 'Kek', 'Lol', 'Arbedol', '1999-01-25',
        '2016-06-22 16:10:25', '2026-06-22 19:10:25');
INSERT INTO workspace.natural_person
VALUES (3, 'HB', '1291239', 'Волос', 'Алексей', 'Александрович', '1975-06-11',
        '2007-03-14 12:43:22', '2018-03-14 12:43:22');
INSERT INTO workspace.natural_person
VALUES (4, 'HB', '5243243', 'Ава', 'Давы', NULL, '1992-03-12',
        '2012-08-12 13:54:31', '2022-08-12 13:54:31');
INSERT INTO workspace.natural_person
VALUES (5, 'HB', '1111111', 'aldadl', 'faawd', 'adads', '2000-09-24',
        '2009-03-12 09:58:58', '2019-03-12 09:58:58');

INSERT INTO workspace.natural_person
VALUES (3, 'HB', '1291239', 'Волос', 'Алексей', 'Александрович', '1975-06-11',
        '2018-03-21 14:21:12', '2028-03-21 14:21:12');

INSERT INTO workspace.natural_person
VALUES (5, 'HB', '1212122', 'gksfl', 'ss', 'qq', '1955-05-30',
        '2020-02-26 09:32:33');

INSERT INTO workspace.natural_person
VALUES (6, 'HB', '4444444', 'Николаенко', 'Илья', NULL, '1996-05-31',
        '2012-08-12 13:54:31', '2022-08-12 13:54:31');

INSERT INTO workspace.natural_person
VALUES (7, 'HB', '7777777', 'seven', 'day', NULL, '2015-07-14',
        '2016-09-12 11:03:12', '2026-09-12 11:03:12');

INSERT INTO workspace.natural_person
VALUES (8, 'HB', '1234567', 'gg', 'wp', 'ez', '1968-04-02',
        '2013-10-14 15:22:46', '2028-08-12 13:54:31');

INSERT INTO workspace.natural_person
VALUES (11, 'HB', '3193293', 'worker1', 'w', NULL, '1990-04-02',
        '2013-10-14 15:22:46', '2028-08-12 13:54:31');

INSERT INTO workspace.natural_person
VALUES (12, 'HB', '1020123', 'worker2', 'w', NULL, '1995-04-02',
        '2011-12-19 15:01:00', '2024-08-12 10:30:30');

INSERT INTO workspace.natural_person
VALUES (13, 'HB', '2325271', 'worker3', 'w', NULL, '1988-01-05',
        '2015-12-23 13:44:00', '2025-04-19 10:00:00');

INSERT INTO workspace.natural_person
VALUES (14, 'HB', '1343222', 'worker4', 'w', NULL, '1999-02-18',
        '2018-09-30 10:00:00', '2027-08-22 10:00:00');

INSERT INTO workspace.natural_person
VALUES (15, 'HB', '9293239', 'worker5', 'w', NULL, '1980-08-10',
        '2011-11-23 09:00:00', '2023-12-12 10:00:00');

COPY workspace.juridical_person (company_nm, owner_id, valid_from_dttm, valid_to_dttm)
    FROM '/home/mrkakek/juridical.csv' with
    DELIMITER ',' CSV HEADER;

INSERT INTO workspace.delivery
VALUES (1, 'Delivery club', '2020-10-14 15:20:00', 'description');
INSERT INTO workspace.delivery
VALUES (2, 'Delivery club', '2020-10-17 12:20:00', 'description2');
INSERT INTO workspace.delivery
VALUES (3, 'Delivery club', '2020-10-04 11:30:00', 'description3');
INSERT INTO workspace.delivery
VALUES (4, 'Delivery club', '2020-10-25 14:30:00', 'description4');
INSERT INTO workspace.delivery
VALUES (5, 'Delivery club', '2020-11-01 12:25:00', 'description5');
INSERT INTO workspace.delivery
VALUES (6, 'Flex', '2020-10-28 11:25:00', 'description6');
INSERT INTO workspace.delivery
VALUES (7, 'Flex', '2020-10-10 10:00:00', 'description7');
INSERT INTO workspace.delivery
VALUES (8, 'Flex', '2020-10-06 13:15:00', 'description8');
INSERT INTO workspace.delivery
VALUES (9, 'Flex', '2020-09-30 12:00:00', 'description9');
INSERT INTO workspace.delivery
VALUES (10, 'Flex', '2020-09-25 09:00:00', 'description10');


INSERT INTO workspace.canteen
VALUES (1, 'Тройка', 'Sasha’s company', '3-е общежитие', 1);
INSERT INTO workspace.canteen
VALUES (2, 'Столовая №1', 'Sasha’s company', 'КСП', 3);
INSERT INTO workspace.canteen
VALUES (3, 'Радуга', 'Next Gen', 'КПМ', 2);
INSERT INTO workspace.canteen
VALUES (4, 'От души', 'Next Gen', 'ГК', 2);
INSERT INTO workspace.canteen
VALUES (5, 'График синуса', 'Next Gen', 'Арктика', 0);
INSERT INTO workspace.canteen
VALUES (6, 'Рай студента', 'Extremum', '6-е общежитие', 1);
INSERT INTO workspace.canteen
VALUES (7, 'LOL', 'KEK', ' Цифра', 4);


INSERT INTO workspace.delivery_canteen_distribution
VALUES (1, 1, 'картошка');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (1, 2, 'помидоры');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (1, 5, 'телятина');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (1, 6, 'макароны и говядина');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (6, 3, 'макароны, перцы и соль');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (6, 4, 'мука и яйца');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (6, 1, 'гречка');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (4, 3, 'хлеб');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (4, 6, 'сок');
INSERT INTO workspace.delivery_canteen_distribution
VALUES (4, 4, 'лимонад, свинина, кетчуп');


INSERT INTO workspace.employee
VALUES (1, 11, 1, 'повар', '2013-10-20 13:00:00', '2018-08-11 10:00:00');
INSERT INTO workspace.employee
VALUES (1, 11, 1, 'старший повар', '2018-08-12 10:00:00', '2023-08-13 10:00:00');
INSERT INTO workspace.employee
VALUES (2, 12, 3, 'управляющий', '2017-01-30 09:00:00', '2023-01-30 10:00:00');
INSERT INTO workspace.employee
VALUES (3, 13, 6, 'повар', '2016-04-15 10:00:00', '2022-04-15 10:00:00');
INSERT INTO workspace.employee
VALUES (4, 14, 4, 'уборщик', '2019-02-19 10:00:00', '2024-02-20 10:00:00');
INSERT INTO workspace.employee
VALUES (5, 2, 4, 'старший повар', '2013-05-23 11:00:00', '2015-07-22 10:00:00');
INSERT INTO workspace.employee
VALUES (6, 2, 2, 'заместитель директора', '2015-07-25 10:00:00', '2021-07-22 10:00:00');
INSERT INTO workspace.employee
VALUES (7, 15, 2, 'повар', '2016-01-20 10:00:00', '2018-05-15 12:00:00');

COPY workspace.dish
    FROM '/home/mrkakek/dishes.csv' with
    DELIMITER ',' CSV HEADER;


INSERT INTO workspace.order
VALUES (1, 1, null, 75, 0);
INSERT INTO workspace.order
VALUES (2, 1, 1, 180, 0);
INSERT INTO workspace.order
VALUES (3, 1, null, 230, 0.05);
INSERT INTO workspace.order
VALUES (4, 2, null, 50, 0);
INSERT INTO workspace.order
VALUES (5, 2, null, 170, 0);
INSERT INTO workspace.order
VALUES (6, 2, 7, 200, 0.05);
INSERT INTO workspace.order
VALUES (7, 1, null, 195, 0);
INSERT INTO workspace.order
VALUES (8, 4, null, 195, 0.02);
INSERT INTO workspace.order
VALUES (9, 4, null, 190, 0.02);
INSERT INTO workspace.order
VALUES (10, 5, null, 170, 0);
INSERT INTO workspace.order
VALUES (11, 4, null, 190, 0.02);
INSERT INTO workspace.order
VALUES (12, 6, 3, 380, 0.07);


INSERT INTO workspace.dish_order
VALUES (1, 1, 1);
INSERT INTO workspace.dish_order
VALUES (9, 1, 1);
INSERT INTO workspace.dish_order
VALUES (9, 2, 2);
INSERT INTO workspace.dish_order
VALUES (3, 2, 1);
INSERT INTO workspace.dish_order
VALUES (3, 3, 1);
INSERT INTO workspace.dish_order
VALUES (4, 3, 1);
INSERT INTO workspace.dish_order
VALUES (9, 3, 1);
INSERT INTO workspace.dish_order
VALUES (9, 7, 1);
INSERT INTO workspace.dish_order
VALUES (2, 7, 1);
INSERT INTO workspace.dish_order
VALUES (1, 7, 1);
INSERT INTO workspace.dish_order
VALUES (11, 8, 1);
INSERT INTO workspace.dish_order
VALUES (12, 8, 1);
INSERT INTO workspace.dish_order
VALUES (13, 8, 1);
INSERT INTO workspace.dish_order
VALUES (11, 9, 1);
INSERT INTO workspace.dish_order
VALUES (12, 9, 1);
INSERT INTO workspace.dish_order
VALUES (10, 9, 1);
INSERT INTO workspace.dish_order
VALUES (14, 10, 1);
INSERT INTO workspace.dish_order
VALUES (15, 10, 1);
INSERT INTO workspace.dish_order
VALUES (19, 10, 1);
INSERT INTO workspace.dish_order
VALUES (10, 11, 2);
INSERT INTO workspace.dish_order
VALUES (12, 11, 2);
INSERT INTO workspace.dish_order
VALUES (13, 11, 2);


INSERT INTO workspace.order_payment
VALUES (1, 1, 75);
INSERT INTO workspace.order_payment
VALUES (2, 2, 180, 'карта');
INSERT INTO workspace.order_payment
VALUES (3, 12, 180, 'карта');
INSERT INTO workspace.order_payment
VALUES (4, 12, 200, 'наличные');
INSERT INTO workspace.order_payment
VALUES (5, 3, 218.5, 'карта');
INSERT INTO workspace.order_payment
VALUES (6, 7, 195, 'перевод');
INSERT INTO workspace.order_payment
VALUES (7, 10, 190, 'перевод');
INSERT INTO workspace.order_payment
VALUES (8, 5, 170, 'наличные');
INSERT INTO workspace.order_payment
VALUES (9, 6, 200, 'карта');
INSERT INTO workspace.order_payment
VALUES (10, 11, 186.2, 'карта');
INSERT INTO workspace.order_payment
VALUES (11, 8, 100, 'наличные');
INSERT INTO workspace.order_payment
VALUES (12, 8, 100, 'перевод');
INSERT INTO workspace.order_payment
VALUES (13, 4, 50, 'карта');
INSERT INTO workspace.order_payment
VALUES (14, 9, 186.2, 'наличные');

create or replace view persons as
select t.last_nm,
       t.first_nm,
       t.middle_nm,
       t.birth_dt,
       t.passport_series,
       regexp_replace(t.passport_num, '.{4}$', '****')
from workspace.natural_person t;

select *
from persons;

create or replace view companies as
select t.company_nm
from workspace.juridical_person t;


create or replace view deliveries as
select t.company_owner_nm company_name,
       t.deliver_dt       date,
       t.deliver_desc     discription
from workspace.delivery t;


create or replace view canteens as
select t.canteen_nm  canteen_name,
       t.company_nm  company_name,
       t.building_nm place,
       t.floor_num   floor
from workspace.canteen t;


create or replace view employees as
select d.last_nm,
       d.first_nm,
       d.middle_nm,
       c.canteen_id,
       t.status_desc,
       t.valid_to_dttm,
       t.valid_from_dttm
from workspace.employee t
         inner join workspace.natural_person d on t.person_id = d.person_id
         inner join workspace.canteen c on t.canteen_id = c.canteen_id;


create or replace view dishes as
select c.canteen_nm,
       t.dish_nm dish_name,
       t.is_now_in_menu,
       t.hot_flg,
       t.price_amt,
       t.calories_amt,
       t.weight_amt,
       t.description_desc
from workspace.dish t
         inner join workspace.canteen c on t.canteen_id = c.canteen_id;


create or replace view orders as
select c.canteen_nm,
       t.order_id,
       t.order_dttm order_time,
       t.payment_amt,
       t.discount_amt
from workspace.order t
         inner join workspace.canteen c on t.canteen_id = c.canteen_id;

create or replace view payments as
select t.order_id, t.payment_amt, t.method_desc, t.transaction_dttm
from workspace.order_payment t;

create index on workspace.natural_person (birth_dt);

create index on workspace.juridical_person (valid_to_dttm);

create index on workspace.delivery (deliver_dt);

create index on workspace.canteen (building_nm);

create index on workspace.dish (price_amt);

create index on workspace.order (order_dttm);

create or replace view company_canteen_statistics as
select comp.company_nm, count(c.canteen_id) as number_of_canteens
from workspace.juridical_person comp
         inner join workspace.canteen c on comp.company_nm = c.company_nm
where comp.valid_to_dttm > current_timestamp
group by comp.company_nm;


select *
from company_canteen_statistics;

create or replace view dish_statistics as
select dish.dish_id, dish.dish_nm, sum(dish_order.quantity_num)
from workspace.dish dish
         inner join workspace.dish_order dish_order on dish.dish_id = dish_order.dish_id
         inner join workspace.order ord on dish_order.order_id = ord.order_id
where ord.order_dttm > current_timestamp - interval '7 DAYS'
group by dish.dish_id;

select *
from dish_statistics;

create or replace view canteen_dish_statistics as
select can.canteen_nm, count(dish.dish_id)
from workspace.canteen can
         inner join workspace.dish dish on can.canteen_id = dish.canteen_id
where dish.is_now_in_menu = True
group by can.canteen_id;

select *
from canteen_dish_statistics;

create or replace function workspace.change()
    returns trigger as
$$
begin
    update workspace.canteen
    set company_nm = new.company_nm
    where workspace.canteen.company_nm = old.company_nm;
    return new;
end;
$$ language plpgsql;


create trigger before_insert_by_wares_order_client
    before update
    on workspace.juridical_person
    for each row
execute procedure workspace.change();

create or replace function workspace.set_pay()
    returns trigger as
$$
declare
    sum_pay  integer;
    need_sum integer;

begin

    select sum(trans.payment_amt)
    into sum_pay
    from workspace.order_payment trans
    where trans.order_id = new.order_id
    group by trans.order_id;

    select ord.payment_amt * (1 - ord.discount_amt)
    into need_sum
    from workspace.order ord
    where ord.order_id = new.order_id;

    if (sum_pay >= need_sum) then
        update workspace.order set is_payed = True where order_id = new.order_id;
    end if;
    return new;
end;
$$ language plpgsql;

drop trigger make_payment on workspace.order_payment;

create trigger make_payment
    after insert
    on workspace.order_payment
    for each row
execute procedure workspace.set_pay();



alter table workspace.order
    add is_payed bool default (False);
UPDATE workspace."order"
SET canteen_id   = 1,
    employee_id  = null,
    payment_amt  = 75,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:21:09.852995',
    is_payed     = true
WHERE order_id = 1;
UPDATE workspace."order"
SET canteen_id   = 1,
    employee_id  = 1,
    payment_amt  = 180,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:22:38.689115',
    is_payed     = true
WHERE order_id = 2;
UPDATE workspace."order"
SET canteen_id   = 1,
    employee_id  = null,
    payment_amt  = 230,
    discount_amt = 0.05,
    order_dttm   = '2021-05-07 09:27:55.087868',
    is_payed     = true
WHERE order_id = 3;
UPDATE workspace."order"
SET canteen_id   = 2,
    employee_id  = null,
    payment_amt  = 50,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:27:55.095259',
    is_payed     = true
WHERE order_id = 4;
UPDATE workspace."order"
SET canteen_id   = 2,
    employee_id  = null,
    payment_amt  = 170,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:30:00.467416',
    is_payed     = true
WHERE order_id = 5;
UPDATE workspace."order"
SET canteen_id   = 4,
    employee_id  = null,
    payment_amt  = 190,
    discount_amt = 0.02,
    order_dttm   = '2021-05-07 09:32:12.534893',
    is_payed     = true
WHERE order_id = 9;
UPDATE workspace."order"
SET canteen_id   = 2,
    employee_id  = 7,
    payment_amt  = 200,
    discount_amt = 0.05,
    order_dttm   = '2021-05-07 09:32:20.853775',
    is_payed     = true
WHERE order_id = 6;
UPDATE workspace."order"
SET canteen_id   = 6,
    employee_id  = 3,
    payment_amt  = 380,
    discount_amt = 0.07,
    order_dttm   = '2021-05-07 09:34:09.735295',
    is_payed     = true
WHERE order_id = 12;
UPDATE workspace."order"
SET canteen_id   = 5,
    employee_id  = null,
    payment_amt  = 170,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:34:21.164241',
    is_payed     = true
WHERE order_id = 10;
UPDATE workspace."order"
SET canteen_id   = 1,
    employee_id  = null,
    payment_amt  = 195,
    discount_amt = 0,
    order_dttm   = '2021-05-07 09:36:59.965534',
    is_payed     = true
WHERE order_id = 7;
UPDATE workspace."order"
SET canteen_id   = 4,
    employee_id  = null,
    payment_amt  = 195,
    discount_amt = 0.02,
    order_dttm   = '2021-05-07 09:26:34.579058',
    is_payed     = true
WHERE order_id = 8;
UPDATE workspace."order"
SET canteen_id   = 4,
    employee_id  = null,
    payment_amt  = 310,
    discount_amt = 0.02,
    order_dttm   = '2021-05-07 09:37:18.561866',
    is_payed     = true
WHERE order_id = 11;


INSERT INTO workspace.order
VALUES (13, 1, null, 300, 0.05);
INSERT INTO workspace.dish_order
VALUES (9, 13, 2);
INSERT INTO workspace.dish_order
VALUES (2, 13, 1);
INSERT INTO workspace.dish_order
VALUES (3, 13, 1);
insert into workspace.order_payment
values (20, 13, 200, 'наличные');
insert into workspace.order_payment
values (21, 13, 120, 'карта');



update workspace.juridical_person
set company_nm = 'Best ever'
where owner_id = 3
  and valid_to_dttm > current_timestamp;


delete
from workspace.dish
where canteen_id = 5
  and dish_nm = 'котлета';

update workspace.dish
set is_now_in_menu = False
where canteen_id = 4
  and dish_nm = 'борщ';

delete
from workspace.canteen
where canteen_nm = 'LOL';

update workspace.employee
set status_desc = 'старший повар'
where (select nat.person_id from workspace.natural_person nat where nat.last_nm = 'worker3' and nat.first_nm = 'w') =
      person_id;

select order_id,
       transaction_dttm,
       payment_amt,
       lead(payment_amt) over (partition by order_id order by transaction_dttm asc) as last_pay
from workspace.order_payment op;


select order_id,
       transaction_dttm,
       payment_amt,
       sum(payment_amt) over (partition by order_id order by transaction_dttm) as cumulative_pays
from workspace.order_payment op;

select *
from workspace."order";

INSERT INTO workspace.order
VALUES (25, 4, null, 280, 0);
INSERT INTO workspace.order
VALUES (30, 6, 3, 320, 0.05);

insert into workspace.order_payment
values (25, 25, 300, 'наличные');

insert into workspace.order_payment
values (29, 30, 120, 'карта');
insert into workspace.order_payment
values (30, 30, 200, 'карта');

with helpers as (
    select *, ord.order_dttm::date days
    from workspace.order ord
)
select last_value(order_id) over (partition by canteen_id order by helpers.days RANGE BETWEEN
            UNBOUNDED PRECEDING AND
            UNBOUNDED FOLLOWING) lst,
       helpers.order_dttm,
       helpers.order_id,
       helpers.days,
       helpers.canteen_id,
       helpers.payment_amt
from helpers;

select order_id,
       transaction_id,
       transaction_dttm,
       payment_amt,
       lag(payment_amt) over (partition by order_id order by transaction_dttm asc) as last_pay
from workspace.order_payment op;

select can.canteen_nm, count(emp.employee_id)
from workspace.canteen can
         inner join workspace.employee emp on can.canteen_id = emp.canteen_id
group by can.canteen_id
having count(emp.employee_id) > 1;


select can.canteen_nm, count(del.company_owner_nm)
from workspace.canteen can
         inner join workspace.delivery_canteen_distribution delcan on can.canteen_id = delcan.canteen_id
         inner join workspace.delivery del on delcan.deliver_id = del.deliver_id
group by can.canteen_id
having count(del.company_owner_nm) > 1;

select can.canteen_nm, sum(ord.payment_amt * (1 - ord.discount_amt))
from workspace.order ord
         inner join workspace.canteen can on ord.canteen_id = can.canteen_id
group by can.canteen_id
having sum(ord.payment_amt * (1 - ord.discount_amt)) > 500;


create type result as
(
    nm     text,
    income double precision
);

drop function find_best_canteen_on_interval;

create or replace function find_best_canteen_on_interval(first timestamp, second timestamp) returns result
    language plpgsql
as
$$
declare
    maximum    double precision;
    canteen_nm text;
    res        result;
begin
    with helper as (
        select can.canteen_nm, sum(ord.payment_amt * (1 - ord.discount_amt)) income
        from workspace.order ord
                 inner join workspace.canteen can on ord.canteen_id = can.canteen_id
        where ord.order_dttm between first and second
        group by can.canteen_id
        order by sum(ord.payment_amt * (1 - ord.discount_amt)) desc)
    select max(income)
    into maximum
    from helper;
    with helper as (
        select can.canteen_nm, sum(ord.payment_amt * (1 - ord.discount_amt)) income
        from workspace.order ord
                 inner join workspace.canteen can on ord.canteen_id = can.canteen_id
        where ord.order_dttm between first and second
        group by can.canteen_id
        order by sum(ord.payment_amt * (1 - ord.discount_amt)) desc)
    select h.canteen_nm
    into canteen_nm
    from helper h
    where h.income = maximum;
    res.nm = canteen_nm;
    res.income = maximum;
    return res;
end
$$;

-- cтоловая с лучшим заработком на интервале.
select find_best_canteen_on_interval('2021-04-07 09:27:55', '2021-05-12 09:27:55');

drop function find_most_popular_dish;


create or replace function find_most_popular_dish() returns int
    language plpgsql
as
$$
declare
    dish int;
begin
    with helper as (
        select row_number() over (order by sum(dish_order.quantity_num) desc) num,
               dish.dish_id,
               canteen_id,
               sum(dish_order.quantity_num)
        from workspace.dish_order dish_order
                 inner join workspace.dish dish on dish.dish_id = dish_order.dish_id
        group by dish.dish_id
    )
    select dish_id
    into dish
    from helper
    where num = 1;
    return dish;
end;
$$;

-- id самого популярного блюда

select find_most_popular_dish();



