USE IronHAck_Gambling;
-- 1. 
SELECT
    Title, 
    Firstname, 
    Lastname,
    DateofBirth
FROM Customer
;

-- 2.
SELECT
    CustomerGroup,
    COUNT(CustId) AS Customer_Count
FROM Customer
GROUP BY CustomerGroup
;

-- 3.
SELECT 
	cs.*, 
    a.CurrencyCode
FROM customer cs
LEFT JOIN account a
    ON cs.CustId = a.CustId
;

-- 4.
SELECT 
	p.product,
    p.sub_product,
    p.CATEGORYID,
    SUM(b.Bet_Amt) AS Betting_Total
FROM product p
LEFT JOIN betting b
	ON p.CLASSID = b.ClassId & p.CATEGORYID = b.CategoryId

GROUP BY p.product, p.sub_product, p.CATEGORYID
;

-- 5.
SELECT 
	p.product,
    p.sub_product,
    p.CATEGORYID,
    SUM(b.Bet_Amt) AS Betting_Total
FROM product p
LEFT JOIN betting b
	ON p.CLASSID = b.ClassId AND p.CATEGORYID = b.CategoryId
    
WHERE p.product = 'Sportsbook' AND b.BetDate >= '2012-11-01 00:00:00'
GROUP BY p.product, p.sub_product, p.CATEGORYID
;

-- 6. 
SELECT
	a.currencyCode,
    cs.CustomerGroup,
    SUM(b.Bet_Amt) AS Betting_Total
FROM account a
LEFT JOIN customer cs
	ON a.CustId = cs.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo 
    
WHERE b.BetDate >= '2012-12-01 00:00:00'
GROUP BY CurrencyCode, CustomerGroup
;

-- 7.
SELECT 
	cs.Title,
    cs.FirstName,
    cs.LastName,
    COUNT(b.BetDate) AS Betting_Count
FROM customer cs
LEFT JOIN account a
	ON cs.CustId = a.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo
WHERE b.BetDate BETWEEN '2012-11-01 00:00:00' AND '2012-12-01 00:00:00'
GROUP BY cs.Title, cs.FirstName, cs.LastName
;

-- 8.1
SELECT
	cs.Title,
    cs.FirstName,
    cs.LastName,
    p.product,
	COUNT(p.product) AS product_type_count
FROM customer cs
LEFT JOIN account a
	ON cs.CustId = a.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo
LEFT JOIN product p
	ON b.ClassId = p.CLASSID
WHERE p.product IS NOT NULL
GROUP By cs.Title, cs.FirstName, cs.LastName, p.product
ORDER BY COUNT(p.product) DESC
;

-- 8.2 
SELECT
	cs.Title,
    cs.FirstName,
    cs.LastName,
    p.product,
	COUNT(p.product) AS product_type_count
FROM customer cs
LEFT JOIN account a
	ON cs.CustId = a.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo
LEFT JOIN product p
	ON b.ClassId = p.CLASSID
WHERE p.product IN ('Sportsbook', 'Vegas')
GROUP BY cs.Title, cs.FirstName, cs.LastName, p.product
HAVING COUNT(DISTINCT p.product = 2)
ORDER BY COUNT(p.product) DESC
;

-- 9.
SELECT
	cs.Title,
    cs.FirstName,
    cs.LastName,
    p.product,
    ROUND(SUM(b.Bet_Amt), 2) AS Betting_Count
FROM customer cs
LEFT JOIN account a
	ON cs.CustId = a.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo
LEFT JOIN product p
	ON b.ClassId = p.CLASSID
WHERE p.product = 'Sportsbook' AND b.bet_amt > 0 
GROUP BY cs.Title, cs.FirstName, cs.LastName, p.product
;

-- 10.
SELECT
	new_table.Title,
    new_table.FirstName,
    new_table.LastName,
    new_table.product,
	new_table.Betting_Count
FROM (
SELECT
	cs.Title,
    cs.FirstName,
    cs.LastName,
    p.product,
    ROUND(SUM(b.Bet_Amt),2) AS Betting_Count,
    ROW_NUMBER () OVER (PARTITION BY cs.CustId ORDER BY SUM(b.Bet_Amt) DESC) AS Row_n
FROM customer cs
LEFT JOIN account a
	ON cs.CustId = a.CustId
LEFT JOIN betting b
	ON a.AccountNo = b.AccountNo
LEFT JOIN product p
	ON b.ClassId = p.CLASSID
GROUP BY cs.Title, cs.CustId, cs.FirstName, cs.LastName, p.product
) AS new_table
WHERE Row_n = '1' AND new_table.Betting_Count IS NOT NULL
;


-- 11.
SELECT *
FROM student
ORDER BY GPA DESC
LIMIT 5
;

-- 12.
SELECT
	sc.school_id,
    sc.school_name,
    COUNT(st.student_id) AS Student_Num
FROM school sc
LEFT JOIN student st
	ON sc.school_id = st.school_id
GROUP BY sc.school_id, sc.school_name
;

-- 13.
SELECT
    new_table.school_name,
    new_table.student_name
FROM (
	SELECT 
		st.*,
        sc.school_name,
		ROW_NUMBER() OVER (PARTITION BY st.student_id ORDER BY st.GPA DESC) AS sr
	FROM school sc
	LEFT JOIN student st
		ON sc.school_id = st.school_id
	GROUP BY st.student_id, st.student_name, st.city, st.school_id, st.GPA, sc.school_name
	) AS new_table
WHERE sr IN (1, 2, 3)
GROUP BY new_table.school_name, new_table.student_name
ORDER BY new_table.school_name ASC
;