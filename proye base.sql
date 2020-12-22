create database sunalesa;
use sunalesa;
create table proveedor(
	ruc int(30),
    	nombre varchar(30),
   	 direccion varchar(30),
    	primary key(ruc));
create table dueño(
	idDueño int(10),
    	nombre varchar(30),
    	apellido varchar(30),
   	 direccion varchar(100),
   	 primary key(idDueño));
create table cliente(
	idCliente int(10),
    	nombre varchar(30),
    	direccion varchar(30),
   	primary key(idCliente));
create table comprobante(
	numero int(10),
    	idDueño int(10),
    	idCliente int(10),
    	ruc int(30),
    	nombreCliente varchar(30),
    	nombreProveedor varchar(30),
    	tipoComprobante varchar(30),
    	valor float,
        iva float,
    	materiales varchar(100),
    	primary key(numero),
   	foreign key(idDueño) references dueño(idDueño),
    	foreign key(idCliente) references cliente(idCliente),
  	foreign key(ruc) references proveedor(ruc));
create table obra(
	codigo int(30),
    	idDueño int(30),
    	materiales varchar(100),
    	direccion varchar(100),
    	precio float,
    	tipoDeObra varchar(30),
    	fechaEntrega date,
    	primary key(codigo),
    	foreign key(idDueño) references dueño(idDueño));
create table pertenece(
	codigo int(30),
   	 idCliente int(10),
    	primary key(codigo,idCliente),
    	foreign key(codigo) references obra(codigo),
    	foreign key(idCliente) references cliente(idCliente));

create table compra(
	codigo int(20),
	idDueño int(10),
   	 ruc int(30),
    	materiales varchar(100),
    	primary key(codigo),
    	foreign key(idDueño) references dueño(idDueño),
    	foreign key(ruc) references proveedor(ruc));

insert into dueño values(130989898, "Freddy", "Intriago", "Montecristi diagonal a la escuela Kerly Torres");

insert into proveedor values (123, "diseglas", "Manta");
	insert into proveedor values (1231, "Ferreteria_Herda", "Manta");
    insert into proveedor values (1232, "sunglass", "Guayaquil");
    insert into proveedor values (1233, "zurita", "Quito");
    insert into proveedor values (1234, "American", "Manta");
    insert into proveedor values (1235, "Aluminio_Ventas","Quito");
    insert into proveedor values (1236, "Vidreo Ventas", "Manta");
    insert into proveedor values (1237, "MegaKiwi", "Manta");
    insert into proveedor values (1238, "Glass", "Manta");
    insert into proveedor values (1239, "Europer", "Quito");
    insert into proveedor values (12310, "A", "Guayaquil");
    insert into proveedor values (12311, "B", "Montecriti");
    insert into proveedor values (123112, "C", "Manta");
    insert into proveedor values (12313, "Miler", "Manta");
    insert into proveedor values (12314, "Vidreos Alvarado", "Quito");
    insert into proveedor values (12315, "Luxuries in glass", "Manta");
    insert into proveedor values (12316, "Miss Glass", "Manta");
    insert into proveedor values (12317, "D", "Montecristi");
    insert into proveedor values (12318, "E", "Quito");
    insert into proveedor values (12319, "F", "Manta");

insert into cliente values(1, "Monica", "Montecristi, av 3");
	insert into cliente values(2, "Erika", "Montecristi av 1");
    insert into cliente values(3, "Lisa", "Montecrist av 5");
    insert into cliente values(4, "Manuel", "Manta av 1");
    insert into cliente values(5, "Jairo", "Manta av 1");
    insert into cliente values(6, "Camilo", "Manta av 2");
    insert into cliente values(7, "Jaime", "Manta av 2");
    insert into cliente values(8, "Nedi", "Manta av 3");
    insert into cliente values(9, "Neidy", "Manta av 4");
    insert into cliente values(10, "Rosalia", "Manta av 4");
    insert into cliente values(11, "Shanny", "Manta av 5");
    insert into cliente values(12, "Nayeska", "Manta av 9");
    insert into cliente values(13, "Sully", "Manta av 11");
    insert into cliente values(14, "Sofia", "Manta av 10");
    insert into cliente values(15, "Ana", "Manta av 7");
    insert into cliente values(16, "Iveth", "Manta av 11");
    insert into cliente values(17, "Carmelo", "Manta av 13");
    insert into cliente values(18, "Segundo", "Manta av 17");
    insert into cliente values(19, "Pedro", "Manta av 18");
    insert into cliente values(20, "Pier", "Manta av 17");
    
