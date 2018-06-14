CREATE PROCEDURE [dbo].[GenerateArchivalData]
AS
BEGIN
	 DECLARE
	 @TotalRecord          INT
	,@CurrentRecord        INT
	,@SqlStatement         NVARCHAR(MAX) = NULL
	,@TableName            NVARCHAR(MAX) = NULL
	,@SourceTableName      NVARCHAR(MAX) = NULL
	,@DestinationTableName NVARCHAR(MAX) = NULL

	SELECT @TotalRecord = COUNT(*) FROM dbo.ArchivalTableDetails WHERE TableArchivalDate = CAST (GETUTCDATE() AS DATE) AND IsDeleted = 0

	SET @CurrentRecord = 1

	WHILE (@CurrentRecord <= @TotalRecord)
	BEGIN
     		SELECT TOP(@CurrentRecord) 
				 @TableName			   = SourceTableName 
				,@SourceTableName      =  '['+ SourceDatabaseName +'].['+ SourceSchemaName+'].['+ SourceTableName + ']'
				,@DestinationTableName =  '['+ DestinationDatabaseName +'].['+ DestinationSchemaName+'].['+ DestinationTableName + ']'
			FROM [dbo].[ArchivalTableDetails] WHERE TableArchivalDate = CAST (GETUTCDATE() AS DATE) AND IsDeleted = 0 ;

	        IF (@TableName = 'ServiceProcessedNotification')
			BEGIN

			SET @SqlStatement = 'IF NOT EXISTS ( SELECT 1 FROM '+ @DestinationTableName +' )
			                     BEGIN
									INSERT INTO '+ @DestinationTableName +'(ServiceNotificationUId, ServiceListenerEntityEventUId, EventMessageUId, EntityEventUId, SentOn, SenderUser, SenderApp, ServiceUrl, HttpVerb, 
																			[Message], Link, ServiceTypeUId,ProjectUId,ProjectId, EngagementUId, EngagementId, ClientUId, ClientId, NotificationStatusUId, ServiceProcessUId,
    																		ProcessUId, RowStatusUId, CreatedByUser, CreatedByApp,CreatedOn, ModifiedByUser,ModifiedByApp, ModifiedOn, CallbackLink, ErrorCallbackLink,RemainingNotificationRetryCount )
																	SELECT ServiceNotificationUId, ServiceListenerEntityEventUId, EventMessageUId, EntityEventUId, SentOn, SenderUser, SenderApp, ServiceUrl, HttpVerb, 
																			[Message], Link, ServiceTypeUId,ProjectUId,ProjectId, EngagementUId, EngagementId, ClientUId, ClientId, NotificationStatusUId, ServiceProcessUId,
    																		ProcessUId, RowStatusUId, CreatedByUser, CreatedByApp,CreatedOn, ModifiedByUser,ModifiedByApp, ModifiedOn, CallbackLink, ErrorCallbackLink,RemainingNotificationRetryCount 
																	FROM  ' + @SourceTableName + ' ; 
									IF ((SELECT COUNT(1) FROM ' + @SourceTableName + ' ) = (SELECT COUNT(1) FROM  ' + @DestinationTableName + '))
									BEGIN
											TRUNCATE TABLE ' + @SourceTableName + ';
									END
								 END'     

			END 

			IF (@TableName = 'ServiceProcessedNotificationParam')
			BEGIN

			SET @SqlStatement = 'IF NOT EXISTS ( SELECT 1 FROM '+ @DestinationTableName +' )
			                     BEGIN
									INSERT INTO '+ @DestinationTableName +'(ServiceNotificationParamUId, ServiceNotificationUId,KeyName, KeyValue, Link, ParentServiceNotificationParamUId, RowStatusUId, CreatedByUser,
																			CreatedByApp, CreatedOn,ModifiedByUser, ModifiedByApp, ModifiedOn, CallbackLink, ErrorCallbackLink) 
																	SELECT ServiceNotificationParamUId, ServiceNotificationUId,KeyName, KeyValue, Link, ParentServiceNotificationParamUId, RowStatusUId, CreatedByUser,
																			CreatedByApp, CreatedOn,ModifiedByUser, ModifiedByApp, ModifiedOn, CallbackLink, ErrorCallbackLink
																	FROM  ' + @SourceTableName + ' ; 
									IF ((SELECT COUNT(1) FROM ' + @SourceTableName + ' ) = (SELECT COUNT(1) FROM  ' + @DestinationTableName + '))
									BEGIN
										TRUNCATE TABLE ' + @SourceTableName + ';
									END
								 END' 
			END 
	
	--PRINT @SqlStatement
	
	EXECUTE sp_executesql @SqlStatement;

	SET @CurrentRecord = @CurrentRecord + 1;

	END
END