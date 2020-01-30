SELECT symbol, --string_list, count, middle,
    CASE WHEN count%2=0 THEN
        0.5 * substr(string_list, middle-10, 10) + 0.5 * substr(string_list, middle, 10)
    ELSE
        1.0 * substr(string_list, middle, 10)
    END AS median
FROM (
    SELECT symbol, 
        group_concat(value_string,"") AS string_list,
        count() AS count, 
        1 + 10*(count()/2) AS middle
    FROM (
        SELECT symbol, 
            printf( '%010d',price) AS value_string
        FROM stocks
        ORDER BY symbol,value_string
    )
    GROUP BY symbol
);
