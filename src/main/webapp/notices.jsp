<%@ page import="java.sql.*, java.util.*" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Notices</title>
    <link rel="stylesheet" href="css/notices.css" />
    <script>
        function deleteNotice(noticeId) {
            if (confirm('Are you sure you want to delete this notice?')) {
                window.location.href = 'DeleteNoticeServlet?id=' + noticeId;
            }
        }

        function toggleAddForm() {
            const form = document.getElementById('add-notice-form');
            const button = document.getElementById('add-notice-btn');
            if (form.style.display === 'none') {
                form.style.display = 'block';
                button.textContent = 'Cancel';
            } else {
                form.style.display = 'none';
                button.textContent = 'Add New Notice';
            }
        }

        function enableEdit(noticeId) {
            console.log('Enabling edit for notice:', noticeId);
            
            const titleElement = document.getElementById('notice-title-' + noticeId);
            const messageElement = document.getElementById('notice-message-' + noticeId);
            
            if (!titleElement || !messageElement) {
                console.error('Could not find elements for notice:', noticeId);
                return;
            }
            
            const noticeItem = titleElement.closest('.notice-item');
            const editButton = noticeItem.querySelector('.edit-btn');

            const currentTitle = titleElement.textContent;
            const currentMessage = messageElement.textContent;

            // Create input elements
            const titleInput = document.createElement('input');
            titleInput.type = 'text';
            titleInput.id = 'edit-title-' + noticeId;
            titleInput.value = currentTitle;
            titleInput.style.width = '100%';
            
            const messageInput = document.createElement('textarea');
            messageInput.id = 'edit-message-' + noticeId;
            messageInput.textContent = currentMessage;
            messageInput.style.width = '100%';

            // Replace elements
            titleElement.parentNode.replaceChild(titleInput, titleElement);
            messageElement.parentNode.replaceChild(messageInput, messageElement);

            editButton.textContent = 'Save';
            editButton.onclick = function() { saveEdit(noticeId); };
        }

        function saveEdit(noticeId) {
            console.log('Saving edit for notice:', noticeId);
            
            const titleInput = document.getElementById('edit-title-' + noticeId);
            const messageInput = document.getElementById('edit-message-' + noticeId);
            
            if (!titleInput || !messageInput) {
                console.error('Could not find input elements for notice:', noticeId);
                return;
            }
            
            const newTitle = titleInput.value;
            const newMessage = messageInput.value;
            const noticeItem = titleInput.closest('.notice-item');
            const editButton = noticeItem.querySelector('.edit-btn');

            const formData = new URLSearchParams();
            formData.append('id', noticeId);
            formData.append('title', newTitle);
            formData.append('message', newMessage);

            fetch('UpdateServlet', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: formData.toString(),
            })
            .then(response => {
                if (response.redirected) {
                    window.location.href = response.url;
                } else if (response.ok) {
                    // Update the DOM elements
                    const titleElement = document.createElement('h3');
                    titleElement.id = 'notice-title-' + noticeId;
                    titleElement.textContent = newTitle;
                    titleInput.parentNode.replaceChild(titleElement, titleInput);

                    const messageElement = document.createElement('p');
                    messageElement.id = 'notice-message-' + noticeId;
                    messageElement.textContent = newMessage;
                    messageInput.parentNode.replaceChild(messageElement, messageInput);

                    editButton.textContent = 'Edit';
                    editButton.onclick = function() { enableEdit(noticeId); };
                } else {
                    alert('Failed to update notice.');
                }
            })
            .catch(error => {
                console.error('Error updating notice:', error);
                alert('Error updating notice. Please try again.');
            });
        }
    </script>
</head>
<body>
<%
    // JDBC connection
    String url = "jdbc:mysql://localhost:3306/notices";
    String user = "root";
    String pass = "123jayavi123";
    List<Map<String, Object>> notices = new ArrayList<>();
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection(url, user, pass);
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT id, title, message FROM notices");
        while (rs.next()) {
            Map<String, Object> notice = new HashMap<>();
            notice.put("id", rs.getInt("id"));
            notice.put("title", rs.getString("title"));
            notice.put("message", rs.getString("message"));
            notices.add(notice);
        }
        rs.close();
        stmt.close();
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Database error: " + e.getMessage() + "</p>");
    }
    pageContext.setAttribute("notices", notices);
%>
    <h1><center>Notices</center></h1>

    <c:if test="${not empty feedbackMessage}">
        <p style="color:${feedbackMessage.startsWith('Notice added') ? 'green' : (feedbackMessage.startsWith('Notice deleted') ? 'green' : (feedbackMessage.startsWith('Notice updated') ? 'green' : 'red'))};">${feedbackMessage}</p>
    </c:if>

    <div id="notice-list">
        <c:if test="${not empty errorMessage}">
            <p style="color:red;">${errorMessage}</p>
        </c:if>
        
        <div id="add-notice-box">
            <button id="add-notice-btn" onclick="toggleAddForm()">Add New Notice</button>
        </div>

        <div id="add-notice-form" style="display: none;" class="notice-item">
            <h3>Add New Notice</h3>
            <form action="InsertServlet" method="post">
                <div class="form-group">
                    <label for="notice-title">Title:</label>
                    <input type="text" id="notice-title" name="title" required />
                </div>
                <div class="form-group">
                    <label for="notice-description">Description:</label>
                    <textarea id="notice-description" name="message" required></textarea>
                </div>
                <div class="button-group">
                    <button type="submit" class="submit-btn">Save</button>
                    <button type="button" class="cancel-btn" onclick="toggleAddForm()">Cancel</button>
                </div>
            </form>
        </div>

        <c:choose>
            <c:when test="${not empty notices}">
                <c:forEach var="notice" items="${notices}">
                    <div class="notice-item" data-notice-id="${notice.id}">
                        <h3 id="notice-title-${notice.id}">${notice.title}</h3>
                        <p id="notice-message-${notice.id}">${notice.message}</p>
                        <div>
                            <button class="edit-btn" onclick="enableEdit('${notice.id}')">Edit</button>
                            <button class="delete-btn" onclick="deleteNotice('${notice.id}')">Delete</button>
                        </div>
                    </div>
                    <hr/>
                </c:forEach>
            </c:when>
            <c:otherwise>
                <p>No notices available.</p>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>