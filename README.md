# 🎮 GameHUB - Online Video Browsing System

A full-stack Java web application for browsing and managing gaming videos with user authentication, profile management, and admin dashboard. Built with Object-Oriented Programming principles and modern web technologies.

## 📋 Table of Contents
- [Features](#features)
- [Technologies Used](#technologies-used)
- [System Architecture](#system-architecture)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Database Configuration](#database-configuration)
- [Project Structure](#project-structure)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## ✨ Features

### 🔐 User Management
- **User Registration & Authentication**
  - Secure signup with password validation
  - Login with email and password
  - Session management
  - Remember me functionality
  
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

## 🚀 Installation & Setup

### 1. Clone the Repository
```bash
git clone https://github.com/Danidu-Muhandiram/Online-Video-Browsing-System-OOP-.git
cd Online-Video-Browsing-System-OOP-
```

### 2. Database Setup

#### Create Database
```sql
CREATE DATABASE videobrowsing;
USE videobrowsing;
```

#### Create Users Table
```sql
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    avatar VARCHAR(255) DEFAULT NULL,
    user_type VARCHAR(50) DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Create Notices Table
```sql
CREATE TABLE notices (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    message TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

#### Run Update Script (if needed)
```bash
# Execute the SQL script located at:
src/main/resources/db/update_users_table.sql
```

### 3. Configure Database Connection

Update the database credentials in:
- `src/main/java/UserPackage/DBConnection.java`
- `src/main/java/AdminPackage/DBConnection.java`

```java
private static String url = "jdbc:mysql://localhost:3306/videobrowsing?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
private static String user = "root";
private static String pass = "YOUR_PASSWORD"; // Change this to your MySQL password
```

### 4. Setup Eclipse Project

1. **Import Project**
   - Open Eclipse IDE
   - File → Import → Existing Projects into Workspace
   - Select the cloned repository folder
   - Click Finish

2. **Add Server Runtime**
   - Window → Preferences → Server → Runtime Environments
   - Add → Apache Tomcat v10.1
   - Browse to your Tomcat installation directory
   - Apply and Close

3. **Configure Build Path**
   - Right-click project → Build Path → Configure Build Path
   - Add External JARs from `src/main/webapp/WEB-INF/lib/`:
     - javax.servlet-3.1.jar
     - jstl-1.2.jar
     - jstl-api-1.2.jar
     - servlet-api.jar
     - mysql-connector-j-8.0.33.jar

4. **Project Facets**
   - Right-click project → Properties → Project Facets
   - Enable:
     - Dynamic Web Module 6.0
     - Java 21

### 5. Run the Application

1. **Add Project to Server**
   - Right-click on Tomcat server in Servers view
   - Add and Remove → Add your project → Finish

2. **Start Server**
   - Right-click on server → Start
   - Wait for "Server startup" message in console

3. **Access Application**
   - Open browser and navigate to:
   ```
   http://localhost:8080/Online-Video-Browsing-System-OOP-/Home.jsp
   ```

## 🗄 Database Configuration

### Default Configuration
- **Database Name**: videobrowsing
- **Port**: 3306
- **Username**: root
- **Password**: Abi0021@ (Change in DBConnection.java)
- **Tables**: users, notices

### Initial Data
Create an admin user:
```sql
INSERT INTO users (first_name, last_name, username, email, password, user_type) 
VALUES ('Admin', 'User', 'admin', 'admin@gamehub.com', 'admin123', 'admin');
```

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

## 💻 Usage

### User Workflow

1. **Registration**
   - Navigate to Signup page
   - Fill in personal details (first name, last name, username, email, password)
   - Submit to create account

2. **Login**
   - Navigate to Login page
   - Enter email and password
   - Optional: Check "Remember Me"
   - Login redirects to Home page

3. **Profile Management**
   - Access profile from navigation bar
   - View personal information and statistics
   - Edit profile details
   - Upload profile picture
   - Change password
   - Delete account

4. **Browse Videos**
   - Browse through video categories
   - Use search functionality
   - View trending content
   - Watch videos from hero slider

### Admin Workflow

1. **Login as Admin**
   - Use admin credentials

2. **Access Admin Dashboard**
   - Navigate to Admin.jsp
   - View statistics overview

3. **Manage Notices**
   - Create new notices/announcements
   - Edit existing notices
   - Delete notices
   - View all notices

## 🔒 Security Features

- **Password Validation**: Minimum length and complexity requirements
- **SQL Injection Prevention**: Prepared statements used throughout
- **Session Management**: Secure session handling for authentication
- **Input Validation**: Both client-side and server-side validation
- **File Upload Security**: Size limits and type restrictions for profile pictures

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Failed**
   - Verify MySQL is running
   - Check database credentials in DBConnection.java
   - Ensure database 'videobrowsing' exists

2. **ClassNotFoundException for MySQL Driver**
   - Verify mysql-connector-j-8.0.33.jar is in WEB-INF/lib
   - Clean and rebuild project

3. **404 Error**
   - Check Tomcat server is running
   - Verify project is deployed to server
   - Check URL path matches context path

4. **Upload Directory Not Found**
   - Create uploads/profiles/ directory in webapp folder
   - Ensure directory has write permissions

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 👥 Authors

- **Danidu Muhandiram** - [GitHub Profile](https://github.com/Danidu-Muhandiram)

## 🙏 Acknowledgments

- Bootstrap team for the UI framework
- Font Awesome for icons
- AOS library for animations
- Apache Tomcat team
- MySQL community

## 📧 Contact

For questions or support, please open an issue on GitHub.

---

**Note**: This is an educational project demonstrating OOP principles in Java web development. Make sure to change default credentials and add proper security measures before deploying to production. 