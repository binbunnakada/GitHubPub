
--縦　table を横テーブルに変換

	SELECT TopickDay
    ,MAX(CASE WHEN TopickCode = '4536.T' THEN EndPrice ELSE NULL END) AS '4536.T'
    ,MAX(CASE WHEN TopickCode = '6432.T' THEN EndPrice ELSE NULL END) AS '6432.T'
    ,MAX(CASE WHEN TopickCode = '6656.T' THEN EndPrice ELSE NULL END) AS '6656.T'
	FROM (
		SELECT convert(varchar, TopickDay, 23) TopickDay
		,tmp2.TopickCode
		,EndPrice
		FROM (
			SELECT TOP(3)  TopickCode, CNT  
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
	)tmp3
	GROUP BY TopickDay
	ORDER BY TopickDay;





