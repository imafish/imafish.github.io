# SQL 学习笔记


## SQL语句以及分类

### 标准SQL
1. DDL (Data Definition Language)
   1. CREATE
   2. DROP
   3. ALTER
2. DML (Data Manipulation Language)
   1. SELECT
   2. INSERT
   3. UPDATE
   4. DELETE
3. DCL (Data Control Language)
   1. COMMIT
   2. ROLLBACK
   3. GRANT
   4. REVOKE

### SQL中的数据
1. 命令，表，列 不区分大小写
2. 字符串，日期等：单引号 如：'string'
3. 数字：不需要标识。如：1000
4. 别名：如有特殊字符，双引号，如："别 名" (别名中可以有空格)

### 数据类型
1. INTEGER
2. CHAR(length)
3. VARCHAR(length)
4. DATE

### 约束类型



-------
## CREATE
```sql
CREATE TABLE <table_name> (
    <column_definition>,
    <column_name> <type> <restraint>,
    ...
    ...
    PRIMARY KEY (<column_name>)
);
```

## DROP
```sql
DROP TABLE <table_name>;
```

## ALTER TABLE

1. 添加列
```sql
ALTER TABLE <table_name> ADD COLUMN <column_definition>;

#(Oracle, SQL Server)
ALTER TABLE <table_name> ADD <column_definition>;

#(Oracle)
ALTER TABLE <table_name> ADD (<column_definition>, <column_definition>);
```

2. 删除列
```sql
ALTER TABLE <table_name> DROP COLUMN <column_name>;

#(Oracle)
ALTER TABLE <table_name> DROP (<column_name>, <column_name>);
```

## INSERT
```sql
BEGIN TRANSACTION;
INSERT INTO Product VALUES ('0001', 'T 恤衫', '衣服', 1000, 500, '2009-09-20');
INSERT INTO Product VALUES ('0002', '打孔器', '办公用品', 500, 320, '2009-09-11');
COMMIT;

INSERT INTO Product2
    SELECT *
    FROM Product
    WHERE product_id <= '0003';
```

```sql
#(MySQL)
START TRANSACTION;

#(Oracle)
# (No BEGIN TRANSACTION)
```

## rename table
(TBD)

## SELECT

```sql
SELECT <column_name>, <column_name>
    FROM <table_name>;

SELECT *
    FROM <table_name>;

SELECT  <column_name> AS <alias>,
        <column_name> AS <alias>,
    FROM <table_name>;

# 常数
SELECT  'STATIC STRING' AS <alias>,
        123 AS <alias2>,
        '2022-1-1' AS <alias3>,
        <column_name>
    FROM <table_name>;
```

### DISTINCT
```sql
SELECT DISTINCT <distinct_column>, <distinct_column_2>
    FROM <table_name>;
```

### WHERE
```sql
SELECT *
    FROM Product
    WHERE product_type = '衣服';

--NULL
SELECT *
    FROM Product
    WHERE ppurchase_price IS NULL;
--NOT NULL
SELECT *
    FROM Product
    WHERE ppurchase_price IS NOT NULL;
```

> WHERE 必须紧跟FROM之后

### 算数运算和比较运算

优先级
- NOT
- AND
- OR

### 聚合函数

- COUNT
- SUM
- AVG
- MAX
- MIN

**Example:**
```sql
SELECT COUNT(*), COUNT(purchase_price) FROM Product;

-- DISTINCT
SELECT COUNT(DISTINCT purchase_price) FROM Product;

SELECT SUM(DISTINCT purchase_price) FROM Product WHERE sale_price >= 1000;

SELECT MAX(regist_date), MIN(product_name) FROM Product;
```


### GROUP BY
```sql
SELECT product_type, COUNT(*)
    FROM Product
    GROUP BY product_type;
```


| product_type | count |
| ------------ | ----- |
| 衣服         | 2     |
| 办公用品     | 2     |
| 厨房用具     | 4     |


> GROUP BY一定要写在FROM/WHERE之后  
> SELECT中的列明有限制

### HAVING

