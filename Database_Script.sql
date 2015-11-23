USE [master]
GO
/****** Object:  Database [RoutineManagement]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  UserDefinedTableType [dbo].[ChecksheetList]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[ChecksheetList] AS TABLE(
	[ID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[Description] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldList]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[FieldList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[TypeID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldListWithID]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[FieldListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL,
	[TypeID] [int] NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldValueList]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[FieldValueList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Value] [nvarchar](max) NULL,
	[Editable] [nvarchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[FieldValueListWithID]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[FieldValueListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Value] [nvarchar](max) NULL,
	[Editable] [nvarchar](10) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[RecordList]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[RecordList] AS TABLE(
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[RecordListWithID]    Script Date: 11/23/2015 16:42:31 ******/
CREATE TYPE [dbo].[RecordListWithID] AS TABLE(
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ChecksheetID] [nvarchar](10) NULL,
	[Name] [nvarchar](max) NULL
)
GO
/****** Object:  StoredProcedure [dbo].[AreaGet]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  StoredProcedure [dbo].[RegisterUser]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  StoredProcedure [dbo].[RoutineGet]    Script Date: 11/23/2015 16:42:31 ******/
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

	SELECT Name, ID FROM dbo.Routine WHERE ID = @RoutineID;

	-- SELECT [Description] from dbo.Routine WHERE ID = @RoutineID;

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
		WHERE rcs.RoutineID = @RoutineID;

	SELECT	r.Name [RecordName]
		FROM dbo.Record r
		INNER JOIN dbo.ChecksheetRecord csr ON csr.RecordID = r.ID
		INNER JOIN dbo.RoutineChecksheet rcs ON rcs.ChecksheetID = csr.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID;

	SELECT	Value
		FROM ChecksheetRecordFieldValue csfv
		INNER JOIN dbo.RoutineChecksheet rcs ON csfv.ChecksheetID = rcs.ChecksheetID
		WHERE rcs.RoutineID = @RoutineID;

END

GO
/****** Object:  StoredProcedure [dbo].[RoutineNameByArea]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  StoredProcedure [dbo].[RoutineSave]    Script Date: 11/23/2015 16:42:31 ******/
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
	@FieldValues	dbo.FieldValueList	READONLY
AS
BEGIN
	SET NOCOUNT ON;

	DECLARE @UserID		INT = 1,
			@CS_Counter INT = 1,
			@CS_Count	INT = (SELECT COUNT(*) FROM @Checksheets);

	IF @RoutineID IS NULL
	BEGIN
		INSERT INTO dbo.Routine(Name, CreatedByID)
			VALUES(@Name, @UserID);

		SET @RoutineID = SCOPE_IDENTITY();
	END;
	ELSE
	BEGIN
		UPDATE dbo.Routine
			SET Name = @Name;
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
							WHERE cs.Name = @CS_Name );

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
			SET		@F_ID					= (SELECT ID FROM dbo.Field WHERE Name = @F_Name);

			IF @F_ID IS NULL
			BEGIN
				INSERT INTO dbo.Field(Name, TypeID, CreatedByID)
					VALUES(@F_Name, @TypeID, @UserID);

				SET	@F_ID = (SELECT ID FROM dbo.Field WHERE Name = @F_Name);
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
/****** Object:  StoredProcedure [dbo].[ScheduleGet]    Script Date: 11/23/2015 16:42:31 ******/
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
	 
	SELECT	r.Name		  Routine,
			a.Name		  Area,
			t.Name		  AssignedTeam,
			(SELECT Name
				FROM dbo.[User]
				WHERE ID = s.AssignedToUserID
			)			  AssignedUser,
			s.DueOn		  DueOn,
			s.CompletedOn CompletedOn,
			(SELECT Name
				FROM dbo.[User]
				WHERE ID = s.CompletedByID
			)             CompletedBy

		FROM Schedule s
		INNER JOIN dbo.Routine r on r.ID = s.RoutineID
		INNER JOIN dbo.RoutineArea ra ON ra.RoutineID = r.ID
		INNER JOIN dbo.Area a ON ra.AreaID = a.ID
		INNER JOIN dbo.TeamArea ta ON ta.AreaID = a.ID
		INNER JOIN dbo.Team t ON ta.TeamID = t.ID

