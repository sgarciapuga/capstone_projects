WITH tesla AS (
SELECT ROW_NUMBER() OVER (ORDER BY datetime ASC) RowNumber, *
FROM stocks
WHERE symbol = "TSLA:NASDAQ"),
tesla_moving AS(SELECT symbol,
RowNumber,
datetime,
price,
AVG(price) OVER (ORDER BY datetime ASC ROWS 9 PRECEDING) AS MA10,
AVG(price) OVER (ORDER BY datetime ASC ROWS 2 PRECEDING) AS MA30
FROM tesla)
SELECT datetime,
       RowNumber,
       price,
       CASE
			WHEN RowNumber > 9 THEN MA10 ELSE NULL
		END as MA10,
       CASE
			WHEN RowNumber > 29 THEN MA30 ELSE NULL 
		END as MA30,
       CASE
          WHEN RowNumber > 29 AND MA10 > MA30 THEN 'Over'
          WHEN RowNumber > 29 AND MA10 < MA30 THEN 'Below'
          ELSE NULL
       END as Signal
FROM   tesla_moving
ORDER BY datetime;