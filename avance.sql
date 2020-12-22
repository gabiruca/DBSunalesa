use sunalesa;

/*
VISTAS
*/
		/*
		DE: SANDY ADAGMARI INTRIAGO ORTIZ
		Crear una vista que muestre los nombres de los clientes que tiene la empresa hasta el dia de hoy.
		*/
		 create view clientes AS
			 select nombre
			 from cliente;
		/*
		DE: XAVIER EDUARDO CARLIER AUZ
		Las 10 obras más recientes
		*/
		create view obrasRecientes AS
			 select *
			 from obra
			 order by fechaEntrega DESC limit 10;
		/*
		DE: JUAN JOSE LOOR TOALA
		Las 5 obras más antiguas
		*/
		create view obrasAntiguas AS
			 select *
			 from obra
			 order by fechaEntrega asc limit 5;
		/*
		DE: GABRIELA CECILIA SOSA CASAL
		Crear una vista que muestre cuantos proveedores hay por ciudad.
		*/
		 create view ProveedoresPorCiudad AS
			 select direccion, count(nombre) as cantidadProveedores from proveedor group by direccion ;
-- --------------------------------------------------------------
/*
CONSULTAS
*/
		/*
        DE: SANDY ADAGMARI INTRIAGO ORTIZ
		Top 3 de los proveedores a los cuales el dueño les ha comprado con mayor frecuencia.
		*/

		Select p.nombre, count(p.ruc) as vecesCompradas, sum(c.valor) as valorTotal
			from proveedor p, comprobante c
			where p.ruc=c.ruc
			group by c.ruc limit 3;
            
		/*
		DE: XAVIER EDUARDO CARLIER AUZ
		Nombre de los proveedores de Manta que han atendido clientes de Manta
		*/
		select distinct b.nombre 
		from (select co.idDueño from cliente c natural join comprobante co where c.direccion like "Manta%") a natural join
		 (select co.idDueño, p.nombre from comprobante co natural join proveedor p where p.direccion = "Manta") b;
         
         /*
		DE: JUAN JOSE LOOR TOALA
		Datos de la obras que se hayan realizado en la fecha 2019-08-24 por el cliente Sofia
		*/
		 select distinct nombre
		 from  obra o , pertenece p , cliente c where o.codigo=p.codigo and p.idCliente=c.idCliente 
		 and o.fechaEntrega="2019-08-24" and c.nombre="Sofia";
		 
		 /*
		DE: GABRIELA CECILIA SOSA CASAL
		 Muestre los materiales que han sido provistos por el proveedor 'diseglas'.
		*/

		Select c.materiales as Materiales from proveedor p natural join compra c where p.nombre= 'diseglas';
						
-- ---------------------------------------------------------
/*
PROCEDIMIENTOS ALMACENADOS
*/

		/*
		DE: SANDY ADAGMARI INTRIAGO ORTIZ
		Proceso que muestre los ingresos generados durante el mes.
		*/
		  
		DELIMITER $$
		CREATE PROCEDURE  ingresosMes(in mes int, in año int, out valor float)
		BEGIN

				select sum(obra.precio) INTO valor
				from obra
				where year(obra.fechaEntrega)=año and  month(obra.fechaEntrega)=mes ;
			
		END$$
		DELIMITER ;

		/*
		DE: XAVIER EDUARDO CARLIER AUZ
		Proceso que muestre los costos generados durante el mes.
		*/

		DELIMITER $$
		CREATE PROCEDURE  costos(out valor float)
		BEGIN

				select sum(comprobante.valor) INTO valor
				from comprobante
				where comprobante.tipoComprobante = "factura compra";
			
		END$$
		DELIMITER ;

		/*
		DE: JUAN JOSE LOOR TOALA
		Proceso que muestre el numero de obras realizadas en cierta direccion
		*/

		DELIMITER $$
		CREATE PROCEDURE  Clientes_Ciudad(in direccion_entrada varchar(30) , out suma int)
		BEGIN

				select count(o.codigo) INTO suma
				from obra o
				where o.direccion=direccion_entrada;	
		END$$
		DELIMITER ;

		/*
		DE: GABRIELA CECILIA SOSA CASAL
		La cantidad de obras que costaron mas que cierto valor.
		*/
		  
		DELIMITER ║
		CREATE PROCEDURE  obrasPorCosto( in valor1 float, out cantidadObras int)
		BEGIN

				select count(comprobante.numero) INTO cantidadObras from comprobante where comprobante.valor > valor1;

		END ║
		DELIMITER ;


