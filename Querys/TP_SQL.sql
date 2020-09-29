/*CREATE TABLE Capacitacion (
    IDCapacitaicion int  NOT NULL,
    Descripcion nvarchar(50)  NOT NULL,
    DFecha Date  NOT NULL,
    CONSTRAINT Capacitacion_pk PRIMARY KEY  (IDCapacitaicion)
);
drop table Capacitacion
SELECT * FROM Empleado

ALTER TABLE Capacitacion ADD CONSTRAINT Capacitacion_Empleado
    FOREIGN KEY (Empleado_CEmpleado)
    REFERENCES Empleado (CEmpleado);
*/
insert into  Empleado values(2018)

/*/16.   Se revisaría que los empleados hayan recibido una reduccion de su sueldo como mínimo en 5% que es el estipulado por mutuoa acuerdo a aquellos trabajadores que teienen menos de 5 años con nostros.*/


alter function local_employees(@date int)
returns table
as
return(SELECT e.CEmpleado, YEAR(e.DFecha_Contratacion)as anio,e.MSueldo FROM Empleado e
where @date - YEAR(e.DFecha_Contratacion) < 5 );
GO


ALTER procedure desc_employees
(
@sueldo float
)
as
begin
 If (SELECT COUNT(*) AS ANIO FROM Empleado e
 WHERE year(e.DFecha_Contratacion) in (select p.anio from local_employees(2020) p))>0
  begin
     UPDATE	Empleado
	 SET		MSueldo = MSueldo - @sueldo*MSueldo
   end
end
GO
 
 DECLARE @sueldo float
 set @sueldo = 0.05
 EXEC desc_employees @sueldo

 select * from Empleado



 /*procedimento con funcion*/
insert into Rol
select *from Servicio
SELECT *FROM Empleado
SELECT * FROM ROL

/*17.   Debido a ciertos protocolos alimenticios del hotel  Si existen snacks que estás por debajo de la cantidad mínimo  que son menos de  35 unidades se debe hacer un procedimiento que haga el procedimiento necesario para saber si esta sucediendo esto*/
/*Proc notificacion */
insert into Snack values(9,25)
select * from Snack
select * from Tienda

alter function fx_snack()returns int
as
begin
declare @f money
select @f = avg(s.QCant_stock)
       from snack s
if @f is null
   set @f=0
return @f
end
go

select * from Snack
select * from Lote
select * from Proveedor

 dbo.fx_snack()
ALTER procedure pro_snack
AS
BEGIN
declare @promedio  int
set @promedio = DBO.fx_snack()
print (@promedio)
  IF (SELECT COUNT(*) FROM  Snack s WHERE s.QCant_stock > @promedio) > (SELECT COUNT(*) FROM  Snack s )
       BEGIN
	   PRINT('HAY MAS INSUMOS CON MAYOR CANTIDAD QUE EL PROM')
	   end
  ELSE
	 BEGIN
	   PRINT('HAY MENOS INSUMOS CON MAYOR CANTIDAD QUE EL PROMEDIO')
	   end
end
go

exec pro_snack



/*17.MARCAR COMO CANCELADO*/

create Trigger TR_Facturas
ON  Reserva for insert
As
set nocount on
update Reserva set FCancelado = 1
from inserted inner join Reserva
on inserted.CReserva = Reserva.CReserva
go

insert into Reserva values (23,1,null,convert(datetime,'20-10-20 10:34:09 AM',5),null,0)

/*18.   Si el 75% de habitaciones están vacías será necesario enviar una notificación al equipo de Marketing*/


select * from Reserva re

insert into Reserva values (23,1,null,convert(datetime,'20-10-20 10:34:09 AM',5),null,0)

SELECT* FROM Habitacion
create trigger rentable_marketing
on 
INSERT INTO Habitacion values(300,0,3,3,4)

select *  from  TipoMueble
select * from Tipo_Habitacion
select * from Habitacion
select * from Mueble_Habitacion
select*from Factura f

/*20.El equipo de marketing requiere hacer promociones en platos. Por lo tanto, necesita una función que permita ingresar el plato y modificar su preciopara reservas de julio.*/

alter function fx_mark(@Aanio int)
returns table
as
return(select r.DInicioEstadia as anio from Reserva r
where (MONTH(r.DInicioEstadia) = 7) and (YEAR(r.DInicioEstadia) >= @Aanio))

select*from dbo.fx_mark(2020)
ALTER procedure Proc_result
(
@descount float
)
as
 begin
   if ( select p.anio from dbo.fx_mark(2020) p WHERE p.anio IN (select r.DInicioEstadia from Reserva r)) > 0
    begin
	  UPDATE Producto
	  SET MPrecio = MPrecio - MPrecio*@descount
	  print('Exitoso')
	  end
	  else
	  print('No hay reservas en julio')
	
 end
GO
select * from Producto,Plato
exec Proc_result 0.015

SELECT * FROM Producto
select * from Reserva


Create Trigger TRG_PLATO


/*create trigger tg_estado_habitacion
on Reserva_Habitacion
for Insert
as begin
		update Habitacion
		set FOcupado = 1
		from Habitacion h join inserted e on e.CHabitacion=h.CHabitacion
		where e.CHabitacion = h.CHabitacion
end

/*prueba:*/ 
insert into Reserva_Habitacion(CReserva,CHabitacion) values (12,103)

select h.FOcupado
from Habitacion h
where h.CHabitacion=103*/