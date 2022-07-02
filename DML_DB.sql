USE Kalum_Test
go
SELECT * FROM Aspirante a
go
SELECT * FROM ExamenAdmision ea
go
SELECT * FROM CarreraTecnica ct
go
SELECT * FROM Jornada j
go
INSERT INTO CarreraTecnica(CarreraId,CarreraTecnica) VALUES (NEWID(),'Desarrollo de aplicaciones empresariales con .NET Core');
go
INSERT INTO CarreraTecnica(CarreraId,CarreraTecnica) VALUES (NEWID(),'Desarrollo de aplicaciones empresariales con Java EE');
go
INSERT INTO CarreraTecnica(CarreraId,CarreraTecnica) VALUES (NEWID(),'Desarrollo de aplicaciones moviles con Android Studio');
go
INSERT INTO ExamenAdmision (ExamenId,FechaExamen) VALUES (NEWID(), '2022-04-30');
go
INSERT INTO ExamenAdmision (ExamenId,FechaExamen) VALUES (NEWID(), '2022-05-07');
go
INSERT INTO ExamenAdmision (ExamenId,FechaExamen) VALUES (NEWID(), '2022-05-14');
go
INSERT INTO Jornada (JornadaId,Jornada,DescripcionJornada) VALUES (NEWID(), 'JM', 'Jornada Matutina');
go
INSERT INTO Jornada (JornadaId,Jornada,DescripcionJornada) VALUES (NEWID(), 'JV', 'Jornada Vespertina');
go
INSERT INTO Aspirante (NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
	VALUES ('EXP-2022001', 'Flores Pérez', 'Alvaro Jesús', 'Guatemala', '58778968', 'aflores@kalum.edu.gt',
	'0EC23292-E40E-492A-9A6D-8197976EC947', '650DD767-22C5-4E36-B59F-25285E664189','C6C84918-1B2B-402C-9F75-E5783BE7D2E0');
go
INSERT INTO Aspirante (NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
	VALUES ('EXP-2022002', 'Medina Morales','Alexander Moisés','Guatemala','65442011','amedina@kalum.edu.gt',
	'4F8DCB8C-C482-47DE-A4C0-07E50B0CD449','12C15E6E-0EDD-4722-A6A5-B99344CBB4B6','F218C023-1ACD-4BD2-A82D-1B4C03B7FECE');
go
INSERT INTO Aspirante (NoExpediente,Apellidos,Nombres,Direccion,Telefono,Email,CarreraId,ExamenId,JornadaId) 
	VALUES ('EXP-2022003', 'Juarez Lopez', 'Sergio Raúl', 'Guatemala','45705500','sjuarez@kalum.edu.gt',
	'C6D900AA-805D-4CE4-85F3-B2AA9E42E44C','8C7726EA-9BCA-40B6-9E8E-5E0FD3E5A30D','F218C023-1ACD-4BD2-A82D-1B4C03B7FECE');

-- CONSULTAS
-- 01 Mostrar los aspirantes que se van a examinar el día 30 de abril
go
SELECT NoExpediente,Apellidos,Nombres,Estatus, FechaExamen,CarreraTecnica FROM Aspirante a 
	INNER JOIN ExamenAdmision ea ON a.ExamenId = ea.ExamenId
		INNER JOIN CarreraTecnica ct on  a.CarreraId = ct.CarreraId 
			WHERE ea.FechaExamen = '2022-04-30' ORDER BY a.Apellidos;

-- VISTAS
go
CREATE VIEW vw_ListarAspirantesPorFechaExamen
AS
SELECT NoExpediente,Apellidos,Nombres,Estatus, FechaExamen,CarreraTecnica FROM Aspirante a 
	INNER JOIN ExamenAdmision ea ON a.ExamenId = ea.ExamenId
		INNER JOIN CarreraTecnica ct on  a.CarreraId = ct.CarreraId 	
go
SELECT * FROM vw_ListarAspirantesPorFechaExamen WHERE FechaExamen = '2022-04-30' ORDER BY Apellidos;
go
SELECT * FROM ResultadoExamenAdmision rea

-- Trigger
go
CREATE TRIGGER tg_ActualizarEstadoAspirante ON ResultadoExamenAdmision AFTER INSERT
AS
	BEGIN
		DECLARE @Nota INT = 0
		DECLARE @Expediente VARCHAR(128)
		DECLARE @Estatus VARCHAR(64) = 'NO ASIGNADO'
		SET @Nota = (SELECT Nota FROM inserted)
		SET @Expediente = (SELECT NoExpediente FROM inserted)
		IF @Nota >= 70
			BEGIN
				SET @Estatus = 'SIGUE EN PROCESO DE ADMISIÓN'
			END
		ELSE
			BEGIN
				SET @Estatus = 'NO SIGUE EN PROCESO DE ADMISIÓN'
			END
		UPDATE Aspirante SET estatus = @Estatus WHERE NoExpediente = @Expediente
	END
go
INSERT INTO ResultadoExamenAdmision (NoExpediente,Anio,DescripcionResultado,Nota) VALUES ('EXP-2022003','2022','Resultado examen',75)
go
SELECT * FROM ResultadoExamenAdmision rea
SELECT * FROM Aspirante a

-- Store procedure

