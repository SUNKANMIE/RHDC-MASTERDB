# 🚀 RHDC Master Operational Database

[![PostgreSQL](https://img.shields.io/badge/Database-PostgreSQL-336791?style=flat&logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![Supabase](https://img.shields.io/badge/Hosting-Supabase-3ECF8E?style=flat&logo=supabase&logoColor=white)](https://supabase.com/)
[![Status](https://img.shields.io/badge/Status-Production--Ready-brightgreen)](#)

## 📌 Project Overview
The **RHDC Master Operational Database** is a high-performance, production-ready system designed for **Remote Hustle** to streamline participant management, task submissions, and automated performance tracking. 

This solution replaces manual spreadsheets with a centralized SQL architecture, significantly reducing scoring latency and providing real-time analytical insights for administrators and judges.

---

## 🎯 Problem Solved
Remote Hustle previously faced operational bottlenecks including:
* **Manual Tracking:** Human error in participant logging.
* **Scoring Delays:** Fragmented evaluation processes.
* **Disorganized Data:** Lack of a "single source of truth" for submissions.
* **Zero Visibility:** No real-time leaderboard or performance metrics.

---

## 🧠 Key Features
* **Lifecycle Management:** Full participant registration and stage-based progression tracking.
* **Submission Control:** Robust management of entry statuses (Pending/Reviewed/Rejected).
* **Optimized Evaluation:** A streamlined single-score system for high-speed judging.
* **Live Analytics:** Real-time leaderboard ranking and submission summaries via SQL Views.
* **System Integrity:** Comprehensive audit logging for accountability and debugging.
* **Security:** Role-Based Access Control (RBAC) for Admins and Judges.

---

## 🏗️ Tech Stack
* **Engine:** PostgreSQL (Supabase)
* **Hosting:** Supabase Cloud
* **Language:** PL/pgSQL (DDL, DML, Views, Constraints)
* **Version Control:** Git & GitHub

---

## 🧩 Database Schema
The architecture is built on a relational model ensuring **3rd Normal Form (3NF)** compliance.

### Core Tables
| Table | Description |
| :--- | :--- |
| `roles` | Defines permission levels (Admin, Judge). |
| `users` | Management credentials for system operators. |
| `participants` | Core profiles of all competition entrants. |
| `stages` | Defines different phases of the competition. |
| `submissions` | Central repository for task entries and status. |
| `evaluations` | Single-point scoring linked to submissions. |
| `audit_logs` | Immutable record of all system changes. |

---

## ⚙️ Design Decisions
### 1. Simplified Evaluation Model
Instead of complex multi-criteria tables, the system uses a **One Evaluation = One Score** logic. 
* **Benefit:** Minimizes expensive `JOIN` operations and improves query performance during high-traffic leaderboard refreshes.

### 2. Data Integrity & Constraints
* **UUIDs:** Used for Primary Keys to ensure global uniqueness and security.
* **CHECK Constraints:** Prevents invalid scores (e.g., scores outside 0-100 range) or invalid status strings.
* **Unique Constraints:** Strictly prevents duplicate submissions for the same stage by a single participant.

### 3. Scalability
The schema is designed to support an infinite number of stages and judges without requiring structural changes.

---

## 📊 Views & Reporting
The system includes pre-configured views for instant reporting:

* **Leaderboard:** Ranks participants based on their highest-weighted scores.
    ```sql
    SELECT * FROM leaderboard;
    ```
* **Submission Summary:** High-level overview of total entries vs. pending reviews.
    ```sql
    SELECT * FROM submission_summary;
    ```

---

## 🚀 Getting Started

### Prerequisites
* A PostgreSQL client (e.g., pgAdmin, DBeaver) or a Supabase account.

### Connection Details
* **Project URL:** `https://glorvdsmvqcdqpbryjmg.supabase.co`
* **Connection String:** `postgresql://rhdc_reviewer:StrongPassword123@db.xyzcompany.supabase`

### Installation Steps
1.  **Clone the Repo:** `git clone https://github.com/your-username/rhdc-master-db.git`
2.  **Initialize Schema:** Run `schema.sql` to build the table structures.
3.  **Seed Data:** Run `seed.sql` to populate the DB with 100+ test participants and 50+ submissions.
4.  **Create Analytics:** Run `views.sql` to enable the leaderboard and reporting features.

---

## 📂 Project Structure
```text
rhdc-master-db/
├── schema.sql        # Database DDL (Tables, Constraints, Indexes)
├── seed.sql          # Realistic sample data for testing
├── queries.sql       # Operational scripts (CRUD, status updates)
├── views.sql         # Complex analytical views
├── ERD.png           # Visual Entity Relationship Diagram
└── README.md         # Project documentation
