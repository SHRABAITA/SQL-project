
# 🚗 NewWheels Vehicle Resale Business Analysis – SQL Project

## 📚 Table of Contents

- [📘 Project Overview](#-project-overview)
- [🎯 Objective](#-objective)
- [📦 Data Description](#-data-description)
- [🛠️ Tools Used](#️-tools-used)
- [📊 Key Metrics Analyzed](#-key-metrics-analyzed)

---

## 📘 Project Overview

This project focuses on analyzing business performance data for **NewWheels**, a pre-owned vehicle resale company. The company provides end-to-end services through its app—from listing to delivery—and captures after-sales customer feedback.

In recent times, NewWheels has faced a **dip in sales and declining customer sentiment**, which is affecting business growth. This SQL-based analysis was undertaken to create a **quarterly business report** that highlights critical KPIs and answers key questions from leadership, aiding in strategic decision-making.

---

## 🎯 Objective

The primary goal is to:
- Import and analyze data from multiple relational tables using SQL.
- Create meaningful **quarterly business insights** for the CEO.
- Identify issues contributing to the drop in sales and customer satisfaction.
- Support data-driven business decisions with clear, structured outputs.

---

## 📦 Data Description

**New Wheels Data Dictionary**  
-----------------------------------

- `shipper_id`: Unique ID of the Shipper  
- `shipper_name`: Name of the Shipper  
- `shipper_contact_details`: Contact details of the Shipper  
- `product_id`: Unique ID of the Product  
- `vehicle_maker`: Vehicle Manufacturing company name  
- `vehicle_model`: Vehicle model name  
- `vehicle_color`: Color of the Vehicle  
- `vehicle_model_year`: Year of Manufacturing  
- `vehicle_price`: Price of the Vehicle  
- `quantity`: Ordered Quantity  
- `customer_id`: Unique ID of the customer  
- `customer_name`: Name of the customer  
- `gender`: Gender of the customer  
- `job_title`: Job Title of the customer  
- `phone_number`: Contact details of the customer  
- `email_address`: Email address of the customer  
- `City`: Residing city of the customer  
- `country`: Residing country of the customer  
- `state`: Residing state of the customer  
- `customer_address`: Address of the customer  
- `order_date`: Dates on which customers ordered the vehicle  
- `order_id`: Unique ID of the order  
- `ship_date`: Shipment Date  
- `ship_mode`: Shipping Mode/Class  
- `shipping`: Shipping Ways  
- `postal_code`: Postal Code of the customer  
- `discount`: Discount given to the customer for the particular order by credit card in percentage  
- `credit_card_type`: Credit Card Type  
- `credit_card_number`: Credit card number  
- `customer_feedback`: Feedback from the customer  
- `quarter_number`: Quarter Number  

---

## 🛠️ Tools Used

- **MySQL** for data extraction and transformation  
- **SQL Joins**, **Aggregation**, **Subqueries**, **Date Functions**, **CASE Statements**  
- **Git** & **GitHub** for version control and project management

---

## 📊 Key Metrics Analyzed

- Quarterly Sales Volume and Revenue Trends  
- Delivery Performance and Delays  
- Customer Feedback Trends by Quarter and Region  
- Popular Vehicle Categories by Sales  
- Payment Method Preferences  
- Customer Retention and Repeat Orders (if available)