END

GO
/****** Object:  StoredProcedure [dbo].[ScheduleRoutine]    Script Date: 11/23/2015 16:42:31 ******/
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
	@Team NVARCHAR(MAX),
	@User NVARCHAR(MAX) = NULL,
	@DateFor DATETIME,
	@Rate INT,
	@Period NVARCHAR(MAX),
	@Number INT

AS
BEGIN

	SET NOCOUNT ON;
	
	DECLARE @UserID INT = 1,
			@TeamID INT = (SELECT ID
								FROM dbo.Team
								WHERE Name = @Team
							),
			@AssignedUserID INT = (SELECT ID
										FROM dbo.[User]
										WHERE Name = @User
								    ),
			@RoutineID INT = (SELECT Routine.ID
								  FROM dbo.Routine
								  WHERE	 Routine.Name = @Routine 
							  ),
			@Counter INT = 1;
		

	WHILE @Counter <= @Number
	BEGIN

		INSERT INTO dbo.Schedule(
			CreatedByID,
			AssignedToTeamID,
			AssignedToUserID,
			DueOn,
			RoutineID
			)
			VALUES(
			@UserID,
			@TeamID,
			@AssignedUserID,
			CASE 
				WHEN @Period = 'Days' THEN DATEADD(DAY, (@Counter - 1) * @Rate, @DateFor)
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
/****** Object:  StoredProcedure [dbo].[TeamByAreaGet]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  StoredProcedure [dbo].[UsersByTeamGet]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  UserDefinedFunction [dbo].[GetAreaWithChildren]    Script Date: 11/23/2015 16:42:31 ******/
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
RETURNS @ret TABLE (Name NVARCHAR(MAX))
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
		SELECT Name FROM a;

	RETURN;
END

GO
/****** Object:  Table [dbo].[Area]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[Checksheet]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[ChecksheetField]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[ChecksheetRecord]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[ChecksheetRecordFieldValue]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChecksheetRecordFieldValue](
	[ChecksheetID] [int] NULL,
	[RecordID] [int] NULL,
	[FieldID] [int] NULL,
	[Value] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Field]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[Record]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[Routine]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Routine](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoutineArea]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoutineArea](
	[RoutineID] [int] NULL,
	[AreaID] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[RoutineChecksheet]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[Schedule]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CreatedOn] [datetime] NULL,
	[CreatedByID] [int] NOT NULL,
	[AssignedToTeamID] [int] NOT NULL,
	[AssignedToUserID] [int] NULL,
	[DueOn] [datetime] NOT NULL,
	[CompletedOn] [datetime] NULL,
	[CompletedByID] [int] NULL,
	[RoutineID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Team]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Team](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TeamArea]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TeamArea](
	[TeamID] [int] NOT NULL,
	[AreaID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Type]    Script Date: 11/23/2015 16:42:31 ******/
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
/****** Object:  Table [dbo].[User]    Script Date: 11/23/2015 16:42:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[UserTeam]    Script Date: 11/23/2015 16:42:31 ******/
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

INSERT [dbo].[Checksheet] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (62, N'New Checksheet a', CAST(0x0000A53C012474D3 AS DateTime), 1)
INSERT [dbo].[Checksheet] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (63, N'New Checksheet 2', CAST(0x0000A53C012474D5 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Checksheet] OFF
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (62, 53, 1)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (62, 54, 2)
INSERT [dbo].[ChecksheetField] ([ChecksheetID], [FieldID], [OrderNumber]) VALUES (63, 55, 1)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (62, 92, 1)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (62, 93, 2)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (62, 94, 3)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (62, 95, 4)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (63, 96, 1)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (63, 97, 2)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (63, 98, 3)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (63, 99, 4)
INSERT [dbo].[ChecksheetRecord] ([ChecksheetID], [RecordID], [OrderNumber]) VALUES (63, 100, 5)
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 93, 53, N'g')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 93, 54, N'h')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 94, 53, N'abc')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 94, 54, N'n')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 95, 53, N'def')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (62, 95, 54, N'l')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (63, 97, 55, N'd')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (63, 98, 55, N'hi')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (63, 99, 55, N'world')
INSERT [dbo].[ChecksheetRecordFieldValue] ([ChecksheetID], [RecordID], [FieldID], [Value]) VALUES (63, 100, 55, N':)')
SET IDENTITY_INSERT [dbo].[Field] ON 

INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (53, N'Field 1a', CAST(0x0000A53C012474D4 AS DateTime), 1, 0)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (54, N'Field 2a', CAST(0x0000A53C012474D4 AS DateTime), 1, 0)
INSERT [dbo].[Field] ([ID], [Name], [CreatedOn], [CreatedByID], [TypeID]) VALUES (55, N'Field 1b', CAST(0x0000A53C012474D5 AS DateTime), 1, 0)
SET IDENTITY_INSERT [dbo].[Field] OFF
SET IDENTITY_INSERT [dbo].[Record] ON 

INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (92, N'Title Recorda', CAST(0x0000A53C012474D4 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (93, N'Record 1a', CAST(0x0000A53C012474D4 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (94, N'Record 2a', CAST(0x0000A53C012474D4 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (95, N'Record 3a', CAST(0x0000A53C012474D5 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (96, N'Title Recordb', CAST(0x0000A53C012474D5 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (97, N'Record 1b', CAST(0x0000A53C012474D5 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (98, N'Record 2b', CAST(0x0000A53C012474D5 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (99, N'Record 3b', CAST(0x0000A53C012474D5 AS DateTime), 1)
INSERT [dbo].[Record] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (100, N'Record 4b', CAST(0x0000A53C012474D6 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Record] OFF
SET IDENTITY_INSERT [dbo].[Routine] ON 

INSERT [dbo].[Routine] ([ID], [Name], [CreatedOn], [CreatedByID]) VALUES (42, N'test name', CAST(0x0000A53C012474D3 AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[Routine] OFF
INSERT [dbo].[RoutineArea] ([RoutineID], [AreaID]) VALUES (42, 1)
INSERT [dbo].[RoutineChecksheet] ([RoutineID], [ChecksheetID], [OrderNUmber]) VALUES (42, 62, 1)
INSERT [dbo].[RoutineChecksheet] ([RoutineID], [ChecksheetID], [OrderNUmber]) VALUES (42, 63, 2)
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([ID], [CreatedOn], [CreatedByID], [AssignedToTeamID], [AssignedToUserID], [DueOn], [CompletedOn], [CompletedByID], [RoutineID]) VALUES (3, CAST(0x0000A54D00000000 AS DateTime), 1, 1, 1, CAST(0x0000A63900000000 AS DateTime), NULL, NULL, 42)
SET IDENTITY_INSERT [dbo].[Schedule] OFF
SET IDENTITY_INSERT [dbo].[Team] ON 

INSERT [dbo].[Team] ([ID], [Name]) VALUES (1, N'Hot End technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (2, N'Cold End technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (3, N'LDPE technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (4, N'Storage technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (5, N'Aromatics technicians')
INSERT [dbo].[Team] ([ID], [Name]) VALUES (6, N'Olefins technicians')
SET IDENTITY_INSERT [dbo].[Team] OFF
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (1, 1)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (6, 2)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (1, 3)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (2, 4)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (3, 5)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (4, 6)
INSERT [dbo].[TeamArea] ([TeamID], [AreaID]) VALUES (5, 7)
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
