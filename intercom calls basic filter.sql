SELECT
    [Time],
    [Day Of Week],
    [Event],
    REPLACE([Device], '47 Metro Express Exit', 'EX 47') AS [Device],
    [24h],
    [6pm-7pm],
    [6pm-7:30am],
    [7:30am-6pm]
FROM (
    SELECT 
        [column1] AS [Time],
        DATENAME(WEEKDAY, [column1]) AS [Day Of Week],
        [column2] AS [Event],
        REPLACE([column4], '47 Metro Express Exit', 'EX 47') AS [Device],
        1 AS [24h],
        CASE
            WHEN CAST([column1] AS TIME) BETWEEN '18:00:00' AND '19:00:00' THEN 1
            ELSE 0
        END AS [6pm-7pm],
        CASE
            WHEN (CAST([column1] AS TIME) BETWEEN '18:00:00' AND '23:59:59') OR (CAST([column1] AS TIME) BETWEEN '00:00:00' AND '07:29:59') THEN 1
            ELSE 0
        END AS [6pm-7:30am],
        CASE
            WHEN (CAST([column1] AS TIME) BETWEEN '07:30:00' AND '17:59:00') THEN 1
            ELSE 0
        END AS [7:30am-6pm]
    FROM [carpark].[dbo].[05]
    WHERE [column1] IS NOT NULL
        AND [column2] IS NOT NULL
        AND [column4] IS NOT NULL
) AS Subquery;