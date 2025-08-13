# Day6
Objective: Sales Trend Analysis using aggrgations on Pizza Sales Dataset

#  Pizza Sales SQL Analysis

##  Project Overview
This project analyzes pizza sales data to uncover key business insights such as top-performing pizzas, sales trends, and customer purchasing behavior. The dataset contains order details, pizza types, sizes, and prices.

I used joins, aggregations, and date functions to generate meaningful insights from raw transactional data.

##  Insights
- **Top 3 pizza types** generate a significant portion of overall revenue.
- **Medium-sized pizzas** are the most ordered size.
- **Seasonal patterns** show certain months have higher sales.
- **Classic category pizzas** lead in order volume compared to other categories.
- **Average revenue per order** highlights spending behavior of customers.
- **Price vs Quantity** analysis shows high-priced pizzas can generate high revenue despite fewer orders.

## SQL Functions & Concepts Used
### **Aggregate Functions**
- `SUM()` → Calculate total revenue & total quantity sold.
- `COUNT()` → Count total orders and items sold.
- `AVG()` → Calculate average revenue per order.
- `ROUND()` → Format numerical results.

### **Joins**
- `INNER JOIN` → Merge tables: `pizza_types`, `pizzas`, `order_details`, `orders`.

### **Grouping & Sorting**
- `GROUP BY` → Aggregate data by pizza name, category, size, or month.
- `ORDER BY` → Sort results by revenue or quantity.

### **Filtering & Limiting**
- `LIMIT` → Get top N results (e.g., top 3 pizzas by revenue).
- `WHERE` → Apply conditions for specific queries.

### **Date Functions**
- `DATE_FORMAT()` → Extract and format month/year for trend analysis.

---

##  How to Run
1. Import the dataset into your MySQL database.
2. Open `pizza_sales1.sql` in **MySQL Workbench** or any SQL client.
3. Execute the queries step-by-step to view insights.
4. Modify `LIMIT` and `WHERE` clauses as needed for deeper analysis.

