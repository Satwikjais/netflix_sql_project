# 🎬 Netflix SQL Project (MySQL)

## 📖 Overview
This project performs **data analysis on Netflix’s Movies and TV Shows dataset** using **MySQL**.  
It demonstrates how SQL can be used to extract insights, analyze trends, and clean raw data.

The dataset includes over **8,800 titles** with information about:
- Show type (Movie or TV Show)
- Director and cast
- Country of origin
- Date added to Netflix
- Release year, rating, and duration
- Genre categories
- Short descriptions

---

## 🌟 Project Highlights
- Cleaned and structured a large dataset using MySQL.  
- Extracted meaningful insights using **aggregation, filtering, and string functions**.  
- Categorized content based on themes and keywords in descriptions.  
- Identified top-performing countries, actors, and genres.  
- Built queries that could easily integrate into a dashboard or visualization tool (e.g., Power BI, Tableau).

---

## 💡 Skills Demonstrated
| Skill Area | Techniques Used |
|-------------|----------------|
| **Data Cleaning** | Handling NULLs, removing duplicates, formatting strings |
| **Data Exploration** | Filtering, sorting, and grouping large datasets |
| **String Manipulation** | `LIKE`, `LOWER()`, `SUBSTRING_INDEX()`, and `REPLACE()` |
| **Aggregations** | `COUNT()`, `GROUP BY`, `ORDER BY`, and subqueries |
| **Conditional Logic** | `CASE WHEN` for content classification |
| **Date Functions** | `YEAR()`, `CURDATE()`, `STR_TO_DATE()` |
| **Joins & JSON Parsing** | Extracting actors from comma-separated lists using `JSON_TABLE()` |

---

## 🧰 Tools & Technologies
- **MySQL Server 8.0**
- **MySQL Workbench**
- **Dataset:** [Netflix Movies and TV Shows on Kaggle](https://www.kaggle.com/datasets/shivamb/netflix-shows)

---

## 🧱 Database Schema
```sql
CREATE TABLE netflix (
    show_id VARCHAR(10),
    type VARCHAR(10),
    title VARCHAR(255),
    director VARCHAR(255),
    casts VARCHAR(1000),
    country VARCHAR(255),
    date_added VARCHAR(50),
    release_year INT,
    rating VARCHAR(10),
    duration VARCHAR(50),
    listed_in VARCHAR(255),
    description VARCHAR(500)
);
