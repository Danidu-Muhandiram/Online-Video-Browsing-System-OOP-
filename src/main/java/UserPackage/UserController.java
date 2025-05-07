package UserPackage;


import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// Interface for user operations
interface UserOperations {
    boolean registerUser(UserModel user);
    List<UserModel> loginUser(String email, String password);
    boolean updateUser(UserModel user);
    boolean deleteUser(int userId);
    UserModel getUserById(int userId);
    List<UserModel> getAllUsers();
}

// Abstract class for common database operations
abstract class DatabaseOperations {
    protected Connection connection;
    protected Statement statement;
    protected ResultSet resultSet;
    
    protected void closeResources() {
        try {
            if (resultSet != null) resultSet.close();
            if (statement != null) statement.close();
            if (connection != null) connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    protected Connection getConnection() throws SQLException {
        return DBConnection.getConnection();
    }
}

// Main UserController class
public class UserController extends DatabaseOperations implements UserOperations {
    private static UserController instance;
    
    // Singleton pattern
    public static UserController getInstance() {
        if (instance == null) {
            instance = new UserController();
        }
        return instance;
    }
    
    // Private constructor for singleton
    private UserController() {}
    
    @Override
    public boolean registerUser(UserModel user) {
        boolean isSuccess = false;
        PreparedStatement pstmt = null;
        
        try {
            // Validate input
            if (!validateUserInput(user)) {
                System.out.println("User input validation failed");
                return false;
            }
            
            // Check if username or email exists
            if (isUsernameExists(user.getUsername())) {
                System.out.println("Username already exists: " + user.getUsername());
                return false;
            }
            if (isEmailExists(user.getEmail())) {
                System.out.println("Email already exists: " + user.getEmail());
                return false;
            }
            
            connection = getConnection();
            String sql = "INSERT INTO users (first_name, last_name, username, email, password) VALUES (?, ?, ?, ?, ?)";
            pstmt = connection.prepareStatement(sql);
            
            pstmt.setString(1, user.getFirstName());
            pstmt.setString(2, user.getLastName());
            pstmt.setString(3, user.getUsername());
            pstmt.setString(4, user.getEmail());
            pstmt.setString(5, user.getPassword());
            
            int result = pstmt.executeUpdate();
            isSuccess = (result > 0);
            
            if (isSuccess) {
                System.out.println("User registered successfully: " + user.getUsername());
            }
            
        } catch (SQLException e) {
            System.err.println("Error registering user: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResources();
        }
        
        return isSuccess;
    }
    
    @Override
    public List<UserModel> loginUser(String email, String password) {
        List<UserModel> users = new ArrayList<>();
        PreparedStatement pstmt = null;
        
        try {
            connection = getConnection();
            String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
            pstmt = connection.prepareStatement(sql);
            
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            
            resultSet = pstmt.executeQuery();
            
            if (resultSet.next()) {
                UserModel user = new UserModel(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("email"),
                    resultSet.getString("password"),
                    resultSet.getString("profile_picture"),
                    resultSet.getString("user_type")
                );
                users.add(user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (pstmt != null) pstmt.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResources();
        }
        
        return users;
    }
    
    @Override
    public boolean updateUser(UserModel user) {
        boolean isSuccess = false;
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "UPDATE users SET " +
                        "first_name = '" + user.getFirstName() + "', " +
                        "last_name = '" + user.getLastName() + "', " +
                        "email = '" + user.getEmail() + "', " +
                        "profile_picture = '" + user.getProfilePicture() + "', " +
                        "user_type = '" + user.getUserType() + "' " +
                        "WHERE user_id = " + user.getUserId();
            
            int result = statement.executeUpdate(sql);
            isSuccess = (result > 0);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return isSuccess;
    }
    
    @Override
    public boolean deleteUser(int userId) {
        boolean isSuccess = false;
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "DELETE FROM users WHERE user_id = " + userId;
            int result = statement.executeUpdate(sql);
            isSuccess = (result > 0);
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return isSuccess;
    }
    
    @Override
    public UserModel getUserById(int userId) {
        UserModel user = null;
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "SELECT * FROM users WHERE user_id = " + userId;
            resultSet = statement.executeQuery(sql);
            
            if (resultSet.next()) {
                user = new UserModel(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("email"),
                    resultSet.getString("password"),
                    resultSet.getString("profile_picture"),
                    resultSet.getString("user_type")
                );
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return user;
    }
    
    @Override
    public List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "SELECT * FROM users";
            resultSet = statement.executeQuery(sql);
            
            while (resultSet.next()) {
                UserModel user = new UserModel(
                    resultSet.getInt("user_id"),
                    resultSet.getString("first_name"),
                    resultSet.getString("last_name"),
                    resultSet.getString("username"),
                    resultSet.getString("email"),
                    resultSet.getString("password"),
                    resultSet.getString("profile_picture"),
                    resultSet.getString("user_type")
                );
                users.add(user);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return users;
    }
    
    // Helper methods
    private boolean isUsernameExists(String username) {
        boolean exists = false;
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "SELECT COUNT(*) FROM users WHERE username = '" + username + "'";
            resultSet = statement.executeQuery(sql);
            
            if (resultSet.next()) {
                exists = (resultSet.getInt(1) > 0);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return exists;
    }
    
    private boolean isEmailExists(String email) {
        boolean exists = false;
        
        try {
            connection = getConnection();
            statement = connection.createStatement();
            
            String sql = "SELECT COUNT(*) FROM users WHERE email = '" + email + "'";
            resultSet = statement.executeQuery(sql);
            
            if (resultSet.next()) {
                exists = (resultSet.getInt(1) > 0);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            closeResources();
        }
        
        return exists;
    }
    
    private boolean validateUserInput(UserModel user) {
        if (user.getFirstName() == null || user.getLastName() == null || 
            user.getUsername() == null || user.getEmail() == null || 
            user.getPassword() == null ||
            user.getFirstName().trim().isEmpty() || user.getLastName().trim().isEmpty() || 
            user.getUsername().trim().isEmpty() || user.getEmail().trim().isEmpty() || 
            user.getPassword().trim().isEmpty()) {
            return false;
        }
        
        if (!user.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return false;
        }
        
        return true;
    }
} 