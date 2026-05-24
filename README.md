# 🚀 AI-Powered-Sales-Analytics

An end-to-end **Data Analytics Project** built using **SQL, Python, Excel, Power BI, and AI tools** to analyze sales performance, customer behavior, and generate business insights.

---
https://datastudio.google.com/reporting/58b61b84-664f-4d81-aeb5-60209898e471

# 📌 Project Overview

This project demonstrates how modern **Data Analysts** use AI-powered workflows along with traditional analytics tools to transform raw sales data into actionable business insights.

✅ Data Cleaning & Preprocessing  
✅ Exploratory Data Analysis (EDA)  
✅ SQL Analytics Queries  
✅ CTEs & Window Functions  
✅ Power BI Dashboard  
✅ KPI Analysis  
✅ Customer & Product Insights  
✅ Interactive Data Visualization  

---

# 🛠️ Tech Stack

| Technology | Usage |
|------------|-------|
| 🐍 Python | Data Analysis & Cleaning |
| 🗄️ SQL / MySQL | Querying & Analytics |
| 📊 Power BI | Dashboard & Reporting |
| 📈 Excel | Data Handling |
| 🤖 ChatGPT / AI Tools | Query Generation & Documentation |
| 📚 Pandas & NumPy | Data Processing |
| 📉 Matplotlib | Visualization |

---

# 📂 Project Structure

```bash
AI-Powered-Sales-Analytics/
│
├── data/
│   ├── raw_data.csv
│   └── cleaned_data.csv
│
├── sql/
│   ├── sales_queries.sql
│   ├── cte_queries.sql
│   └── window_functions.sql
│
├── notebooks/
│   └── sales_analysis.ipynb
│
├── dashboards/
│   └── powerbi_dashboard.pbix
│
├── images/
│   └── dashboard_preview.png
│
├── README.md
└── LICENSE
```

---

# 📊 Key Insights

📌 Identified top-performing products and cities  
📌 Analyzed monthly sales growth trends  
📌 Calculated category-wise revenue contribution  
📌 Used SQL Window Functions for ranking analysis  
📌 Built interactive Power BI dashboards for reporting  

---

# 🔥 Features

## 🗄️ SQL Analysis

- Aggregate Functions
- Joins
- Subqueries
- Common Table Expressions (CTEs)
- Window Functions
- Ranking Functions
- Running Totals
- Sales Trend Analysis

---

## 🐍 Python Analysis

- Data Cleaning
- Data Transformation
- Data Visualization
- Statistical Analysis
- Business Insights

---

## 📊 Power BI Dashboard

- KPI Cards
- Interactive Filters
- Monthly Sales Trends
- Product Performance Analysis
- Customer Segmentation
- Dynamic Visualizations

---

# 💻 Sample SQL Query

```sql
WITH MonthlySales AS (
    SELECT 
        MONTH(order_date) AS month_num,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY MONTH(order_date)
)

SELECT *,
       RANK() OVER(ORDER BY total_sales DESC) AS sales_rank
FROM MonthlySales;
```

---

# 📈 Dashboard Preview

📷 Add dashboard screenshots inside the `images/` folder.

---

# 🤖 AI Integration

This project demonstrates how AI tools like ChatGPT can assist Data Analysts with:

✅ SQL Query Generation  
✅ Data Cleaning Automation  
✅ Dashboard Planning  
✅ Insight Generation  
✅ Documentation Writing  
✅ Business Reporting  

---

# 🚀 Future Improvements

- 📌 Machine Learning Forecasting
- 📌 Real-time Analytics
- 📌 Cloud Dashboard Deployment
- 📌 Automated Reporting System
- 📌 AI-based Recommendation Engine

---

# 👨‍💻 Author

## Deepak Malviya

📧 Email: Deepakmalviya7604@gmail.com  
📱 Contact: +91 7989230916  
🔗 LinkedIn: https://www.linkedin.com/in/deepak102825/

---

# ⭐ Support

If you found this project useful, please ⭐ star this repository and share it with others.

---

# 📄 License

This project is licensed under the MIT License.
<img width="1337" height="739" alt="Screenshot (1157)" src="https://github.com/user-attachments/assets/dd612e26-5367-425c-be46-804d9dd2a192" />
<img width="1337" height="746" alt="Screenshot (1158)" src="https://github.com/user-attachments/assets/4f5a1cb7-4686-4c77-a366-cb65a4b13f1c" />
