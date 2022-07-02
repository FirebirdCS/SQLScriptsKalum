USE Kalum_Test;
go
    CREATE FUNCTION RPAD (
        @string VARCHAR(MAX),-- Cadena inicial
        @length INT,-- Tamaño del correlativo, string final
        @pad CHAR -- Caracter que se utilizar� para el reemplazo
    ) RETURNS VARCHAR(MAX) AS 
	BEGIN 
	RETURN @string + replicate(@pad, @length - len(@string));
END;
go
    DROP FUNCTION LPAD;
go
    CREATE FUNCTION LPAD (
        @string VARCHAR(MAX),
        @length INT,
        @pad CHAR
    ) RETURNS VARCHAR(MAX) AS 
	BEGIN 
	RETURN REPLICATE(@pad, @length - LEN(@string)) + @string;
END;
go
SELECT
    CONCAT('2022', dbo.LPAD('79', 3, '5')); -- Creación de procedimientos almacenados
go
SELECT *FROM Aspirante a;
go
SELECT * FROM CarreraTecnica ct;
go
SELECT * FROM InversionCarreraTecnica ict;
go
INSERT INTO InversionCarreraTecnica (InversionId, MontoInscripcion, NumeroPagos, MontoPago, CarreraId)
	VALUES(NEWID(),1100,7,650,'0EC23292-E40E-492A-9A6D-8197976EC947');
go
SELECT * FROM Cargo c;
go
INSERT INTO Cargo VALUES (NEWID(), 'Pago de inscripción de carrera técnica plan fin de semana','INSC',1200.00,0,0);
go
INSERT INTO Cargo VALUES (NEWID(),'Pago mensual carrera t�cnica','PMSCT',750.00,0,0);
go
INSERT INTO Cargo VALUES (NEWID(), 'Carne', 'CARNE', 30.00, 0, 0); 
-- Procedimiento almacenado para el proceso de inscripci�n
go
    ALTER PROCEDURE sp_EnrollmentProcess @NoExpediente VARCHAR(128), @Ciclo VARCHAR(4), @MesInicioPago INT,@CarreraId VARCHAR(128) 
	AS BEGIN 
	-- Variables para informacion
    DECLARE @Apellidos VARCHAR(128); DECLARE @Nombres VARCHAR(128); DECLARE @Direccion VARCHAR(128); DECLARE @Telefono VARCHAR(64); DECLARE @Email VARCHAR(64); DECLARE @JornadaId VARCHAR(128); DECLARE @Expediente VARCHAR(128); -- Variables para generar el carn�
    DECLARE @Exists INT; DECLARE @Carne VARCHAR(8); 
	-- Variables para generar el proceso de pago
    DECLARE @MontoInscripcion DECIMAL(10, 2); DECLARE @NumeroPagos INT; DECLARE @MontoPago DECIMAL(10, 2); 
	DECLARE @DescripcionCuenta VARCHAR(128); DECLARE @Descripcion VARCHAR(128); 
	DECLARE @Prefijo VARCHAR(64); DECLARE @CargoId VARCHAR(128); DECLARE @Monto DECIMAL(10, 2); 
	DECLARE @CorrelativoPagos INT; 
	-- Inicio de transaccion
    BEGIN TRANSACTION; 
	BEGIN TRY
SELECT
    @Apellidos = Apellidos,
    @Nombres = Nombres,
    @Direccion = Direccion,
    @Telefono = Telefono,
    @Email = Email,
    @JornadaId = JornadaId
FROM
    Aspirante
WHERE
    NoExpediente = @NoExpediente;
SET
    @Exists = (SELECT TOP 1 a2.Carne FROM Alumno a2 WHERE SUBSTRING(a2.Carne, 1, 4) = @Ciclo
        ORDER BY a2.Carne DESC); 
	IF @Exists IS NULL BEGIN
SET
    @Carne = (@Ciclo * 1000) + 1;
END;
ELSE BEGIN
SET
    @Carne = (SELECT TOP 1 a2.Carne FROM Alumno a2 WHERE SUBSTRING(a2.Carne, 1, 4) = @Ciclo
        ORDER BY a2.Carne DESC) + 1;
END;
INSERT INTO Alumno (Carne, Apellidos, Nombres, Direccion, Telefono, Email)
	VALUES(@Carne,@Apellidos,@Nombres,@Direccion,@Telefono,CONCAT(@Carne, @Email));
INSERT INTO Inscripcion VALUES(NEWID(),@Ciclo,GETDATE(),@Carne,@CarreraId,@JornadaId);
UPDATE Aspirante SET Estatus = 'INSCRITO CICLO ' + @Ciclo WHERE
    NoExpediente = @NoExpediente; 
	-- Proceso de pagos de inscripción
