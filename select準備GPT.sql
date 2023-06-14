

-- 変数宣言
DECLARE @Code1 VARCHAR(10) = '4536.T';
DECLARE @Code2 VARCHAR(10) = '6432.T';
DECLARE @Code3 VARCHAR(10) = '6656.T';

-- #wrk テーブル作成
SELECT CONVERT(VARCHAR, TopickDay, 23) AS TopickDay,
       tmp2.TopickCode,
       EndPrice
INTO #wrk
FROM (
    SELECT TOP(3) TopickCode, CNT, maxPrice, avgPrice, minPrice
    FROM (
        SELECT TopickCode, COUNT(*) AS CNT,
               MAX(OpenPrice) AS maxPrice,
               AVG(OpenPrice) AS avgPrice,
               MIN(OpenPrice) AS minPrice
        FROM dDaylyPrice
        WHERE (OpenPrice <> 0) OR (Volume <> 0)
        GROUP BY TopickCode
        HAVING COUNT(*) = 365
    ) tmp1
    WHERE avgPrice > 500
) tmp2
INNER JOIN dDaylyPrice ON tmp2.TopickCode = dDaylyPrice.TopickCode
ORDER BY dDaylyPrice.TopickDay, dDaylyPrice.TopickCode;

-- 結果取得クエリ
SELECT TopickDay,
       MAX(CASE WHEN TopickCode = @Code1 THEN EndPrice ELSE NULL END) AS '4536.T',
       MAX(CASE WHEN TopickCode = @Code2 THEN EndPrice ELSE NULL END) AS '6432.T',
       MAX(CASE WHEN TopickCode = @Code3 THEN EndPrice ELSE NULL END) AS '6656.T'
FROM #wrk
GROUP BY TopickDay
ORDER BY TopickDay;

-- #wrk テーブル削除
DROP TABLE #wrk;



