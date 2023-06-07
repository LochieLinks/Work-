SELECT [Device], [24H Count], [6pm-7pm Count], [6pm-7:30am Count], [7:30am-6pm Count]
FROM (
    SELECT [Device],
        SUM([24h]) AS [24H Count],
        SUM([6pm-7pm]) AS [6pm-7pm Count],
        SUM([6pm-7:30am]) AS [6pm-7:30am Count],
        SUM([7:30am-6pm]) AS [7:30am-6pm Count]
    FROM (
        SELECT 
            [column1] AS [Time],
            DATENAME(WEEKDAY, [column1]) AS [Day Of Week],
            [column2] AS [Event],
            [column4] AS [Device],
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
    ) AS Subquery
    WHERE [Device] LIKE 'EN 21'
        OR [Device] LIKE 'EN 22'
        OR [Device] LIKE 'EN 23'
        OR [Device] LIKE 'EN 24'
        OR [Device] LIKE 'EN 25'
        OR [Device] LIKE 'EN 26'
        OR [Device] LIKE 'EN 47'
        OR [Device] LIKE 'TC 51'
    GROUP BY [Device]
) AS OuterQuery
ORDER BY [Device];