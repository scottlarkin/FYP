USE [master]
GO
/****** Object:  Database [RoutineManagement]    Script Date: 12/2/2015 12:06:37 ******/
CREATE DATABASE [RoutineManagement]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'RoutineManagement', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RoutineManagement.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'RoutineManagement_log', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\RoutineManagement_log.ldf' , SIZE = 2048KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [RoutineManagement] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [RoutineManagement].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [RoutineManagement] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [RoutineManagement] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [RoutineManagement] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [RoutineManagement] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [RoutineManagement] SET ARITHABORT OFF 
GO
ALTER DATABASE [RoutineManagement] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [RoutineManagement] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [RoutineManagement] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [RoutineManagement] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [RoutineManagement] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [RoutineManagement] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [RoutineManagement] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [RoutineManagement] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [RoutineManagement] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [RoutineManagement] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [RoutineManagement] SET  DISABLE_BROKER 
GO
ALTER DATABASE [RoutineManagement] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [RoutineManagement] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [RoutineManagement] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [RoutineManagement] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [RoutineManagement] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [RoutineManagement] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [RoutineManagement] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [RoutineManagement] SET RECOVERY FULL 
GO
ALTER DATABASE [RoutineManagement] SET  MULTI_USER 
GO
ALTER DATABASE [RoutineManagement] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [RoutineManagement] SET DB_CHAINING OFF 
GO
ALTER DATABASE [RoutineManagement] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [RoutineManagement] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [RoutineManagement]
GO
/****** Object:  UserDefinedTableType [dbo].[ChecksheetList]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[ChecksheetList] AS TABLE(
	[ID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldList]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[FieldList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[TypeID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldListWithID]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[FieldListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[TypeID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldValueList]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[FieldValueList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Value] [nvarchar](max) NULL,
	[Editable] [nvarchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldValueListWithID]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[FieldValueListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Value] [nvarchar](max) NULL,
	[Editable] [nvarchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[RecordList]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[RecordList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[RecordListWithID]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[RecordListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[ScheduledRoutine]    Script Date: 12/2/2015 12:06:37 ******/