-- drop procedure ingresosMes;
-- -------------------------------------------------------------
/*
TRIGGERS
*/
		/*
		DE: SANDY ADAGMARI INTRIAGO ORTIZ
		Crear un trigger que en caso de que el dueño elimine una obra, esta se almacene en la tabla de obras canceladas.
		*/

		DELIMITER $$
		create trigger moverObra before delete on obra
			for each row
			Begin
				insert into obrasCanceladas values(old.codigo,
				old.idDueño,
				old.materiales,
				old.direccion,
				old.precio,
				old.tipoDeObra,
				old.fechaEntrega);
			
			end$$
			
		/*
		DE: XAVIER EDUARDO CARLIER AUZ
		Crear un trigger que en caso se añada un comprobante corrija los datos dependiendo del tipo de comprobante
		*/
		DELIMITER /
		create trigger revisarComprobante before insert on comprobante
			for each row
			Begin
				if new.tipoComprobante = "factura compra" and new.idCliente is not null then set new.idCliente = null;
				elseif new.tipoComprobante = "factura venta" and new.RUC is not null then set new.RUC = null;
				end if;
			end/
		DELIMITER ;

		/*
		DE: JUAN JOSE LOOR TOALA
		Trigger que autogenera fecha de obra en caso de que no se asigne alguna fecha de entrega.
		*/


		DELIMITER /
		create trigger GenerarFechaObra before insert on obra for each row
		begin
		   if new.fechaEntrega is null then
		   set new.fechaEntrega=now() + interval 60 day;
		   end if ;
		   end/
		DELIMITER ;

		/*
		DE: GABRIELA CECILIA SOSA CASAL
		Crear un trigger que siempre defina al señor Freddy Intriago, con id 130989898, como dueño de una compra.
		*/

		DELIMITER ║
		create trigger ownerPorDefecto before insert on compra
			for each row
			Begin

					set new.idDueño=130989898 ;
			
			end ║
		DELIMITER ;

-- drop trigger moverObra;

/*
EXTRA
*/
/*
view de las compras privadas realizadas en Manta
*/
create view comprasManta as 
	select materiales, nombre from compra natural join proveedor where direccion = "Manta";
/*
view de los clientes que han encargado obras en una dirección diferente a la suya
*/
create view clientesConObrasLejanas as 
	select a.nombre, a.idCliente from (Select * from cliente natural join pertenece) a join obra o on a.codigo = o.codigo 
    where a.direccion <> o.direccion;
/*
clientes que han encargado obras que requieren aluminio
*/
select a.nombre, a.idCliente from (Select * from cliente natural join pertenece) a join obra o on a.codigo = o.codigo 
    where o.materiales like "%Aluminio%" or o.materiales like "%aluminio%";
/*
clientes que han encargado puertas
*/
select a.nombre, a.idCliente from (Select * from cliente natural join pertenece) a join obra o on a.codigo = o.codigo 
    where o.tipoDeObra = "Puertas";
/*
asegurar que el dueño en los comprobantes sea el mismo
*/
DELIMITER ║
	create trigger defaultOwner before insert on comprobante
		for each row
		Begin
				set new.idDueño=130989898 ;
		end ║
DELIMITER ;
/*
Trigger que autogenera fecha de obra en caso de que no se asigne alguna fecha de entrega.
*/
DELIMITER /
	create trigger checkIVA before insert on comprobante 
		for each row
		begin
		   set new.iva=0.12;
		end/
DELIMITER ;
/*
Proceso que muestre el numero de obras realizadas en una ciudad
*/
DELIMITER $$
CREATE PROCEDURE  obrasEnCiudad(in ciudad varchar(30) , out suma int)
BEGIN
		select count(o.codigo) INTO suma
		from obra o
		where o.direccion like concat("%",ciudad,"&");	
END$$
DELIMITER ;
/*
Proceso que muestre el numero de obras realizadas para un cliente
*/
DELIMITER $$
CREATE PROCEDURE  obrasDeCliente(in id int , out suma int)
BEGIN
		select count(o.codigo) INTO suma
		from obra o natural join pertenece p natural join cliente c
		where c.idCliente = id;	
END$$
DELIMITER ;