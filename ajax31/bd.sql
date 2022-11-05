create table provincias(
	id int not null auto_increment,
	name varchar(255) not null,
	primary key(id)
)COMMENT='provincias';

select * from provincias where name like 'M%'
ORDER BY name asc limit 0,5