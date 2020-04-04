
IF object_id('udf_GetSystemParameter', 'FN') IS NOT NULL
	DROP FUNCTION udf_GetSystemParameter
GO

/* Version 1.0.0 - OhadP 03/04/2020 Initial Version */

/*
	input parameters:
	@ParameterDescrition - sytem parameter description

	output parameters:
	@ParameterValue - system parameter value
*/

CREATE FUNCTION udf_GetSystemParameter (
		@ParameterDescrition		nvarchar(200),
		@Default					nvarchar(200)
)
RETURNS nvarchar(200) 
AS
BEGIN

	DECLARE @ParameterValue			nvarchar(200) = NULL

    SELECT	@ParameterValue = ParameterValue
	FROM	dbo.SystemParameters
	WHERE	ParameterDescrition = @ParameterDescrition

	RETURN ISNULL (@ParameterValue, @Default)
END
