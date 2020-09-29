create trigger MODIFICACION_DE_CATEGORIA
ON Huesped_Categoria 
for update , insert
AS BEGIN
	UPDATE Huesped_Categoria
	set CCategoria=1
	from Huesped_Categoria h 
	where datediff(DAY,h.DInicioC,GETDATE())<1095
end