create database weather;
create table nagoya (
   day date not null,
   day_of_week varchar(20) not null,
   weather varchar(20) not null,
   temperature real not null,
   rainy_percent integer not null default 0
);

insert into nagoya values('2021-06-01', '火曜日', '晴れ', 28.4, 1);
insert into nagoya values('2021-06-02', '水曜日', '雲', 26, 30);
insert into nagoya values('2021-06-03', '木曜日', '雲', 28.4, 30);
insert into nagoya values('2021-06-04', '金曜日', '雨', 23.1, 70);
insert into nagoya values('2021-06-05', '土曜日', '雲', 25.7, 10);
insert into nagoya values('2021-06-06', '日曜日', '晴れ', 28, 60);
insert into nagoya values('2021-06-07', '月曜日', '晴れ', 31, 1);

commit;