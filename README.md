# 🎮 GameHUB - Online Video Browsing System

A full-stack Java web application for browsing and managing gaming videos with user authentication, profile management, and admin dashboard. Built with Object-Oriented Programming principles and modern web technologies.

## 📋 Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [System Architecture](#system-architecture)
- [Prerequisites](#prerequisites)
- [Project Structure](#project-structure)
- [License](#license)

## ✨ Features

### 🔐 User Management
- **User Registration & Authentication**
  - Secure signup with password validation
  - Login with email and password
  - Session management
  
- **Profile Management**
  - View and edit user profile
  - Profile picture upload
  - Change password
  - Delete account
  - User statistics (videos, followers, following)

### 👨‍💼 Admin Dashboard
- **Admin Panel**
  - Notice/announcement management (CRUD operations)
  - User management
  - Video management
  - Analytics dashboard
  - Statistics overview (total videos, views, subscribers, comments)

### 🎬 Video Browsing
- **Interactive Interface**
  - Responsive navigation bar with search functionality
  - Category-based browsing
  - Trending section
  - Hero slider with featured content
  - Video grid with thumbnails
  - Dark theme UI

### 🔔 Notification System
- Admin notices and announcements
- Real-time toast notifications
- Notice listing and management

## 🛠 Technologies Used

### Backend
- **Java SE 21**
- **Jakarta EE (Servlet 6.0)**
- **JDBC** for database connectivity
- **MySQL Connector/J 8.0.33**
- **Apache Tomcat 10.1** server

### Frontend
- **HTML5 & CSS3**
- **JavaScript (ES6+)**
- **Bootstrap 5.3.0**
- **Font Awesome 6.4.0**
- **AOS Animation Library**
- **JSP (JavaServer Pages)**

### Development Tools
- **Eclipse IDE** with WTP (Web Tools Platform)
- **Maven** (optional - can be configured)
- **Git** for version control

## 🏗 System Architecture

### Design Pattern: MVC (Model-View-Controller)

```
┌─────────────────────────────────────────────────┐
│                    Client                        │
│              (Web Browser)                       │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│                   View Layer                     │
│  (JSP Pages: Home, Login, Signup, Profile,      │
│   Admin, Notices)                                │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│              Controller Layer                    │
│  (Servlets: LoginServlet, UserInsertServlet,    │
│   ProfileServlet, UpdateServlet, etc.)           │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│                 Model Layer                      │
│  (UserModel, notices, UserController,           │
│   noticesControl)                                │
└──────────────────┬──────────────────────────────┘
                   │
                   ▼
┌─────────────────────────────────────────────────┐
│              Database Layer                      │
│  (MySQL - videobrowsing database)               │
└─────────────────────────────────────────────────┘
```

### Package Structure
- **UserPackage**: User-related models, controllers, and servlets
- **AdminPackage**: Admin functionality for notices and content management

## 📦 Prerequisites

Before running this project, ensure you have:

- **Java Development Kit (JDK) 21** or higher
- **Apache Tomcat 10.1** or higher
- **MySQL Server 8.0** or higher
- **Eclipse IDE for Enterprise Java and Web Developers** (recommended) or IntelliJ IDEA
- **Web Browser** (Chrome, Firefox, Edge, etc.)

## 📁 Project Structure

```
Online-Video-Browsing-System-OOP-/
│
├── src/
│   └── main/
│       ├── java/
│       │   ├── AdminPackage/
│       │   │   ├── DBConnection.java
│       │   │   ├── notices.java
│       │   │   ├── noticesControl.java
│       │   │   ├── InsertServlet.java
│       │   │   ├── UpdateServlet.java
│       │   │   ├── DeleteNoticeServlet.java
│       │   │   └── ListNoticesServlet.java
│       │   │
│       │   └── UserPackage/
│       │       ├── DBConnection.java
│       │       ├── UserModel.java
│       │       ├── UserController.java
│       │       ├── UserInsertServlet.java
│       │       ├── LoginServlet.java
│       │       ├── ProfileServlet.java
│       │       ├── UpdateProfileServlet.java
│       │       ├── UpdateProfilePictureServlet.java
│       │       ├── ChangePasswordServlet.java
│       │       └── DeleteAccountServlet.java
│       │
│       ├── resources/
│       │   └── db/
│       │       └── update_users_table.sql
│       │
│       └── webapp/
│           ├── css/
│           │   ├── Home.css
│           │   ├── styles.css
│           │   ├── Profile.css
│           │   └── Admin.css
│           │
│           ├── js2/
│           │   └── (JavaScript files)
│           │
│           ├── pictures/
│           │   ├── slider1.png
│           │   ├── slider2.png
│           │   └── slider3.png
│           │
│           ├── uploads/
│           │   └── profiles/
│           │       └── (User uploaded profile pictures)
│           │
│           ├── WEB-INF/
│           │   ├── lib/
│           │   │   ├── mysql-connector-j-8.0.33/
│           │   │   ├── javax.servlet-3.1.jar
│           │   │   ├── jstl-1.2.jar
│           │   │   ├── jstl-api-1.2.jar
│           │   │   └── servlet-api.jar
│           │   └── xml.xml
│           │
│           ├── Home.jsp
│           ├── Login.jsp
│           ├── Signup.jsp
│           ├── Profile.jsp
│           ├── Admin.jsp
│           ├── notices.jsp
│           └── notice-result.jsp
│
├── .classpath
├── .project
├── .gitignore
└── README.md
```

## 🔒 Security Features

- **Password Validation**: Minimum length and complexity requirements
- **SQL Injection Prevention**: Prepared statements used throughout
- **Session Management**: Secure session handling for authentication
- **Input Validation**: Both client-side and server-side validation
- **File Upload Security**: Size limits and type restrictions for profile pictures
- 
## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Bootstrap team for the UI framework
- Font Awesome for icons
- AOS library for animations
- Apache Tomcat team
- MySQL community