insert into comprobante values(1,130989898,1,null,"Monica",null,"factura venta",100,14,"Pago de la Obra");
	insert into comprobante values(2,130989898,2,null,"Erika",null,"factura venta",340,47.6,"Pago de la Obra");
    insert into comprobante values(3,130989898,3,null,"Lisa",null,"factura venta",1000,140,"Pago de la Obra");
    insert into comprobante values(4,130989898,4,null,"Manuel",null,"factura venta",2500,350,"Pago de la Obra");
    insert into comprobante values(5,130989898,5,null,"Jairo",null,"factura venta",100,14,"Pago de la Obra");
    insert into comprobante values(6,130989898,6,null,"Camilo",null,"factura venta",45,6.3,"Pago de la Obra");
    insert into comprobante values(7,130989898,7,null,"Jaime",null,"factura venta",60,8.4,"Pago de la Obra");
    insert into comprobante values(8,130989898,8,null,"Nedy",null,"factura venta",100,14,"Pago de la Obra");
    insert into comprobante values(9,130989898,9,null,"Neidy",null,"factura venta",70,9.8,"Pago de la Obra");
    insert into comprobante values(10,130989898,10,null,"Rosalia",null,"factura venta",1000,140,"Pago de la Obra");
    insert into comprobante values(12,130989898,null,123,null, "diseglas","factura compra", 450,63,"Vidreo, Aluminio, Laminas, Tornillos" );
    insert into comprobante values(13,130989898,null,123,null, "diseglas","factura compra", 20,2.8,"Tornillos Redondos" );
    insert into comprobante values(14,130989898,null,123,null, "diseglas","factura compra", 100,14,"Chapa, Malla" );
    insert into comprobante values(15,130989898,null,123,null, "diseglas","factura compra", 200,28,"Vidreo, Aluminio, Laminas, Tornillos, Chapa, Malla,Resortes" );
    insert into comprobante values(16,130989898,null,1231,null, "Ferreteria Herda","factura compra", 45,6.3,"Clavos, Laminas" );
    insert into comprobante values(17,130989898,null,1231,null, "Ferreteria Herda","factura compra", 10,1.4,"Metro, Aluminio" );
    insert into comprobante values(18,130989898,null,1232,null, "sunglass","factura compra", 20,2.8,"Laminas, Tornillos" );
    insert into comprobante values(19,130989898,null,12314,null, "Vidreos Alvarado","factura compra", 450,63,"Vidreo, Aluminio" );
    insert into comprobante values(20,130989898,null,12317,null, "D","factura compra", 30,4.2,"Lucuvon, Malla" );
    insert into comprobante values(21,130989898,null,12318,null, "E","factura compra", 35,4.9,"Tornillos, Vidreos, Aluminio" );

