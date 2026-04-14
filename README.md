# Attendance Management System

## 📌 Project Overview

This is a web-based Attendance Management System developed using Java, JSP, Servlet, and PostgreSQL. It helps manage employee records and track daily attendance with late and early calculations.

---

## 🚀 Features

* 🔐 Admin Login System
* 👨‍💼 Add, Edit, Delete Employees (CRUD)
* 🕒 Mark Attendance (Check-in / Check-out)
* ⏰ Auto Late & Early Leave Calculation
* 📊 View Daily Attendance
* 🗄️ PostgreSQL Database Integration

---

## 🛠️ Technologies Used

* Java (JDK 17+)
* JSP & Servlet
* JDBC
* PostgreSQL
* Apache Tomcat

---

## 🧠 Concepts Used

* MVC Architecture
* HttpSession (User Management)
* PreparedStatement (SQL Injection Prevention)
* Servlet Lifecycle
* JDBC Connectivity

---

## 🗄️ Database Schema

### Employee Table

* id (Primary Key)
* name
* email
* department

### Attendance Table

* id (Primary Key)
* employee_id (Foreign Key)
* date
* check_in
* check_out
* late_minutes
* early_leave_minutes
* status

---

## ⚙️ How to Run

1. Clone the repository:

```
git clone https://github.com/your-username/Attendance-Management-System.git
```

2. Import project into Eclipse

3. Add PostgreSQL JDBC Driver

4. Configure database:

* Create database: attendance_db
* Run SQL scripts

5. Run on Apache Tomcat

6. Open:

```
http://localhost:8080/Attendance_Management_System/login.jsp
```

---

## 🔑 Default Login

* Email: [admin@gmail.com](mailto:admin@gmail.com)
* Password: 1234

---

## 📈 Future Improvements

* Employee Login System
* Monthly Attendance Reports
* Export to Excel/PDF
* Role-based access

---

## 👨‍💻 Author

RUTIK AVHAD