SELECT @MontoInscripcion = MontoInscripcion, @NumeroPagos = NumeroPagos, @MontoPago = MontoPago
	FROM InversionCarreraTecnica ict WHERE ict.CarreraId = @CarreraId;
SELECT @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo
	FROM Cargo c2 WHERE c2.CargoId = '08F2389A-908E-4D03-92CD-EDE56C061C86';
INSERT INTO CuentaPorCobrar VALUES(CONCAT(@Prefijo,SUBSTRING(@Ciclo, 3, 2),dbo.LPAD('1', 2, '0')),
        @Ciclo, @Descripcion,GETDATE(),GETDATE(),@MontoInscripcion,0,0,@Carne,@CargoId); 
	-- Proceso de pagos de carne
SELECT @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo, @Monto = Monto
	FROM Cargo c2 WHERE c2.CargoId = 'F3C205E6-E7CA-4D29-8709-F8467E33D05C';
INSERT INTO CuentaPorCobrar VALUES(CONCAT(@Prefijo,SUBSTRING(@Ciclo, 3, 2),dbo.LPAD('1', 2, '0')),
        @Ciclo,@Descripcion,GETDATE(),GETDATE(),@Monto,0,0,@Carne,@CargoId); 
		
	-- Cargos mensuales
SET @CorrelativoPagos = 1;
SELECT @CargoId = CargoId, @Descripcion = Descripcion, @Prefijo = Prefijo
	FROM Cargo c2 WHERE c2.CargoId = '23C94A3A-3AC6-4431-83FF-C4E76A0B3D48'; 
WHILE(@CorrelativoPagos <= @NumeroPagos) 
BEGIN
INSERT INTO CuentaPorCobrar VALUES(CONCAT(@Prefijo,SUBSTRING(@Ciclo, 3, 2), dbo.LPAD(@CorrelativoPagos, 2, '0')),
        @Ciclo,@Descripcion,GETDATE(),CONCAT(@Ciclo,'-',dbo.LPAD(@MesInicioPago, 2, '0'),'-','05'),
        @MontoPago,0,0,@Carne,@CargoId);
SET @CorrelativoPagos = @CorrelativoPagos + 1;
SET @MesInicioPago = @MesInicioPago + 1;
END; 
COMMIT TRANSACTION;
SELECT
    'TRANSACTION SUCCESS' AS status, @Carne as carne;
END TRY 
BEGIN CATCH
/*SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;*/
ROLLBACK TRANSACTION;
SELECT 'TRANSACTION ERROR' AS status, 0 as carne;
END CATCH;
END;
go
    EXECUTE sp_EnrollmentProcess 'EXP-2022001','2022',2, '0EC23292-E40E-492A-9A6D-8197976EC947';
go
SELECT * FROM Aspirante a;
go
SELECT * FROM Alumno a2;
go
SELECT * FROM Cargo;
GO
SELECT * FROM Jornada;
go
SELECT * FROM Inscripcion;
GO
SELECT * FROM CarreraTecnica ct;
go
SELECT * FROM InversionCarreraTecnica;
go
select name from sys.key_constraints where type = 'PK'
    and OBJECT_NAME(parent_object_id) = N'CuentasPorCobrar';
go
alter table
    CuentasPorCobrar drop constraint PK__CuentasP__40072E81398CF9C9;
go
/* Para añadir primary key a la tabla de cuenta por cobrar */
alter table CuentaPorCobrar
add primary key(CuentaId, Anio, Carne);
go
SELECT * FROM CuentaPorCobrar cc WHERE cc.Carne = '2022002';
GO
SELECT * FROM InversionCarreraTecnica ict;
go
SELECT CONCAT('INSC', SUBSTRING('2022', 3, 2), dbo.LPAD('1', 2, '0'));
GO
UPDATE Aspirante SET Estatus = 'SIGUE EN PROCESO DE ADMISIÓN' WHERE NoExpediente = 'EXP-2022001';
	/*
    DELETE FROM CuentaPorCobrar WHERE Anio > 0
    DELETE FROM Alumno WHERE Carne > 0
    DELETE FROM Inscripcion WHERE Ciclo > 0
    */
	/* Instrucciones para cambiar el nombre de la columna de carrera tecnica a nombre y el nombre de la tabla cuentas por cobrar en singular*/
go
    EXECUTE sp_rename 'CarreraTecnica.CarreraTecnica',
    'Nombre',
    'COLUMN'; EXECUTE sp_rename 'Jornada.jornada',
    'JornadaTipo',
    'COLUMN';
	EXECUTE sp_rename 'CuentasPorCobrar',
    'CuentaPorCobrar',
    'TABLE';