CREATE TYPE [dbo].[ScheduledRoutine] AS TABLE(
	[TeamID] [int] NULL,
	[AssignedUserID] [int] NULL,
	[DueOn] [datetime] NULL,
	[CompletedOn] [datetime] NULL,
	[CompletedByID] [int] NULL,
	[RoutineID] [int] NULL
)
GO
/****** Object:  StoredProcedure [dbo].[AreaGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AreaGet]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT Name FROM Area;

END

GO
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RegisterUser]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	if (SELECT ID FROM dbo.[User] WHERE Name = SYSTEM_USER) IS NULL
	BEGIN
		INSERT INTO dbo.[User](Name) Values(SYSTEM_USER);
	END;

END

GO
/****** Object:  StoredProcedure [dbo].[RoutineGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RoutineGet]
	-- Add the parameters for the stored procedure here
	@RoutineID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--Optimise for selecting 
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT Name, [Description], ID FROM dbo.Routine WHERE ID = @RoutineID;

	

	SELECT Name [ChecksheetName], 
		(SELECT COUNT(*)
			FROM dbo.Record r
			INNER JOIN dbo.ChecksheetRecord csr ON csr.RecordID = r.ID
			INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csr.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID
			AND rcs.ChecksheetID = cs.ID) [RecordCount],
		(SELECT COUNT(*)
			FROM dbo.Field f
			INNER JOIN dbo.ChecksheetField csf ON csf.FieldID = f.ID
			INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csf.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID
			AND rcs.ChecksheetID = cs.ID) [FieldCount]
		FROM Checksheet cs
		INNER JOIN dbo.RoutineChecksheet rcs ON cs.ID = rcs.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID;

	SELECT	f.Name	 [FieldName],
			f.TypeID [FieldTypeID]
		FROM dbo.Field f
		INNER JOIN dbo.ChecksheetField csf ON csf.FieldID = f.ID
		INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csf.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID
		ORDER BY rcs.OrderNUmber, csf.OrderNumber;

	SELECT	r.Name [RecordName]
		FROM dbo.Record r
		INNER JOIN dbo.ChecksheetRecord csr ON csr.RecordID = r.ID
		INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csr.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID
		ORDER BY rcs.OrderNUmber;

	SELECT	Value
		FROM ChecksheetRecordFieldValue csfv
		INNER JOIN dbo.RoutineChecksheet rcs ON csfv.ChecksheetID = rcs.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID;

END

GO
/****** Object:  StoredProcedure [dbo].[RoutineNameByArea]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RoutineNameByArea]
	-- Add the parameters for the stored procedure here
	@AreaName NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT Routine.Name FROM Routine
		INNER JOIN RoutineArea on Routine.ID = RoutineArea.RoutineID
		INNER JOIN Area ON Area.ID = RoutineArea.AreaID
		WHERE Area.Name IN 
			(SELECT NAME 
				FROM dbo.GetAreaWithChildren(
					(SELECT TOP 1 ID
						FROM Area 
						WHERE Name = @AreaName
					))
			 );	

END

GO
/****** Object:  StoredProcedure [dbo].[RoutineSave]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: Oct 2015
-- Description:	Update / Create a Routine
-- =============================================
CREATE PROCEDURE [dbo].[RoutineSave]
	-- Add the parameters for the stored procedure here
	@RoutineID		INT = NULL,	
	@Name			NVARCHAR(MAX),
	@Description	NVARCHAR(MAX),
	@Checksheets	dbo.ChecksheetList	READONLY,
	@Records		dbo.RecordList		READONLY,
	@Fields			dbo.FieldList		READONLY,
	@FieldValues	dbo.FieldValueList	READONLY,
	@Area			NVARCHAR(MAX)
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserID		INT = (SELECT ID FROM dbo.[User] WHERE Name = SYSTEM_USER),
			@CS_Counter INT = 1,
			@CS_Count	INT = (SELECT COUNT(*) FROM @Checksheets),
			@AreaID		INT	= (SELECT ID FROM dbo.Area WHERE Name = @Area);

	IF @RoutineID IS NULL
	BEGIN
		INSERT INTO dbo.Routine(Name, CreatedByID, [Description])
			VALUES(@Name, @UserID, @Description);

		SET @RoutineID = SCOPE_IDENTITY();

		INSERT INTO dbo.RoutineArea(RoutineID, AreaID)
			VALUES(@RoutineID, @AreaID);
	END;
	ELSE
	BEGIN
		UPDATE dbo.Routine
			SET Name = @Name,
				[Description] = @Description;
	END;

	WHILE @CS_Counter <= @CS_Count
	BEGIN
		
		DECLARE @CS_Name		NVARCHAR(MAX) = (SELECT Name FROM @Checksheets WHERE ID = @CS_Counter),
				@CS_ID			INT,
				@R_Counter		INT = 1,
				@F_Counter		INT = 1,
				@R_Count		INT = (SELECT COUNT(*) FROM @Records WHERE ChecksheetID = @CS_Counter),
				@F_Count		INT = (SELECT COUNT(*) FROM @Fields WHERE ChecksheetID = @CS_Counter),
				@RecordsT		dbo.RecordListWithID,
				@FieldsT		dbo.FieldListWithID,
				@FieldValuesT	dbo.FieldValueListWithID,
				@F_ID			INT,
				@FV_Counter		INT = 1;

		DECLARE @FieldsWithID	TABLE(ID INT, Idx INT, Name NVARCHAR(MAX));

		DELETE FROM @RecordsT;
		INSERT INTO @RecordsT
			SELECT * FROM @Records WHERE ChecksheetID = @CS_Counter;

		DELETE FROM @FieldsT;
		INSERT INTO @FieldsT
			SELECT * FROM @Fields WHERE ChecksheetID = @CS_Counter;

		DELETE FROM @FieldValuesT;
		INSERT INTO @FieldValuesT
			SELECT * FROM @FieldValues WHERE ChecksheetID = @CS_Counter;

		SET @CS_ID = (SELECT TOP 1 ID
							FROM dbo.Checksheet cs 
							INNER JOIN dbo.RoutineChecksheet rcs ON rcs.RoutineID = @RoutineID
							WHERE cs.Name = @CS_Name
							AND rcs.RoutineID = @RoutineID);

		UPDATE dbo.RoutineChecksheet SET OrderNumber = -1 WHERE OrderNumber = @CS_Counter AND RoutineID = @RoutineID;

		IF @CS_ID IS NULL
		BEGIN
			INSERT INTO dbo.Checksheet(Name, CreatedByID)
				VALUES(@CS_Name, @UserID);

			SET @CS_ID = SCOPE_IDENTITY();

			INSERT INTO dbo.RoutineChecksheet(RoutineID, ChecksheetID, OrderNumber)
				VALUES(@RoutineID, @CS_ID, @CS_Counter);
		END;
		ELSE
		BEGIN
			UPDATE dbo.Checksheet SET Name = @CS_Name WHERE ID = @CS_ID;
			UPDATE dbo.RoutineChecksheet SET OrderNumber = @CS_Counter WHERE RoutineID = @RoutineID AND	 ChecksheetID = @CS_ID;
		END;

		DELETE FROM dbo.ChecksheetField WHERE ChecksheetID = @CS_ID;
		DELETE FROM @FieldsWithID;

		WHILE @F_Counter <= @F_Count
		BEGIN
			DECLARE	@F_Name NVARCHAR(MAX)	= (SELECT Name FROM @FieldsT ORDER BY ID OFFSET @F_Counter-1 ROWS FETCH NEXT 1 ROWS ONLY);
			DECLARE @TypeID INT				= (SELECT TypeID FROM @FieldsT ORDER BY ID OFFSET @F_Counter-1 ROWS FETCH NEXT 1 ROWS ONLY);
			SET		@F_ID					= (SELECT ID FROM dbo.Field WHERE Name = @F_Name AND TypeID = @typeID);

			IF @F_ID IS NULL
			BEGIN
				INSERT INTO dbo.Field(Name, TypeID, CreatedByID)
					VALUES(@F_Name, @TypeID, @UserID);

				SET	@F_ID = SCOPE_IDENTITY();
			END;

			INSERT INTO @FieldsWithID(ID, Idx, Name)
				VALUES(@F_ID, @F_Counter, @F_Name);

			INSERT INTO dbo.ChecksheetField(ChecksheetID, FieldID, OrderNumber)
				VALUES(@CS_ID, @F_ID, @F_Counter);

			SET @F_Counter = @F_Counter + 1;
		END; --FIELD LOOP END
		
		DELETE FROM dbo.ChecksheetRecord WHERE ChecksheetID = @CS_ID;

		SET @F_Counter = 1;

		WHILE @R_Counter <= @R_Count
		BEGIN
			DECLARE	@R_Name NVARCHAR(MAX)	= (SELECT Name FROM @RecordsT ORDER BY ID OFFSET @R_Counter-1 ROWS FETCH NEXT 1 ROWS ONLY);
			DECLARE	@R_ID	INT				= (SELECT ID FROM dbo.Record WHERE Name = @R_Name);

			IF @R_ID IS NULL
			BEGIN
				INSERT INTO dbo.Record(Name, CreatedByID)
					VALUES(@R_Name, @UserID);

				SET @R_ID = SCOPE_IDENTITY();
			END;

			INSERT INTO dbo.ChecksheetRecord(ChecksheetID, RecordID, OrderNumber)
				VALUES(@CS_ID, @R_ID, @R_Counter);

			IF @R_Counter > 1
			BEGIN
				WHILE @F_Counter <= @F_Count
				BEGIN

					SET @F_ID = (SELECT ID FROM @FieldsWithID WHERE Idx = @F_Counter);

					INSERT INTO dbo.ChecksheetRecordFieldValue(ChecksheetID, RecordID, FieldID, Value)
						VALUES(@CS_ID, @R_ID, @F_ID, (SELECT Value FROM @FieldValuesT ORDER BY ID OFFSET @FV_Counter-1 ROWS FETCH NEXT 1 ROWS ONLY));

					SET @FV_Counter = @FV_Counter + 1;
					SET @F_Counter = @F_Counter + 1;
				END;--FIELD LOOP END
			END;--IF END

			SET @F_Counter = 1;
			SET @R_Counter = @R_Counter + 1;
		END; --RECORD LOOP END

		SET @CS_Counter = @CS_Counter + 1;
	END;--CHECKSHEET LOOP END

	DELETE FROM dbo.RoutineChecksheet WHERE (OrderNumber > @CS_Count OR OrderNumber = -1) AND RoutineID = @RoutineID;
    
END



GO
/****** Object:  StoredProcedure [dbo].[ScheduledRoutineGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ScheduledRoutineGet]
	-- Add the parameters for the stored procedure here
	@scheduleID INT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE @RoutineID INT = (SELECT ID
								FROM dbo.Routine
								WHERE ID = (
									SELECT RoutineID
										FROM dbo.Schedule
										WHERE ID = @scheduleID
									 )
								),
			@AlreadySaved BIT = (SELECT
								 CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END 
								 FROM dbo.ScheduleFieldValue
								 WHERE ScheduleID = @ScheduleID) 

	SELECT Name, [Description], ID FROM dbo.Routine WHERE ID = @RoutineID;

	IF @AlreadySaved = 0
	BEGIN

		SELECT Name [ChecksheetName], 
			(SELECT COUNT(*)
				FROM dbo.Record r
				INNER JOIN dbo.ChecksheetRecord csr ON csr.RecordID = r.ID
				INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csr.ChecksheetID
				WHERE rcs.RoutineID = @RoutineID
				AND rcs.ChecksheetID = cs.ID) [RecordCount],
			(SELECT COUNT(*)
				FROM dbo.Field f
				INNER JOIN dbo.ChecksheetField csf ON csf.FieldID = f.ID
				INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csf.ChecksheetID
				WHERE rcs.RoutineID = @RoutineID
				AND rcs.ChecksheetID = cs.ID) [FieldCount]
			FROM Checksheet cs
			INNER JOIN dbo.RoutineChecksheet rcs ON cs.ID = rcs.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID;

		SELECT	f.Name	 [FieldName],
				f.TypeID [FieldTypeID]
			FROM dbo.Field f
			INNER JOIN dbo.ChecksheetField csf ON csf.FieldID = f.ID
			INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csf.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID
			ORDER BY rcs.OrderNumber;

		SELECT	r.Name [RecordName]
			FROM dbo.Record r
			INNER JOIN dbo.ChecksheetRecord csr ON csr.RecordID = r.ID
			INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csr.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID
			ORDER BY rcs.OrderNumber;

		SELECT	Value [Value],
				CASE
					WHEN Value IS NULL THEN
						'true'
					ELSE
						'false'
				END [Editable]
			FROM dbo.ChecksheetRecordFieldValue csfv
			INNER JOIN dbo.RoutineChecksheet rcs ON csfv.ChecksheetID = rcs.ChecksheetID
			WHERE rcs.RoutineID = @RoutineID;
    
	END;
	ELSE
	BEGIN

		SELECT DISTINCT(cs.Name) [ChecksheetName], 
			(SELECT COUNT(DISTINCT(RecordID))
				FROM dbo.ScheduleFieldValue sfv 
				INNER JOIN dbo.Checksheet cs ON cs.ID = sfv.ChecksheetID
				WHERE sfv.ScheduleID = @scheduleID
				AND sfv.ChecksheetID = cs.ID) [RecordCount],
			(SELECT COUNT(DISTINCT(FieldID))
				FROM dbo.ScheduleFieldValue sfv 
				INNER JOIN dbo.Checksheet cs ON cs.ID = sfv.ChecksheetID
				WHERE sfv.ScheduleID = @scheduleID
				AND sfv.ChecksheetID = cs.ID) [FieldCount]
			FROM dbo.ScheduleFieldValue sfv 
			INNER JOIN dbo.Checksheet cs ON cs.ID = sfv.ChecksheetID
			WHERE ScheduleID = @scheduleID;

		SELECT	f.Name	 [FieldName],
				f.TypeID [FieldTypeID]
			FROM dbo.Field f
			INNER JOIN dbo.ScheduleFieldValue sfv ON f.ID = sfv.FieldID
			GROUP BY f.Name, f.TypeID;
			
		SELECT	r.Name [RecordName]
			FROM dbo.Record r
			INNER JOIN dbo.ScheduleFieldValue sfv ON r.ID = sfv.RecordID
			WHERE sfv.FieldID IS NULL
		UNION ALL
		SELECT	r.Name [RecordName]
			FROM dbo.Record r
			INNER JOIN dbo.ScheduleFieldValue sfv ON r.ID = sfv.RecordID
			WHERE sfv.FieldID IS NOT NULL
			GROUP BY r.Name;

		SELECT	Value [Value],
				CASE WHEN Editable = 1 THEN 'true' ELSE 'false' END [Editable]
			FROM dbo.ScheduleFieldValue sfv
			WHERE ScheduleID = @scheduleID
			AND sfv.FieldID IS NOT NULL;

	END;

END

GO
/****** Object:  StoredProcedure [dbo].[ScheduledRoutineSave]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ScheduledRoutineSave]
	-- Add the parameters for the stored procedure here
	@ScheduleID		INT,
	@FieldValuesT	dbo.FieldValueList	READONLY
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @FieldValues dbo.FieldValueListWithID;
		
	INSERT INTO @FieldValues(Value, Editable, ChecksheetID)
		SELECT Value, Editable, 0 FROM @FieldValuesT;

	DECLARE @RoutineID			INT = (SELECT RoutineID FROM dbo.Schedule WHERE ID = @ScheduleID );

	--Check if this is the 1st time we are saving this schedule.
	DECLARE @Updating			BIT = (SELECT CASE WHEN COUNT(*) > 0 THEN 1 ELSE 0 END FROM dbo.ScheduleFieldValue WHERE ScheduleID = @ScheduleID) 
	 
	
	DECLARE	@ChecksheetCount	INT,
			@CS_Counter			INT = 1,
			@FV_Count			INT = 1;

	--get number of checksheets
	IF @Updating = 1
	BEGIN
		SET @ChecksheetCount = (SELECT COUNT(ChecksheetID) FROM dbo.ScheduleFieldValue WHERE ScheduleID = @ScheduleID GROUP BY ChecksheetID);

		DECLARE @Checksheets TABLE(CSID INT, OrderNumber INT);
		
		INSERT INTO @Checksheets
			SELECT ChecksheetID, ID FROM dbo.ScheduleFieldValue WHERE ScheduleID = @ScheduleID ORDER BY ID DESC;

	END;
	ELSE
		SET @ChecksheetCount = (SELECT COUNT(*) FROM dbo.RoutineChecksheet WHERE RoutineID = @RoutineID);


	WHILE @CS_Counter <= @ChecksheetCount
	BEGIN

		DECLARE @CS_ID		INT;
		DECLARE	@Fields		TABLE(ID INT IDENTITY(1,1), FID INT);
		DECLARE	@Records	TABLE(ID INT IDENTITY(1,1), RID INT);
		DECLARE @R_Counter	INT = 1,
				@F_Counter	INT = 1;
	
		DELETE FROM @Fields;
		DELETE FROM @Records;
		
		IF @Updating = 1
		BEGIN
			WITH cs AS (SELECT DISTINCT(CSID), OrderNumber FROM @Checksheets ORDER BY OrderNumber OFFSET @CS_Counter - 1 ROWS FETCH NEXT 1 ROWS ONLY)
				SELECT @CS_ID = cs.CSID FROM cs;

			INSERT INTO @Fields
				SELECT DISTINCT(FieldID) FROM dbo.ScheduleFieldValue WHERE ScheduleID = @ScheduleID AND ChecksheetID = @CS_ID;

			INSERT INTO @Records
				SELECT DISTINCT(RecordID) FROM dbo.ScheduleFieldValue WHERE ScheduleID = @ScheduleID AND ChecksheetID = @CS_ID;			

		END;
		ELSE
		BEGIN
			
			SET @CS_ID = (SELECT ChecksheetID FROM dbo.RoutineChecksheet WHERE RoutineID = @RoutineID AND OrderNUmber = @CS_Counter);

			INSERT INTO @Fields
				SELECT FieldID FROM dbo.ChecksheetField WHERE ChecksheetID = @CS_ID;

			INSERT INTO @Records
				SELECT RecordID FROM dbo.ChecksheetRecord WHERE ChecksheetID = @CS_ID;
			
		END;

		WHILE @R_Counter <= (SELECT COUNT(*) FROM @Records)
		BEGIN

			IF @R_Counter = 1
			BEGIN
				IF @Updating = 0
				BEGIN
					INSERT INTO dbo.ScheduleFieldValue(
							ScheduleID,
							ChecksheetID,
							RecordID
						)
						VALUES(
							@ScheduleID,
							@CS_ID,
							(SELECT RID FROM @Records WHERE ID = 1)
						)
				END;
				ELSE 
				BEGIN
					UPDATE dbo.ScheduleFieldValue
						SET Value = 'test'
				END;

				SET @R_Counter = @R_Counter + 1;
				CONTINUE;
			END;

			DECLARE @R_ID INT = (SELECT RID FROM @Records WHERE ID = @R_Counter);

			WHILE @F_Counter <= (SELECT COUNT(*) FROM @Fields)
			BEGIN

				DECLARE @FieldValue NVARCHAR(MAX),
						@Editable	NVARCHAR(10),
						@F_ID		INT = (SELECT FID FROM @Fields WHERE ID = @F_Counter);

				WITH fv AS (SELECT Value, Editable FROM @FieldValues WHERE ID = @FV_Count)
					SELECT @FieldValue = fv.Value, 
						   @Editable = fv.Editable
						FROM fv;

				IF @Updating = 1
				BEGIN
					
					UPDATE dbo.ScheduleFieldValue
						SET Value = @FieldValue,
							Editable = @Editable
						WHERE ScheduleID = @ScheduleID
						AND ChecksheetID = @CS_ID
						AND RecordID = @R_ID
						AND FieldID = @F_ID

				END;
				ELSE
				BEGIN
					
					INSERT INTO dbo.ScheduleFieldValue(
							ScheduleID,
							ChecksheetID,
							RecordID,
							FieldID,
							Value,
							Editable
						)
						VALUES(
							@ScheduleID,
							@CS_ID,
							@R_ID,
							@F_ID,
							@FieldValue,
							@Editable
						)

				END;

				SET @FV_Count = @FV_Count + 1;
				SET @F_Counter = @F_Counter + 1;
			END;
			SET @F_Counter = 1;
			SET @R_Counter = @R_Counter + 1;
		END;

		SET @CS_Counter = @CS_Counter + 1;
	END;

END

GO
/****** Object:  StoredProcedure [dbo].[ScheduleGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ScheduleGet]
	-- Add the parameters for the stored procedure here
	
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	 
	SELECT	s.ID		  ScheduleID,
			r.ID		  RoutineID,
			r.Name		  Routine,
			a.Name		  Area,
			(SELECT Name 
				FROM dbo.Team
				WHERE ID = s.AssignedTeamID
			)			  AssignedTeam,
			(SELECT Name
				FROM dbo.[User]
				WHERE ID = s.AssignedToUserID
			)			  AssignedUser,
			CONVERT(VARCHAR(11),s.DueOn,6)	  DueOn,
			CONVERT(VARCHAR(11),s.CompletedOn,6) CompletedOn,
			(SELECT Name
				FROM dbo.[User]
				WHERE ID = s.CompletedByID
			)             CompletedBy

		FROM Schedule s
		INNER JOIN dbo.Routine r on r.ID = s.RoutineID
		INNER JOIN dbo.RoutineArea ra ON ra.RoutineID = r.ID
		INNER JOIN dbo.Area a ON ra.AreaID = a.ID
		
		ORDER BY s.DueOn DESC;

END


GO
/****** Object:  StoredProcedure [dbo].[ScheduleRoutine]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[ScheduleRoutine]
	-- Add the parameters for the stored procedure here
	@Routine NVARCHAR(MAX),
	@Team	NVARCHAR(MAX),
	@User NVARCHAR(MAX) = NULL,
	@DateFor DATETIME,
	@Rate INT,
	@Period NVARCHAR(MAX),
	@Number INT
AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @RoutineID INT = (SELECT Routine.ID
								  FROM dbo.Routine
								  WHERE	 Routine.Name = @Routine 
							  ),
			@TeamID	 INT = (SELECT Team.ID 
								FROM dbo.Team
								WHERE Team.Name = @Team
							),
			@Counter INT = 1;
		

	WHILE @Counter <= @Number
	BEGIN

		INSERT INTO dbo.Schedule(
			CreatedByID,
			AssignedToUserID,
			AssignedTeamID,
			DueOn,
			RoutineID
			)
			VALUES(
			dbo.UserIdByName(SYSTEM_USER),
			dbo.UserIdByName(@User),
			@TeamID,
			CASE 
				WHEN @Period = 'Days' THEN DATEADD(DAY, (@Counter - 1) * @Rate, @DateFor)
				WHEN @Period = 'Weeks' THEN DATEADD(WEEK, (@Counter - 1) * @Rate, @DateFor)
				WHEN @Period = 'Months' THEN DATEADD(MONTH, (@Counter - 1) * @Rate, @DateFor)
				WHEN @Period = 'Years' THEN DATEADD(YEAR, (@Counter - 1) * @Rate, @DateFor)
			END
			,
			@RoutineID
			)

			SET @Counter = @Counter + 1;
	END;

    
END

GO
/****** Object:  StoredProcedure [dbo].[TeamByAreaGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TeamByAreaGet]
	-- Add the parameters for the stored procedure here
	@AreaName NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT Team.Name FROM Team
		INNER JOIN TeamArea ON Team.ID = TeamArea.TeamID
		INNER JOIN Area ON Area.ID = TeamArea.AreaID
		WHERE Area.Name IN 
			(SELECT NAME 
				FROM dbo.GetAreaWithChildren(
					(SELECT TOP 1 ID
						FROM Area 
						WHERE Name = @AreaName
					))
			 );	

END

GO
/****** Object:  StoredProcedure [dbo].[TypeGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TypeGet]
	-- Add the parameters for the stored procedure here
	@TypeID INT = NULL
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

    -- Insert statements for procedure here
	SELECT ID, Name, HTMLType 
		FROM dbo.[Type]
		WHERE @TypeID IS NULL OR ID = @TypeID;
END

GO
/****** Object:  StoredProcedure [dbo].[UsersByTeamGet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[UsersByTeamGet]
	-- Add the parameters for the stored procedure here
	@TeamName NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	SELECT [User].Name FROM [User]
		INNER JOIN UserTeam ON [User].ID = UserTeam.UserID
		INNER JOIN Team ON Team.ID = UserTeam.TeamID
		WHERE Team.Name = @TeamName;	

END

GO
/****** Object:  StoredProcedure [dbo].[ValidateRoutineName]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Checks if an area, or any parent/ child areas already have a routine of the given name
-- =============================================
CREATE PROCEDURE [dbo].[ValidateRoutineName]
	-- Add the parameters for the stored procedure here
	@RoutineName NVARCHAR(MAX),
	@Area NVARCHAR(MAX)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;

	DECLARE @AreaID INT = (SELECT ID FROM dbo.Area WHERE Name = @Area);

	IF(
		SELECT COUNT(*)
			FROM dbo.Routine r
			INNER JOIN dbo.RoutineArea ra ON r.ID = ra.RoutineID
			WHERE r.Name = @RoutineName
			AND ra.AreaID IN (SELECT ID FROM dbo.GetAreaWithParents(@AreaID) 
							  UNION ALL
							  SELECT ID FROM dbo.GetAreaWithChildren(@AreaID)
							  )
		) = 0
		SELECT 'OK';
	ELSE
		SELECT 'Error';
 
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetAreaWithChildren]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	Recursive CTE to get all children of a area.
-- =============================================
CREATE FUNCTION [dbo].[GetAreaWithChildren]
(	
	@AreaID INT = 1
)
RETURNS @ret TABLE (ID INT, Name NVARCHAR(MAX))
AS
BEGIN

	WITH a(ID, Name) AS 
	(
		SELECT ID, Name
			FROM Area
			WHERE ID = @AreaID
		UNION ALL
		SELECT Area.ID, Area.Name
			FROM Area
			INNER JOIN a ON Area.ParentID = a.ID
	)

	INSERT INTO @ret
		SELECT ID, Name FROM a;

	RETURN;
END

GO
/****** Object:  UserDefinedFunction [dbo].[GetAreaWithParents]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		Scott Larkin
-- Create date: <Create Date,,>
-- Description:	
-- =============================================
CREATE FUNCTION [dbo].[GetAreaWithParents]
(	
	@AreaID INT = 1
)
RETURNS @ret TABLE (ID INT, Name NVARCHAR(MAX))
AS
BEGIN

	WITH a(ID, Name, PID) AS 
	(
		SELECT ID, Name, ParentID
			FROM Area
			WHERE ID = @AreaID
		UNION ALL
		SELECT Area.ID, Area.Name, Area.ParentID
			FROM Area
			INNER JOIN a ON Area.ID = a.PID
	)

	INSERT INTO @ret
		SELECT ID, Name FROM a;

	RETURN;
END

GO
/****** Object:  UserDefinedFunction [dbo].[UserIdByName]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[UserIdByName]
(
	-- Add the parameters for the function here
	@Name NVARCHAR(MAX)
)
RETURNS INT
AS
BEGIN
	-- Declare the return variable here
	RETURN (SELECT TOP 1 ID FROM dbo.[User] WHERE Name = @Name)

END

GO
/****** Object:  Table [dbo].[Area]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Area](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[ParentID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Checksheet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Checksheet](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChecksheetField]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksheetField](
	[ChecksheetID] [int] NULL,
	[FieldID] [int] NULL,
	[OrderNumber] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChecksheetRecord]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksheetRecord](
	[ChecksheetID] [int] NULL,
	[RecordID] [int] NULL,
	[OrderNumber] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ChecksheetRecordFieldValue]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksheetRecordFieldValue](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [int] NULL,
	[RecordID] [int] NULL,
	[FieldID] [int] NULL,
	[Value] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Field]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Field](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NOT NULL,
	[TypeID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Record]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Record](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Routine]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routine](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NULL,
	[Description] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoutineArea]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoutineArea](
	[RoutineID] [int] NULL,
	[AreaID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoutineChecksheet]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoutineChecksheet](
	[RoutineID] [int] NULL,
	[ChecksheetID] [int] NULL,
	[OrderNUmber] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NOT NULL,
	[AssignedToUserID] [int] NULL,
	[DueOn] [datetime] NOT NULL,
	[CompletedOn] [datetime] NULL,
	[CompletedByID] [int] NULL,
	[RoutineID] [int] NOT NULL,
	[AssignedTeamID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ScheduleFieldValue]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ScheduleFieldValue](
	[ScheduleID] [int] NULL,
	[ChecksheetID] [int] NULL,
	[RecordID] [int] NULL,
	[FieldID] [int] NULL,
	[Value] [nvarchar](max) NULL,
	[Editable] [bit] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TeamArea]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamArea](
	[TeamID] [int] NOT NULL,
	[AreaID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Type]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Type](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[HtmlType] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[User]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserTeam]    Script Date: 12/2/2015 12:06:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTeam](
	[UserID] [int] NOT NULL,
	[TeamID] [int] NOT NULL
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Area] ON 

INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (1, N'Teesside Site', NULL)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (2, N'Olefins Plant', 1)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (3, N'Hot End', 2)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (4, N'Cold End', 2)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (5, N'LDPE Plant', 1)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (6, N'Storage', 1)
INSERT [dbo].[Area] ([ID], [Name], [ParentID]) VALUES (7, N'Aromatics Plant', 1)
SET IDENTITY_INSERT [dbo].[Area] OFF
SET IDENTITY_INSERT [dbo].[Checksheet] ON 

INSERT [dbo].[Checksheet] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (1108, N'New Checksheet', CAST(0x0000A56101468865 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Checksheet] OFF
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (1108, 1125, 1)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (1108, 1126, 2)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (1108, 1127, 3)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (1108, 1128, 4)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (1108, 1129, 5)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (1108, 1144, 1)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (1108, 1145, 2)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (1108, 1146, 3)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (1108, 1147, 4)
SET IDENTITY_INSERT [dbo].[ChecksheetRecordFieldValue] ON 

INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (505, 1108, 1145, 1125, N'a')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (506, 1108, 1145, 1126, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (507, 1108, 1145, 1127, N'b')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (508, 1108, 1145, 1128, N'c')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (509, 1108, 1145, 1129, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (510, 1108, 1146, 1125, N'd')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (511, 1108, 1146, 1126, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (512, 1108, 1146, 1127, N'e')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (513, 1108, 1146, 1128, N'f')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (514, 1108, 1146, 1129, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (515, 1108, 1147, 1125, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (516, 1108, 1147, 1126, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (517, 1108, 1147, 1127, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (518, 1108, 1147, 1128, NULL)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ID], [ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (519, 1108, 1147, 1129, NULL)
SET IDENTITY_INSERT [dbo].[ChecksheetRecordFieldValue] OFF
SET IDENTITY_INSERT [dbo].[Field] ON 

INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (1125, N'Field 1', CAST(0x0000A56101468865 AS DateTime), 1, 1)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (1126, N'Field 2', CAST(0x0000A56101468865 AS DateTime), 1, 2)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (1127, N'Field 3', CAST(0x0000A56101468865 AS DateTime), 1, 1)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (1128, N'Field 4', CAST(0x0000A56101468866 AS DateTime), 1, 1)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (1129, N'Field 5', CAST(0x0000A56101468866 AS DateTime), 1, 1)
SET IDENTITY_INSERT [dbo].[Field] OFF
SET IDENTITY_INSERT [dbo].[Record] ON 

INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (1144, N'Title Record', CAST(0x0000A56101468866 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (1145, N'Record 1', CAST(0x0000A56101468866 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (1146, N'Record 2', CAST(0x0000A56101468866 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (1147, N'Record 3', CAST(0x0000A56101468867 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Record] OFF
SET IDENTITY_INSERT [dbo].[Routine] ON 

INSERT [dbo].[Routine] ([ID], [Name], [CreatedOn], [CreatedByID], [Description]) VALUES (1068, N'New Routine', CAST(0x0000A56101468864 AS DateTime), 1, N'Routine description')
SET IDENTITY_INSERT [dbo].[Routine] OFF
INSERT [dbo].[RoutineArea] ([RoutineID], [AreaID]) VALUES (1068, 1)
INSERT [dbo].[RoutineChecksheet] ([RoutineID], [ChecksheetID], [OrderNUmber]) VALUES (1068, 1108, 1)
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ID], [CreatedOn], [CreatedByID], [AssignedToUserID], [DueOn], [CompletedOn], [CompletedByID], [RoutineID], [AssignedTeamID]) VALUES (73, CAST(0x0000A561014690EB AS DateTime), 1, 1, CAST(0x0000A57000000000 AS DateTime), NULL, NULL, 1068, 1)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
SET IDENTITY_INSERT [dbo].[ScheduleFieldValue] ON 

INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1144, NULL, NULL, NULL, 193)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1145, 1125, NULL, 1, 194)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1145, 1126, N'b', 0, 195)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1145, 1127, N'c', 0, 196)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1145, 1128, N'test', 1, 197)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1145, 1129, N'd', 0, 198)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1146, 1125, N'e', 0, 199)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1146, 1126, N'f', 0, 200)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1146, 1127, NULL, 1, 201)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1146, 1128, NULL, 1, 202)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1146, 1129, NULL, 1, 203)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1147, 1125, NULL, 1, 204)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1147, 1126, NULL, 1, 205)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1147, 1127, NULL, 1, 206)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1147, 1128, NULL, 1, 207)
INSERT [dbo].[ScheduleFieldValue] ([ScheduleID], [ChecksheetID], [RecordID], [FieldID], [Value], [Editable], [ID]) VALUES (73, 1108, 1147, 1129, NULL, 1, 208)
SET IDENTITY_INSERT [dbo].[ScheduleFieldValue] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([ID], [Name]) VALUES (1, N'Hot End technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (2, N'Cold End technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (3, N'LDPE technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (4, N'Storage technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (5, N'Aromatics technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (6, N'Olefins technicians')
SET IDENTITY_INSERT [dbo].[Team] OFF
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (6, 2)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (1, 3)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (2, 4)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (3, 5)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (4, 6)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (5, 7)
SET IDENTITY_INSERT [dbo].[Type] ON 

INSERT [dbo].[Type] ([ID], [Name], [HtmlType]) VALUES (1, N'Text', N'text')
INSERT [dbo].[Type] ([ID], [Name], [HtmlType]) VALUES (2, N'Checkbox', N'checkbox')
INSERT [dbo].[Type] ([ID], [Name], [HtmlType]) VALUES (3, N'Number', N'number')
SET IDENTITY_INSERT [dbo].[Type] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [Name]) VALUES (1, N'Scott-PC\Scott')
SET IDENTITY_INSERT [dbo].[User] OFF
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 1)
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 2)
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 3)
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 4)
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 5)
INSERT [dbo].[UserTeam] ([UserID], [TeamID]) VALUES (1, 6)
ALTER TABLE [dbo].[Checksheet] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Field] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Record] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Routine] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
ALTER TABLE [dbo].[Schedule] ADD  DEFAULT (getdate()) FOR [CreatedOn]
GO
USE [master]
GO
ALTER DATABASE [RoutineManagement] SET  READ_WRITE 
GO
