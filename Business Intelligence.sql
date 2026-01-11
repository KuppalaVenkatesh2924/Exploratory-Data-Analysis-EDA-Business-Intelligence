import sqlite3
import pandas as pd

# Connect to a database (creates if not exists)
conn = sqlite3.connect("sales_data.db")
cur = conn.cursor()
cur.execute("""
CREATE TABLE IF NOT EXISTS sales_data (
  order_id INTEGER,
  order_date TEXT,
  customer_id TEXT,
  age INTEGER,
  region TEXT,
  segment TEXT,
  product TEXT,
  category TEXT,
  marketing_spend INTEGER,
  sales INTEGER
)
""")
data = [
      (101,"2024-01-10","C001",25,"South","Consumer","Mobile A","Electronics",5000,15000),
      (102,"2024-01-15","C002",32,"North","Corporate","Laptop B","Electronics",7000,45000),
      (103,"2024-02-05","C003",28,"East","Consumer","Headphones C","Accessories",2000,8000),
      (104,"2024-02-20","C004",40,"West","Corporate","Tablet D","Electronics",6000,30000),
      (105,"2024-03-02","C005",35,"South","Consumer","Smartwatch E","Accessories",3000,12000),
      (106,"2024-03-18","C006",29,"North","Consumer","Mobile A","Electronics",5200,16000),
      (107,"2024-04-10","C007",45,"East","Corporate","Laptop B","Electronics",7500,47000),
      (108,"2024-04-22","C008",31,"West","Consumer","Headphones C","Accessories",1800,7500),
      (109,"2024-05-05","C009",27,"South","Consumer","Tablet D","Electronics",6200,31000),
      (110,"2024-05-19","C010",38,"North","Corporate","Smartwatch E","Accessories",3500,14000),
      (111,"2024-06-03","C011",33,"East","Consumer","Mobile A","Electronics",5400,15500),
      (112,"2024-06-15","C012",41,"West","Corporate","Laptop B","Electronics",7800,48000),
      (113,"2024-07-08","C013",26,"South","Consumer","Headphones C","Accessories",1900,8200),
      (114,"2024-07-21","C014",34,"North","Consumer","Tablet D","Electronics",6100,30500),
      (115,"2024-08-11","C015",37,"East","Corporate","Smartwatch E","Accessories",3300,13500)

]
cur.executemany("INSERT INTO sales_data VALUES (?,?,?,?,?,?,?,?,?,?)", data)
conn.commit()
# Example 1: Select all
df = pd.read_sql_query("SELECT * FROM sales_data", conn)
df.head()
 # Example 2: Top 5 products by revenue
df_top = pd.read_sql_query("""
SELECT product, SUM(sales) AS revenue
FROM sales_data
GROUP BY product
ORDER BY revenue DESC
LIMIT 8
""", conn)
df_top
# 3. Bottom 5 products by revenue
df2 = pd.read_sql_query("""
SELECT product, SUM(sales) AS revenue
FROM sales_data
GROUP BY product
ORDER BY revenue ASC
LIMIT 5
""", conn)
print("\nBottom 5 Products by Revenue")
print(df2)
# 4. Average order value per customer
import pandas as pd
df4 = pd.read_sql_query("""
SELECT customer_id, AVG(sales) AS avg_order_value
FROM sales_data
GROUP BY customer_id
""", conn)
print("\nAverage Order Value per Customer")
print(df4)
# 5. Monthly sales trend
df5 = pd.read_sql_query("""
SELECT substr(order_date,1,7) AS month, SUM(sales) AS total_sales
FROM sales_data
GROUP BY month
ORDER BY month
""", conn)
print("\nMonthly Sales Trend")
print(df5)
# 6. Unique customers per segment
df6 = pd.read_sql_query("""
SELECT segment, COUNT(DISTINCT customer_id) AS unique_customers
FROM sales_data
GROUP BY segment
""", conn)
print("\nUnique Customers per Segment")
print(df6)
