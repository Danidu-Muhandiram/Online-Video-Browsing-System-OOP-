package UserPackage;

import java.io.File;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10  // 10 MB
)
public class UserController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    
    // Public default constructor required by servlet container
    public UserController() {
        super();
    }
    
    @Override
    public void init() throws ServletException {
        super.init();
        // Ensure database schema is up to date
        updateDatabaseSchema();
    }
    
    // Database connection
    private Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }
    
    // Update database schema if needed
    private void updateDatabaseSchema() {
        try (Connection conn = getConnection()) {
            // Check if avatar column exists
            try {
                PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT avatar FROM users LIMIT 1"
                );
                checkStmt.executeQuery();
            } catch (SQLException e) {
                // Column doesn't exist, add it
                PreparedStatement alterStmt = conn.prepareStatement(
                    "ALTER TABLE users ADD COLUMN avatar VARCHAR(255) DEFAULT NULL"
                );
                alterStmt.executeUpdate();
            }
            
            // Check if user_type column exists
            try {
                PreparedStatement checkStmt = conn.prepareStatement(
                    "SELECT user_type FROM users LIMIT 1"
                );
                checkStmt.executeQuery();
            } catch (SQLException e) {
                // Column doesn't exist, add it
                PreparedStatement alterStmt = conn.prepareStatement(
                    "ALTER TABLE users ADD COLUMN user_type VARCHAR(50) DEFAULT 'user'"
                );
                alterStmt.executeUpdate();
                
                // Update existing records
                PreparedStatement updateStmt = conn.prepareStatement(
                    "UPDATE users SET user_type = 'user' WHERE user_type IS NULL"
                );
                updateStmt.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Login user
    public List<UserModel.User> loginUser(String email, String password) {
        List<UserModel.User> users = new ArrayList<>();
        String query = "SELECT user_id, first_name, last_name, username, email, password, profile_picture, user_type FROM users WHERE email = ? AND password = ?";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, email);
            pstmt.setString(2, password);

            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                UserModel.User user = new UserModel.User(
                    rs.getInt("user_id"),
                    rs.getString("first_name"),
                    rs.getString("last_name"),
                    rs.getString("username"),
                    rs.getString("email"),
                    rs.getString("password"),
                    rs.getString("profile_picture"),
                    rs.getString("user_type")
                );
                users.add(user);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return users;
    }
    
    // Register user
    public boolean registerUser(UserModel.User user) {
        String query = "INSERT INTO users (first_name, last_name, username, email, password, user_type) VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getUsername());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPassword());
            pstmt.setString(6, user.getUserType() != null ? user.getUserType() : "user");

            int rowsAffected = pstmt.executeUpdate();
            return rowsAffected > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Update user profile
    public void updateUser(UserModel.User user) {
        String query = "UPDATE users SET first_name = ?, last_name = ?, email = ?, username = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getEmail());
            pstmt.setString(4, user.getUsername());
            pstmt.setInt(5, user.getUserId());

            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update user profile picture
    public void updateUserProfilePicture(int userId, String profilePicture) {
        String query = "UPDATE users SET profile_picture = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, profilePicture);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update user password
    public void updatePassword(int userId, String newPassword) {
        String query = "UPDATE users SET password = ?, updated_at = CURRENT_TIMESTAMP WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, newPassword);
            pstmt.setInt(2, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Verify user password
    public boolean verifyPassword(int userId, String password) {
        String query = "SELECT password FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                String storedPassword = rs.getString("password");
                return password.equals(storedPassword);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    // Delete user account
    public void deleteUser(int userId) {
        String query = "DELETE FROM users WHERE user_id = ?";
        try (Connection conn = getConnection(); PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setInt(1, userId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Update profile
    private void updateProfile(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user != null) {
            String firstName = request.getParameter("firstName");
            String lastName = request.getParameter("lastName");
            String email = request.getParameter("email");
            String username = request.getParameter("username");
            
            // Update user object
            user.setFirstName(firstName);
            user.setLastName(lastName);
            user.setEmail(email);
            user.setUsername(username);
            
            // Update in database
            updateUser(user);
            
            // Update session
            session.setAttribute("user", user);
            
            // Redirect back to profile page
            response.sendRedirect("Profile.jsp");
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
    
    // Update profile picture
    private void updateProfilePicture(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user != null) {
            try {
                // Get the uploaded file
                Part filePart = request.getPart("profilePicture");
                if (filePart != null && filePart.getSize() > 0) {
                    // Get file extension
                    String fileName = filePart.getSubmittedFileName();
                    String fileExtension = fileName.substring(fileName.lastIndexOf(".")).toLowerCase();
                    
                    // Validate file type
                    if (!fileExtension.matches("\\.(jpg|jpeg|png|gif)$")) {
                        response.sendRedirect("Profile.jsp?error=Invalid file type. Please upload JPG, JPEG, PNG or GIF files only!");
                        return;
                    }
                    
                    // Generate unique filename
                    String newFileName = user.getUserId() + "_" + System.currentTimeMillis() + fileExtension;
                    
                    // Create uploads directory if it doesn't exist
                    String uploadPath = getServletContext().getRealPath("/uploads/profiles");
                    File uploadDir = new File(uploadPath);
                    if (!uploadDir.exists()) {
                        boolean created = uploadDir.mkdirs();
                        if (!created) {
                            response.sendRedirect("Profile.jsp?error=Failed to create upload directory!");
                            return;
                        }
                    }
                    
                    // Ensure the directory is writable
                    if (!uploadDir.canWrite()) {
                        response.sendRedirect("Profile.jsp?error=Upload directory is not writable!");
                        return;
                    }
                    
                    // Delete old profile picture if exists
                    if (user.getProfilePicture() != null) {
                        File oldFile = new File(uploadPath + File.separator + user.getProfilePicture());
                        if (oldFile.exists()) {
                            oldFile.delete();
                        }
                    }
                    
                    // Save the new file
                    File newFile = new File(uploadPath + File.separator + newFileName);
                    filePart.write(newFile.getAbsolutePath());
                    
                    // Verify the file was written successfully
                    if (!newFile.exists() || newFile.length() == 0) {
                        response.sendRedirect("Profile.jsp?error=Failed to save the uploaded file!");
                        return;
                    }
                    
                    // Update user's profile picture in database
                    user.setProfilePicture(newFileName);
                    updateUserProfilePicture(user.getUserId(), newFileName);
                    
                    // Update session
                    session.setAttribute("user", user);
                    
                    // Redirect with success message
                    response.sendRedirect("Profile.jsp?success=Profile picture updated successfully!");
                } else {
                    response.sendRedirect("Profile.jsp?error=No file was uploaded!");
                }
            } catch (Exception e) {
                e.printStackTrace();
                String errorMessage = "Failed to upload profile picture: " + e.getMessage();
                response.sendRedirect("Profile.jsp?error=" + java.net.URLEncoder.encode(errorMessage, "UTF-8"));
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
    
    // Change password
    private void changePassword(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user != null) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            // Verify current password
            if (verifyPassword(user.getUserId(), currentPassword)) {
                // Update password
                updatePassword(user.getUserId(), newPassword);
                session.setAttribute("message", "Password updated successfully!");
            } else {
                session.setAttribute("error", "Current password is incorrect!");
            }
            
            // Redirect back to profile page
            response.sendRedirect("Profile.jsp");
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
    
    // Delete account
    private void deleteAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user != null) {
            String password = request.getParameter("password");
            
            // Verify password before deletion
            if (verifyPassword(user.getUserId(), password)) {
                // Delete user's profile picture if exists
                if (user.getProfilePicture() != null) {
                    String picturePath = getServletContext().getRealPath("/uploads/profiles/" + user.getProfilePicture());
                    File pictureFile = new File(picturePath);
                    if (pictureFile.exists()) {
                        pictureFile.delete();
                    }
                }
                
                // Delete user from database
                deleteUser(user.getUserId());
                
                // Invalidate session
                session.invalidate();
                
                // Redirect to login page
                response.sendRedirect("Login.jsp");
            } else {
                session.setAttribute("error", "Password is incorrect!");
                response.sendRedirect("Profile.jsp");
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        
        switch (action) {
            case "updateProfile":
                updateProfile(request, response);
                break;
            case "updateProfilePicture":
                updateProfilePicture(request, response);
                break;
            case "changePassword":
                changePassword(request, response);
                break;
            case "deleteAccount":
                deleteAccount(request, response);
                break;
            default:
                response.sendRedirect("Profile.jsp?error=Invalid action!");
                break;
        }
    }
} 