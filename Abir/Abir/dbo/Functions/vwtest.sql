/****** Script for SelectTopNRows command from SSMS  ******/

CREATE FUNCTION vwtest(@ID INT)
RETURNS TABLE
RETURN(
SELECT [ID]
      ,[Name]
      ,[IdNum]
  FROM [Abir].[dbo].[tblTest]
  WHERE [ID] = @ID )
