


		SELECT convert(varchar, TopickDay, 23) TopickDay
		,tmp2.TopickCode
		,EndPrice
		INTO #wrk
		FROM (
			SELECT TOP(30)  TopickCode, CNT  
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
		) tmp2
		,	dDaylyPrice
		WHERE tmp2.TopickCode = dDaylyPrice.TopickCode
		ORDER BY dDaylyPrice.TopickCode,dDaylyPrice.TopickDay


		SELECT * FROM #wrk


		DROP TABLE #wrk