insert into obra values(1,130989898,"Aluminio, vidrio, tornillos, manigeta","Montecristi, av 3",342,"Ventanas","2019-12-03");
	insert into obra values(2,130989898,"Aluminio, vidrio, tornillos, manigeta","Montecristi av 1",340,"Ventanas","2019-12-03");
    insert into obra values(3,130989898,"Aluminio, vidrio, tornillos, manigeta","Montecristi av 5",380,"Ventanas","2019-11-03");
    insert into obra values(4,130989898,"Aluminio, vidrio, tornillos, manigeta","Manta av 1",120,"Ventanas","2019-11-05");
    insert into obra values(5,130989898,"Aluminio, vidrio, tornillos, manigeta","Manta av 2",240,"Ventanas","2019-12-19");
    insert into obra values(6,130989898,"Aluminio, vidrio, tornillos, chapa, lucuvon","Manta av 2",470,"Puertas","2019-07-03");
    insert into obra values(7,130989898,"Aluminio, vidrio, tornillos, chapa, lucuvon","Manta av 3",470,"Puertas","2019-06-03");
    insert into obra values(8,130989898,"Aluminio, vidrio, tornillos, chapa, lucuvon","Manta av 4",740,"Puertas","2019-07-14");
    insert into obra values(9,130989898,"Aluminio, vidrio, tornillos, chapa, lucuvon","Manta av 5",540,"Puertas","2019-11-02");
    insert into obra values(10,130989898,"Aluminio, vidrio, tornillos, chapa, lucuvon","Manta av 7",640,"Puertas","2019-09-03");
    insert into obra values(11,130989898,"Vidrio, aluminio","Manta av 11",70,"Pesceras","2019-11-11");
    insert into obra values(12,130989898,"Vidrio, aluminio","Manta av 10",90,"Pesceras","2019-11-22");
    insert into obra values(13,130989898,"Vidrio, aluminio","Manta av 13",120,"Pesceras","2019-08-24");
    insert into obra values(14,130989898,"Vidrio, aluminio","Manta av 17",140,"Pesceras","2019-11-01");
    insert into obra values(15,130989898,"Vidrio, aluminio","Manta av 18",50,"Pesceras","2019-05-11");
    insert into obra values(16,130989898,"Vidrio, aluminio","Manta av 9",70,"Pesceras","2019-12-13");
    insert into obra values(17,130989898,"Vidrio templado, aluminio","Manta av 3",400,"Vidreo fijo","2019-05-12");
	insert into obra values(18,130989898,"Vidrio templado, aluminio","Manta av 4",700,"Vidreo fijo","2019-06-12");
	insert into obra values(19,130989898,"Vidrio templado, aluminio","Manta av 5",1000,"Vidreo fijo","2019-07-05");
	insert into obra values(20,130989898,"Vidrio templado, aluminio","Manta av 10",1200,"Vidreo fijo","2019-08-10");
    
insert into pertenece values(1,1);
	insert into pertenece values(2,2);
    insert into pertenece values(3,3);
    insert into pertenece values(4,4);
    insert into pertenece values(5,6);
    insert into pertenece values(6,7);
    insert into pertenece values(7,8);
    insert into pertenece values(8,9);
    insert into pertenece values(9,11);
    insert into pertenece values(10,15);
    insert into pertenece values(11,16);
    insert into pertenece values(12,14);
    insert into pertenece values(13,17);
    insert into pertenece values(14,18);
    insert into pertenece values(15,19);
    insert into pertenece values(16,12);
    insert into pertenece values(17,8);
    insert into pertenece values(18,10);
    insert into pertenece values(19,11);
    insert into pertenece values(20,14);

insert into compra values(1,130989898,12319,"Vidrio, Aluminio");
	insert into compra values(2,130989898,123,"Vidrio, Aluminio, Laminas, Tornillos" );
    insert into compra values(3,130989898,123,"Tornillos Redondos" );
    insert into compra values(4,130989898,123,"Chapa, Malla" );
    insert into compra values(5,130989898,123,"Vidrio, Aluminio, Laminas, Tornillos, Chapa, Malla,Resortes" );
    insert into compra values(6,130989898,1231,"Clavos, Laminas" );
    insert into compra values(7,130989898,1231,"Metro, Aluminio" );
    insert into compra values(8,130989898,1232,"Laminas, Tornillos" );
    insert into compra values(9,130989898,12314,"Vidrio, Aluminio" );
    insert into compra values(10,130989898,12317,"Lucuvon, Malla" );
    insert into compra values(11,130989898,12318,"Tornillos, Vidreos, Aluminio" );
    insert into compra values(12,130989898,1238,"Vidrio, Aluminio");
    insert into compra values(13,130989898,1239,"Malla");
    insert into compra values(14,130989898,12310,"Tornillos");
    insert into compra values(15,130989898,12311,"Vidrio, Aluminio");
    insert into compra values(16,130989898,123112,"Vidrio Templado");
    insert into compra values(17,130989898,12313,"Aluminio");
    insert into compra values(18,130989898,12314,"Chapa, manigeta");
    insert into compra values(19,130989898,12315,"Vidreo, Aluminio");
    insert into compra values(20, 130989898,12316,"Lucuvon");
    
    