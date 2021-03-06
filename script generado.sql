USE [Kalum_Test]
GO
/****** Object:  Table [dbo].[Aspirante]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Aspirante](
	[NoExpediente] [varchar](128) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](64) NOT NULL,
	[Email] [varchar](128) NOT NULL,
	[Estatus] [varchar](32) NULL,
	[CarreraId] [varchar](128) NOT NULL,
	[ExamenId] [varchar](128) NOT NULL,
	[JornadaId] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExamenAdmision]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExamenAdmision](
	[ExamenId] [varchar](128) NOT NULL,
	[FechaExamen] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ExamenId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarreraTecnica]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarreraTecnica](
	[CarreraId] [varchar](128) NOT NULL,
	[Nombre] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CarreraId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vw_ListarAspirantesPorFechaExamen]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vw_ListarAspirantesPorFechaExamen]
AS
SELECT NoExpediente,Apellidos,Nombres,Estatus, FechaExamen,CarreraTecnica FROM Aspirante a 
	INNER JOIN ExamenAdmision ea ON a.ExamenId = ea.ExamenId
		INNER JOIN CarreraTecnica ct on  a.CarreraId = ct.CarreraId 	
GO
/****** Object:  Table [dbo].[Alumno]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alumno](
	[Carne] [varchar](8) NOT NULL,
	[Apellidos] [varchar](128) NOT NULL,
	[Nombres] [varchar](128) NOT NULL,
	[Direccion] [varchar](128) NOT NULL,
	[Telefono] [varchar](64) NOT NULL,
	[Email] [varchar](64) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Cargo]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cargo](
	[CargoId] [varchar](128) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[Prefijo] [varchar](64) NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[GenerarMora] [bit] NOT NULL,
	[PorcentajeMora] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CargoId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CuentaPorCobrar]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CuentaPorCobrar](
	[CuentaId] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[Descripcion] [varchar](128) NOT NULL,
	[FechaCargo] [datetime] NOT NULL,
	[FechaAplica] [datetime] NOT NULL,
	[MontoCargo] [decimal](10, 2) NOT NULL,
	[Mora] [decimal](10, 2) NOT NULL,
	[Descuento] [decimal](10, 2) NOT NULL,
	[Carne] [varchar](8) NOT NULL,
	[CargoId] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CuentaId] ASC,
	[Anio] ASC,
	[Carne] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Inscripcion]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inscripcion](
	[InscripcionId] [varchar](128) NOT NULL,
	[Ciclo] [varchar](4) NOT NULL,
	[FechaInscripcion] [datetime] NOT NULL,
	[Carne] [varchar](8) NULL,
	[CarreraId] [varchar](128) NULL,
	[JornadaId] [varchar](128) NULL,
PRIMARY KEY CLUSTERED 
(
	[InscripcionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InscripcionPago]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InscripcionPago](
	[BoletaPago] [varchar](128) NOT NULL,
	[FechaPago] [datetime] NOT NULL,
	[Monto] [decimal](10, 2) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[NoExpediente] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[BoletaPago] ASC,
	[Anio] ASC,
	[NoExpediente] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[InversionCarreraTecnica]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[InversionCarreraTecnica](
	[InversionId] [varchar](128) NOT NULL,
	[MontoInscripcion] [decimal](10, 2) NOT NULL,
	[NumeroPagos] [int] NOT NULL,
	[MontoPago] [decimal](10, 2) NOT NULL,
	[CarreraId] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[InversionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Jornada]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Jornada](
	[JornadaId] [varchar](128) NOT NULL,
	[JornadaTipo] [varchar](2) NOT NULL,
	[DescripcionJornada] [varchar](128) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[JornadaId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ResultadoExamenAdmision]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ResultadoExamenAdmision](
	[NoExpediente] [varchar](128) NOT NULL,
	[Anio] [varchar](4) NOT NULL,
	[DescripcionResultado] [varchar](128) NOT NULL,
	[Nota] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[NoExpediente] ASC,
	[Anio] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Aspirante] ADD  DEFAULT ('NO ASIGNADO') FOR [Estatus]
GO
ALTER TABLE [dbo].[Cargo] ADD  DEFAULT ((1)) FOR [GenerarMora]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] ADD  DEFAULT ((0)) FOR [Nota]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION] FOREIGN KEY([ExamenId])
REFERENCES [dbo].[ExamenAdmision] ([ExamenId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_EXAMEN_ADMISION]
GO
ALTER TABLE [dbo].[Aspirante]  WITH CHECK ADD  CONSTRAINT [FK_ASPIRANTE_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Aspirante] CHECK CONSTRAINT [FK_ASPIRANTE_JORNADA]
GO
ALTER TABLE [dbo].[CuentaPorCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CUENTAS_POR_COBRAR_CARGO] FOREIGN KEY([CargoId])
REFERENCES [dbo].[Cargo] ([CargoId])
GO
ALTER TABLE [dbo].[CuentaPorCobrar] CHECK CONSTRAINT [FK_CUENTAS_POR_COBRAR_CARGO]
GO
ALTER TABLE [dbo].[CuentaPorCobrar]  WITH CHECK ADD  CONSTRAINT [FK_CUENTAS_POR_COBRAR_CARNE] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[CuentaPorCobrar] CHECK CONSTRAINT [FK_CUENTAS_POR_COBRAR_CARNE]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_ALUMNO] FOREIGN KEY([Carne])
REFERENCES [dbo].[Alumno] ([Carne])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_ALUMNO]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[Inscripcion]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_JORNADA] FOREIGN KEY([JornadaId])
REFERENCES [dbo].[Jornada] ([JornadaId])
GO
ALTER TABLE [dbo].[Inscripcion] CHECK CONSTRAINT [FK_INSCRIPCION_JORNADA]
GO
ALTER TABLE [dbo].[InscripcionPago]  WITH CHECK ADD  CONSTRAINT [FK_INSCRIPCION_PAGO_ASPIRANTE] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[InscripcionPago] CHECK CONSTRAINT [FK_INSCRIPCION_PAGO_ASPIRANTE]
GO
ALTER TABLE [dbo].[InversionCarreraTecnica]  WITH CHECK ADD  CONSTRAINT [FK_INVERSION_CARRERA_TECNICA] FOREIGN KEY([CarreraId])
REFERENCES [dbo].[CarreraTecnica] ([CarreraId])
GO
ALTER TABLE [dbo].[InversionCarreraTecnica] CHECK CONSTRAINT [FK_INVERSION_CARRERA_TECNICA]
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision]  WITH CHECK ADD  CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE] FOREIGN KEY([NoExpediente])
REFERENCES [dbo].[Aspirante] ([NoExpediente])
GO
ALTER TABLE [dbo].[ResultadoExamenAdmision] CHECK CONSTRAINT [FK_RESULTADO_EXAMEN_ADMISION_ASPIRANTE]
GO
/****** Object:  StoredProcedure [dbo].[sp_EnrollmentProcess]    Script Date: 7/9/2022 8:53:31 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
    CREATE PROCEDURE [dbo].[sp_EnrollmentProcess] @NoExpediente VARCHAR(128), @Ciclo VARCHAR(4), @MesInicioPago INT,@CarreraId VARCHAR(128) 
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
GO
