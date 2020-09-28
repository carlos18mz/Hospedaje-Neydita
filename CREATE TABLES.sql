

create table Pais(
  CPais int not null constraint PK_Pais Primary key,
  NPais varchar(15) not null
);

create table Ciudad(
  CCiudad int not null constraint PK_Ciudad Primary Key,
  NCiudad nvarchar(30) not null,
  CPais int not null Foreign Key references Pais(CPais)
);

create table Tipo_Documento(
	CTipo_Documento int not null constraint PK_Tipo_Documento Primary key,
	NTipo_Documento varchar(11) not null
);

create table Persona(
  CPersona int not null Primary key, 
  NPersona nvarchar(30) not null,
  DNacimiento datetime not null,
  CCiudad int not null Foreign Key references Ciudad(CCiudad),
  TEmail nvarchar(30) null,
  NIdentificacion nvarchar(12) not null,
  CTipo_Documento int not null Foreign key references Tipo_Documento(CTipo_Documento)
);


create table Servicio(
  CServicio int not null constraint PK_Servicio Primary key,
  NServicio nvarchar(20) not null,
  FDisponible Bit not null, 
  MPrecio Money not null, 
  TDetalle ntext not null, 
  QCapacidadS smallint not null
);


create table Rol(
  CRol int not null constraint PK_Rol Primary Key,
  NRol nvarchar(20) not null,
  CServicio int not null Foreign Key references Servicio(CServicio)
);


create table Empleado(
  CEmpleado int not null constraint PK_Empleado Primary Key,
  CRol int not null Foreign Key references Rol(CRol), 
  CEncargado int null Foreign Key references Empleado(CEmpleado),
  DFecha_Contratacion datetime not null,
  MSueldo money,
  CPersona int not null Foreign Key references Persona(CPersona)
);

create table Huesped(
  CHuesped int not null constraint PK_Huesped Primary Key,
  FAdulto Bit not null, --Bool type
  CApoderado int null Foreign Key references Huesped(CHuesped),
  CPersona int not null Foreign Key references Persona(CPersona)
);

create table Categoria(
  CCategoria int not null constraint PK_Categoria Primary Key,
  NCategoria varchar(20) not null,
  NDescuento real not null,
  NumRequisito int not null
);

create table Horario(
  CHorario int not null constraint PK_Horario Primary Key,
  T_Inicial time not null,
  T_Final time not null  
);

create table Dia(
  CDia varchar(5) not null constraint PK_Dia Primary Key,
  NDia varchar(10) not null
);

create table Tienda(
  CTienda int not null constraint PK_CTienda Primary Key,
  NTienda nvarchar(30) not null
);

create table Producto(
  CProducto int not null constraint PK_Producto Primary Key,
  NProducto nvarchar(20) not null, 
  MPrecio money not null,
  CTienda int not null Foreign Key references Tienda(CTienda)
);

create table Tipo_Habitacion(
  CTipo_Habitacion int not null constraint PK_Tipo_Habitacion Primary Key,
  NTipo_Habitacion nvarchar(20) not null,
  MPrecio money not null
);


create table Habitacion(
  CHabitacion int not null constraint PK_Habitacion Primary Key,
  FOcupado Bit not null,
  NPiso smallint not null,
  QCapacidadH int not null,
  CTipo_Habitacion int not null foreign key references Tipo_Habitacion(CTipo_Habitacion)
);



create table TipoMueble(
  CTipoMueble int not null constraint PK_TipoMueble primary key,
  NTipoMueble nvarchar(20) not null 
);

create table Comprobante(
  CComprobante int not null constraint PK_Comprobante Primary Key,
  DEmision datetime not null,
  FBoleta bit null,
  MMonto int,
  FCancelado bit not null,
);

create table Reserva(
  CReserva int not null constraint PK_Reserva Primary Key,
  FEstadia Bit not null,
  CComprobante int null Foreign Key references Comprobante(CComprobante),
  DInicioEstadia datetime not null,
  DFinEstadia datetime null,

);

create table Snack(
  CSnack int not null constraint PK_Snack Primary key,
  QCant_stock int not null,
  CProducto int not null Foreign Key references Producto(CProducto)

);

create table Ingrediente(
  CIngrediente int not null constraint PK_Ingrediente Primary Key,
  NIngrediente varchar(15) not null,
  QCant_stock int not null,
  MPrecio money not null
);

create table Factura(
  CRUC nvarchar(11) not null constraint PK_Factura Primary key,
  TDireccionlegal ntext not null,
  NEmpresa nvarchar(30) not null,
  CFactura int not null foreign key references Comprobante(CComprobante)
);

create table Plato(
  CPlato int not null constraint PK_Plato Primary Key,
  TPreparacion ntext not null,
  CProducto int not null Foreign Key references Producto(CProducto)
);

create table Proveedor(
CProveedor int not null constraint PK_Proveedor Primary Key,
NProveedor varchar(20) not null
);

create table Lote(
CProveedor int not null Foreign Key references Proveedor(CProveedor),
CIngrediente int not null Foreign Key references Ingrediente(CIngrediente),
DFecha_Envio datetime not null,
DVencimiento_Lote datetime not null, 
QUnidades_Lote int not null
);


create table Huesped_Categoria(
  CHuesped int not null Foreign Key references Huesped(CHuesped),
  CCategoria int not null Foreign Key references Categoria(CCategoria),
  DInicioC Datetime not null
);

create table Detalle_Servicio(
  CReserva int not null Foreign Key references Reserva(CReserva),
  CServicio int not null Foreign Key references Servicio(CServicio),
  DUso datetime not null
);

create table Detalle_Consumo(
  CProducto int not null Foreign Key references Producto(CProducto),
  DConsumo datetime not null,
  CReserva int not null Foreign Key references Reserva(CReserva),
  QConsumo int not null
);

create table Horario_Dia(
  CHorario_Dia int not null constraint PK_Horario_Dia primary key,
  CHorario int not null Foreign Key references Horario(CHorario),
  CDia varchar(5) not null Foreign Key references Dia(CDia),
  CServicio int null Foreign Key references Servicio(CServicio),
  CTienda int null Foreign Key references Tienda(CTienda),
);

create table Mueble_Habitacion(
  CTipoMueble int not null Foreign Key references TipoMueble(CTipoMueble),
  CHabitacion int not null Foreign Key references Habitacion(CHabitacion)
);

create table Reserva_Habitacion(
  CReserva int not null Foreign Key references Reserva(CReserva),
  CHabitacion int not null Foreign Key references Habitacion(CHabitacion),
);

create table Plato_Ingrediente(
  CPlato int not null Foreign Key references Plato(CPlato),
  CIngrediente int not null Foreign Key references Ingrediente(CIngrediente),
  QUnidades int not null 
);

create table Huesped_Reserva(
 CReserva int not null Foreign Key references Reserva(CReserva),
 CHuesped int not null Foreign Key references Huesped(CHuesped),
)
