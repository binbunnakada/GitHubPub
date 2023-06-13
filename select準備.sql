
	SELECT  TopickCode, CNT  
	, maxPrice
	, avgPrice
	, minPrice
	FROM(
		SELECT  TopickCode, count(*) CNT  
		,MAX(OpenPrice) maxPrice
		,AVG(OpenPrice) avgPrice
		,MIN(OpenPrice) minPrice
		FROM   dDaylyPrice
		WHERE   (OpenPrice <> 0) OR  (Volume <> 0)
		GROUP BY  TopickCode
		HAVING count(*) = 365
	) tmp1
	WHERE avgPrice > 500
	ORDER BY  avgPrice