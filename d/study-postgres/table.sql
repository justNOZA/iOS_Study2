create table nagoya (
   day date primary key not null,
   day_of_week varchar(20) not null,
   weather varchar(20) not null,
   temperature real not null,
   rainy_percent integer not null default 0
);
commit;