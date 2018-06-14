CREATE TABLE [dbo].[tblTest] (
    [ID]    INT        IDENTITY (1, 1) NOT NULL,
    [Name]  NCHAR (10) NULL,
    [IdNum] INT        NULL,
    CONSTRAINT [PK_tblTest] PRIMARY KEY CLUSTERED ([ID] ASC)
);

