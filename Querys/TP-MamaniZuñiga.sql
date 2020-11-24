USE NHTest3

--QUERY 1 Se hacen las fiestas tipicas en la ciudad que mas personas vinieron a hospedarse en el año
SELECT N.Cantidad_Personas, N.CCiudad, N.CPais, N.NCiudad FROM 
	(SELECT * FROM 
		(SELECT count(s.CCiudad) as Cantidad_Personas, 
		s.CCiudad as CCiudad2 from VENTAS.Persona s Group by s.CCiudad)L 
		INNER JOIN VENTAS.Ciudad C ON L.CCiudad2 = C.CCiudad)N
		WHERE N.Cantidad_Personas = (
			SELECT max(R.cp) from (SELECT count(p.CCiudad) 
			as cp, p.CCiudad from VENTAS.Persona p GROUP BY p.CCiudad)R); 


--QUERY 2 Los empleados podran consultar la habitacion de cada lciente con su codigo de reserva

CREATE PROCEDURE USP_OBTENERHABITACIONPORRESERVA
(
	@CODIGO_RESERVA INT
)
AS 
BEGIN
	SET NOCOUNT ON
	BEGIN TRY
		SELECT * FROM MARKETING.Reserva R 
		INNER JOIN OPERACIONES.Reserva_Habitacion RH ON R.CReserva = RH.CReserva 
		JOIN OPERACIONES.Habitacion H ON H.NHabitacion = RH.CHabitacion WHERE R.CReserva = @CODIGO_RESERVA
	END TRY
	BEGIN CATCH
		
	END CATCH
END

EXEC USP_OBTENERHABITACIONPORRESERVA 1
GO

--QUERY 3 Los clientes podran visualizar la disponibilidad, dia y hora de los eventos del dia a través de su aplicacion móvil
CREATE PROCEDURE USP_OBTENEREVENTOPORDIA
(
	@DIA VARCHAR(10)
)
AS
BEGIN
	BEGIN TRY
		SELECT S.CServicio, S.NServicio, S.MPrecio, S.TDetalle,
		HD.CHorario_Dia, H.TInicial, H.TFinal
		FROM OPERACIONES.Servicio S INNER JOIN OPERACIONES.Horario_Dia HD 
		ON S.CServicio = HD.CServicio INNER JOIN OPERACIONES.Horario H 
		ON HD.CHorario = H.CHorario INNER JOIN OPERACIONES.Dia D ON HD.CDia = D.CDia WHERE D.NDia = @DIA AND S.FDisponible = 1
	END TRY
	BEGIN CATCH

	END CATCH
END

EXEC USP_OBTENEREVENTOPORDIA 'Lunes'
GO

-- Query 4 Con motivos de implementar una capaña de marketing, se desea saber la categoria que prefieren los huespedes que traen a sus hijos

SELECT * FROM VENTAS.Huesped T INNER JOIN 
(
	SELECT * FROM VENTAS.Huesped L WHERE L.FAdulto = 0
)Z 
ON T.CHuesped = Z.CApoderado INNER JOIN VENTAS.Huesped_Categoria HC ON T.CHuesped = HC.CHuesped



SELECT * FROM OPERACIONES.Tienda

-- Query 5 Los clientes pueden solicitar platos a la habitación
CREATE PROCEDURE USP_SOLICITARPRODUCTOAHABITACION
(
	@CODIGOPRODUCTO INT
)
AS
BEGIN
	BEGIN TRY
		SELECT P.CProducto, P.NProducto, P.MPrecio,T.NTienda 
		FROM OPERACIONES.Producto P 
		JOIN OPERACIONES.Tienda_Producto TP ON P.CProducto = TP.CProducto 
		JOIN OPERACIONES.Tienda T ON TP.CTienda = T.CTienda 
		WHERE P.CProducto = @CODIGOPRODUCTO
	END TRY
	BEGIN CATCH

	END CATCH

END
EXEC USP_SOLICITARPRODUCTOAHABITACION 1
