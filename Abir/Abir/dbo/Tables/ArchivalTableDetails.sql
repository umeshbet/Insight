CREATE TABLE [dbo].[ArchivalTableDetails] (
    [ID]                      INT           IDENTITY (1, 1) NOT NULL,
    [SourceDatabaseName]      VARCHAR (200) NOT NULL,
    [SourceSchemaName]        VARCHAR (50)  NOT NULL,
    [SourceTableName]         VARCHAR (100) NOT NULL,
    [DestinationDatabaseName] VARCHAR (200) NOT NULL,
    [DestinationSchemaName]   VARCHAR (50)  NOT NULL,
    [DestinationTableName]    VARCHAR (100) NOT NULL,
    [TableArchivalDate]       DATE          NOT NULL,
    [IsDeleted]               BIT           NOT NULL,
    CONSTRAINT [PK_ArchivalTableDetails] PRIMARY KEY CLUSTERED ([ID] ASC)
);

