create table nagoya (
   day varchar(20) not null,
   day_of_week varchar(20) not null,
   weather varchar(20) not null,
   temperature real not null,
   rainy_percent integer not null default 0
);

create table region (
   area_id serial primary key,
   area_name varchar(40) not null unique, 
   create_date timestamp not null default now(),
   update_date timestamp
);

commit;