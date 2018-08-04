SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO









CREATE FUNCTION [dbo].[fnContactTypeRank]
(
	@ContactClass CHAR(1) --A (Address), P (Phone), E(Email)
)

RETURNS @Result TABLE 
(  
	ContactType	VARCHAR(25),
    PriorityRank INT
) 
AS
BEGIN

	IF (@ContactClass = 'A')
	BEGIN

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('B', 1)

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('S', 2)


		
	END	

	ELSE IF (@ContactClass = 'P')
	BEGIN

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('H', 1)

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('B', 2)

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('C', 3)

	END

	ELSE IF (@ContactClass = 'E')
	BEGIN

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('E', 1)

		INSERT INTO @Result (ContactType, PriorityRank)
		VALUES ('E2', 2)



	END


	RETURN

END









GO
