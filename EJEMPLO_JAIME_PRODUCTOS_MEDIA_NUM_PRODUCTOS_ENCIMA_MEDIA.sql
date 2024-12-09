
SELECT 
    p1.brand, 
    p1.name, 
    p1.price,
    avg_prices.average_price,
    above_avg_count.above_average_count
FROM 
    products p1
JOIN 
    (
        SELECT 
            brand, 
            AVG(price) AS average_price
        FROM 
            products
        GROUP BY 
            brand
    ) avg_prices
ON 
    p1.brand = avg_prices.brand
JOIN 
    (
        SELECT 
            p2.brand,
            COUNT(*) AS above_average_count
        FROM 
            products p2
        JOIN 
            (
                SELECT 
                    brand, 
                    AVG(price) AS average_price
                FROM 
                    products
                GROUP BY 
                    brand
            ) avg_prices2
        ON 
            p2.brand = avg_prices2.brand
        WHERE 
            p2.price > avg_prices2.average_price
        GROUP BY 
            p2.brand
    ) above_avg_count
ON 
    p1.brand = above_avg_count.brand
WHERE 
    p1.price > avg_prices.average_price
ORDER BY 
    p1.brand;