```sql
SELECT product_type
    FROM Product
    GROUP BY product_TYPE
    HAVING COUNT(*)=2;

SELECT product_type, AVG(sale_price)
    FROM Product
    GROUP BY product_TYPE
    HAVING AVG(sale_price) >= 1000;

-- HAVING 中不能有不在GROUP BY中的列
SELECT product_type, AVG(sale_price)
    FROM Product
    GROUP BY product_TYPE
    HAVING product_name = '圆珠笔';

> ERROR:  column "product.product_name" must appear in the GROUP BY clause or be used in an aggregate function

```

```sql
SELECT product_type, AVG(sale_price), COUNT(*)
    FROM Product
    WHERE purchase_price > 1000
    GROUP BY product_TYPE;
```
| product_type | avg                   | count |
| ------------ | --------------------- | ----- |
| 厨房用具     | 4900.0000000000000000 | 2     |
| 衣服         | 4000.0000000000000000 | 1     |


```sql
SELECT  product_type,
        SUM(sale_price) AS sum1,
        SUM(purchase_price) AS sum2
    FROM Product
    GROUP BY product_type
    HAVING SUM(sale_price) > SUM(purchase_price) * 1.5;
```

> SELECT → FROM → WHERE → GROUP BY → HAVING

### ORDER BY
```sql
SELECT  product_id AS id,
        product_name,
        sale_price AS sp,
        purchase_price
    FROM Product
    ORDER BY sp, id DESC;

SELECT product_type, COUNT(*)
    FROM Product
    GROUP BY product_type
    ORDER BY COUNT(*);
```

> SELECT  → FROM → WHERE → GROUP BY → HAVING → ORDER BY

## 数据更新

### INSERT
```sql
INSERT INTO <table_name>
    (<column_name1>, <column_name2>, ...)
    VALUES (<value1>, <value2>, ...);

-- 忽略列名（插入所有列，顺序必须一致）
INSERT INTO <table_name>
    VALUES (<value1>, <value2>, ...);

-- 插入多行（Oracle除外）
INSERT INTO <table_name>
    VALUES
        (<value1>, <value2>, ...),
        (<value3>, <value4>, ..);

-- 从其他表中复制
INSERT INTO <table_name>
    (<column_name1>, <column_name2>, ...)
    SELECT (<column_name1>, <column_name2>, ...)
        FROM <table2>;

INSERT INTO <table_name>
    (<column1>, <column2>, <column3>)
    SELECT product_id, SUM(sale_price), SUM(purchase_price)
        FROM Product
        GROUP BY product_type;
```

- `DEFAULT` keyword
- `NULL` keyword

### DELETE
```sql
DELETE FROM <table>;
-- faster:
TRUNCATE <table>;

DELETE FROM <table>
    WHERE <condition>;
```

### UPDATE
```sql
UPDATE <table>
    SET <column> = <value>;

UPDATE <table>
    SET <column> = <value>
    WHERE <condition>;

-- 更新多列
UPDATE <table>
    SET <column> = <value>,
    SET <column2> = <value2>;
```


## TRANSACTION 事务
```sql
--
BEGIN TRANSACTION;
-- ...
-- ...
COMMIT;


BEGIN TRANSACTION;
-- ...
-- ...
ROLLBACK;


-- (MySQL):
START TRANSACTION;
-- ...
-- ...
COMMIT;
```

## VIEW 视图

```sql

CREATE VIEW <view_name> (<view_column1>, <view_column2>)
AS
SELECT <select_column1>, <select_column2>
    FROM Product
    GROUP BY product_type;

CREATE VIEW ViewName (column1, column2)
AS
	SELECT c1, c2
		FROM OriginalTable
		WHERE condition
		GROUP BY keyword
		HAVING having_keyword;


SELECT * FROM Product
	WHERE price > (SELECT AVG(price)
				   FROM Product);

select product_id, product_name, (
	SELECT AVG(sale_price)
	FROM Product AS p1
	WHERE p1.product_type = p2.product_type) AS avg_sale_price
FROM Product AS p2;
```


## 函数

数学函数
1. ABS
2. ROUND
3. MOD (%)


字符串函数
1. || 字符串拼接
	1. MYSQL: CONCAT
	2. SQL Server: +
6. LENGTH
	1. SQL Server: LEN
7. LOWER / UPPER
8. REPLACE(source, search, replacement)
9. SUBSTRING(source FROM start FOR length)
	1. SQL Server: SUBSTRING(source, start, length)
	2. Oracle, DB2: SUBSTR(source, start, length)

