USE DbHospedajeNeydita
GO

CREATE PROCEDURE CancelacionServicio(@codigo INT)
AS
BEGIN
	IF EXISTS (SELECT * FROM dbo.Servicio S WHERE S.CServicio = @codigo AND S.FDisponible = 1)
	BEGIN
		UPDATE dbo.Servicio 
		SET FDisponible = 0
		WHERE CServicio = @codigo
		SELECT * FROM dbo.Servicio S WHERE S.CServicio = @codigo
		PRINT 'SE CANCELÓ EL SERVICIO DEBIDO A UN INESPERADO IMPREVISTO'
	END
	ELSE
		PRINT 'ESTE SERVICIO NO PUEDE CANCELARSE PORQUE NO EXISTE O NO ESTÁ DISPONIBLE'
END
GO

EXEC CancelacionServicio 6
GO

UPDATE dbo.Servicio
SET FDisponible = 1
WHERE CServicio != 4

SELECT * FROM dbo.Servicio
GO