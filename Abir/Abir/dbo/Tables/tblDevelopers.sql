CREATE TABLE [dbo].[tblDevelopers] (
    [ID]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NULL,
    CONSTRAINT [PK_tblDevelopers] PRIMARY KEY CLUSTERED ([ID] ASC)
);

