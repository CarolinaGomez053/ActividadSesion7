use master 
create database concesionarioCS

use concesionarioCS

create table tipoVehiculo
(
	id int primary key,
	nombre varchar (25)

)

create proc addTipoVehiculo
(
	@id int,
	@nombre varchar(25)
)

as insert into tipoVehiculo values (@id, @nombre)

select *from tipoVehiculo
exec addTipoVehiculo '01','camión'

create table vehiculo
(
	id int primary key,
	marca varchar (25) unique,
	modelo varchar (25) not null,
	placa varchar (10) not null unique,
	año int not null,
	id_tv int not null,
	constraint rel_a_tipovehi foreign key (id_tv) references tipoVehiculo (id)


)

create proc addvehiculo
(
	@id int,
	@marca varchar (25),
	@modelo varchar (25),
	@placa varchar (10),
	@año int,
	@id_tv int
)

as insert into Vehiculo values (@id, @marca, @modelo, @placa, @año, @id_tv)

select * from Vehiculo
exec addvehiculo 1,'Foton', 'cx3', 'ASD123', 2019, 1

create table ruta
(
	id int primary key,
	estacion varchar (25),
	id_vehiculo int not null,
	constraint rel_a_vehiculo foreign key (id_vehiculo) references vehiculo (id)
	
)

create proc addruta
(
	@id int,
	@estacion varchar (25),
	@id_vehiculo int
)

as insert into ruta values (@id, @estacion, @id_vehiculo)

select * from ruta
exec addruta 1,'xx', 1

create table tipo_conductor
(
	id int primary key,
	tipo_persona varchar (25)

)

create proc addtipoConductor
(
	@id int ,
	@tipo_persona varchar (25)
)

as insert into tipo_conductor values (@id, @tipo_persona)

select *from tipo_conductor
exec addtipoConductor '01','natural'


create table conductor
(
	id int primary key,
	nombre varchar (25) not null,
	tipo_licencia varchar (10) not null,
	id_vehiculo int unique,
	id_tipo_conductor int unique
	constraint rel_a_tipoConductor foreign key (id_tipo_conductor) references tipo_conductor (id),
	constraint rel_a_vehi foreign key (id_vehiculo) references vehiculo (id)

)

select * from conductor


create proc addconductor
(
	@id int,
	@nombre varchar (25),
	@tipo_licencia varchar (25),
	@id_vehiculo varchar (10),
	@id_tipo_conductor int,
	@id_tv int
)

as insert into conductor values (@id, @nombre, @tipo_licencia, @id_vehiculo, @id_tipo_conductor)


create table contrato
(
	id int primary key,
	id_conductor int not null,
	id_vehiculo int not null
	constraint rel_a_conductor foreign key (id_conductor) references conductor (id)
)

create proc addcontrato
(
	@id int,
	@id_conductor int,
	@id_vehiculo int
)
as insert into contrato values (@id, @id_conductor, @id_vehiculo)

select * from contrato
exec addcontrato 1, 1, 1