package UserPackage;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user == null) {
            sendJsonResponse(response, false, "User not logged in");
            return;
        }

        String currentPassword = request.getParameter("currentPassword");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        // Validate input
        if (currentPassword == null || currentPassword.trim().isEmpty() ||
            newPassword == null || newPassword.trim().isEmpty() ||
            confirmPassword == null || confirmPassword.trim().isEmpty()) {
            sendJsonResponse(response, false, "All fields are required");
            return;
        }

        // Validate password match
        if (!newPassword.equals(confirmPassword)) {
            sendJsonResponse(response, false, "New passwords do not match");
            return;
        }

        // Validate password length
        if (newPassword.length() < 6) {
            sendJsonResponse(response, false, "Password must be at least 6 characters long");
            return;
        }

        // Verify current password and update
        if (verifyAndUpdatePassword(user.getUserId(), currentPassword, newPassword)) {
            sendJsonResponse(response, true, "Password updated successfully");
        } else {
            sendJsonResponse(response, false, "Current password is incorrect");
        }
    }

    private boolean verifyAndUpdatePassword(String userId, String currentPassword, String newPassword) {
        String verifyQuery = "SELECT password FROM users WHERE user_id = ? AND password = ?";
        String updateQuery = "UPDATE users SET password = ? WHERE user_id = ?";
        
        try (Connection conn = DBConnection.getConnection()) {
            // First verify current password
            try (PreparedStatement verifyStmt = conn.prepareStatement(verifyQuery)) {
                verifyStmt.setString(1, userId);
                verifyStmt.setString(2, currentPassword);
                
                if (verifyStmt.executeQuery().next()) {
                    // Current password is correct, update to new password
                    try (PreparedStatement updateStmt = conn.prepareStatement(updateQuery)) {
                        updateStmt.setString(1, newPassword);
                        updateStmt.setString(2, userId);
                        return updateStmt.executeUpdate() > 0;
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) 
            throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(String.format("{\"success\": %b, \"message\": \"%s\"}", success, message));
    }
} 