日期函数
1. CURRENT_DATE
2. CURRENT_TIME
3. CURRENT_TIMESTAMP
4. EXTRACT(YEAR FROM CURRENT_TIMESTAMP)

转换函数
1. CAST(to_convert AS type)
2. COALESCE(value1, value2, ...) 返回第一个非NULL值

## predicate

1. =, <, >, <>
2. LIKE
3. BETWEEN
4. IS NULL, IS NOT NULL
5. IN, NOT IN
```sql
SELECT product_name, sale_price
FROM Product
WHERE product_id IN (SELECT product_id
    FROM ShopProduct
    WHERE shop_id = '000C');
```
6. EXISTS

```sql
SELECT product_name, sale_price
    FROM Product AS P
    WHERE EXISTS (SELECT *
        FROM ShopProduct AS SP
        WHERE SP.shop_id = '000C'
                AND SP.product_id = P.product_id);
```

## CASE
```sql
SELECT product_name, (
	CASE 
	WHEN product_type ='衣服' THEN'A ：'|| product_type
	WHEN product_type ='办公用品' THEN'B ：'|| product_type
	WHEN product_type ='厨房用具' THEN'C ：'|| product_type
	ELSE NULL
	END)
	AS abc_product_type
FROM Product;

SELECT product_name, (
	CASE product_type
	WHEN '衣服' THEN'A ：'|| product_type
	WHEN '办公用品' THEN'B ：'|| product_type
	WHEN '厨房用具' THEN'C ：'|| product_type
	ELSE NULL
	END)
	AS abc_product_type
FROM Product;
```

## 集合运算

### UNION
```sql
SELECT * FROM Product
UNION
SELECT * FROM Product2
ORDER BY product_id;
```

- UNION
- UNION ALL


### INTERSECT

- INTERSECT
- INTERSECT ALL

### EXCEPT
- EXCEPT


## 联结

内联结
```sql
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP 
    INNER JOIN Product AS P
    ON SP.product_id = P.product_id;
```

外联结
```sql
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price
FROM ShopProduct AS SP
    RIGHT OUTER JOIN Product AS P
    ON SP.product_id = P.product_id;
```

三表
```sql
SELECT SP.shop_id, SP.shop_name, SP.product_id, P.product_name, P.sale_price, IP.inventory_quantity
FROM ShopProduct AS SP
    INNER JOIN Product AS P
    ON SP.product_id = P.product_id
    INNER JOIN InventoryProduct AS IP
    ON SP.product_id = IP.product_id
WHERE IP.inventory_id = 'P001';
```

## 窗口函数
关键字：  
- OVER
- PARTITION BY
- ORDER BY


```sql
SELECT product_name, product_type, sale_price,
    RANK() OVER (PARTITION BY product_type ORDER BY sale_price) AS ranking
FROM product;

SELECT product_id, product_name, sale_price,
    SUM(sale_price) OVER (ORDER BY product_id) AS current_sum
FROM Product;

SELECT product_id, product_name, sale_price,
    AVG(sale_price) OVER (ORDER BY product_id
                            ROWS 2 PRECEDING) AS moving_avg
FROM Product;

SELECT product_id, product_name, sale_price,
    AVG(sale_price) OVER (ORDER BY product_id
                            ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS moving_avg
FROM Product;
```

- RANK
- DENSE_RANK
- ROW_NUMBER

## GROUPING 运算符

```sql
-- ROLLUP
SELECT product_type, regist_date, SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type, regist_date);

-- GROUPING
SELECT
    CASE
        WHEN GROUPING(product_type) = 1 THEN '商品种类 合计'
        ELSE product_type
    END AS product_type,
    CASE
        WHEN GROUPING(regist_date) = 1 THEN '登记日期 合计'
        ELSE CAST(regist_date AS VARCHAR(16))
    END AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY ROLLUP(product_type, regist_date);

-- CUBE
SELECT
    CASE
        WHEN GROUPING(product_type) = 1 THEN '商品种类 合计'
        ELSE product_type
    END AS product_type,
    CASE
        WHEN GROUPING(regist_date) = 1 THEN '登记日期 合计'
        ELSE CAST(regist_date AS VARCHAR(16))
    END AS regist_date,
    SUM(sale_price) AS sum_price
FROM Product
GROUP BY CUBE(product_type, regist_date);
```
