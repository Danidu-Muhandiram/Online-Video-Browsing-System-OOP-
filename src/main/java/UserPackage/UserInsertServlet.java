package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;

@WebServlet("/UserInsertServlet")
public class UserInsertServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserController userController;
    
    @Override
    public void init() throws ServletException {
        userController = new UserController();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Get form data
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        // Create UserModel.User object
        UserModel.User user = new UserModel.User();
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);
        user.setUserType("user"); // Set default user type
        
        try {
            // Validate form data
            if (!validateFormData(user, confirmPassword)) {
                String errorMessage = "Please ensure all fields are filled correctly and your password meets the requirements.";
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("Signup.jsp").forward(request, response);
                return;
            }
            
            // Register the user
            boolean isSuccess = userController.registerUser(user);
            
            if (isSuccess) {
                // Create session and set user attributes
                HttpSession session = request.getSession();
                session.setAttribute("username", username);
                session.setAttribute("firstName", firstName);
                
                // Show success message and redirect to login page
                String alertMessage = "Registration successful! Please login.";
                response.getWriter().println("<script>alert('" + alertMessage + "'); window.location.href = 'Login.jsp';</script>");
            } else {
                String errorMessage = "Registration failed. The username or email might already be in use.";
                request.setAttribute("error", errorMessage);
                request.getRequestDispatcher("Signup.jsp").forward(request, response);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            String errorMessage = "An error occurred during registration. Please try again later.";
            request.setAttribute("error", errorMessage);
            request.getRequestDispatcher("Signup.jsp").forward(request, response);
        }
    }
    
    private boolean validateFormData(UserModel.User user, String confirmPassword) {
        // Check if any field is empty
        if (user.getFirstName() == null || user.getLastName() == null || 
            user.getUsername() == null || user.getEmail() == null || 
            user.getPassword() == null || confirmPassword == null ||
            user.getFirstName().trim().isEmpty() || user.getLastName().trim().isEmpty() || 
            user.getUsername().trim().isEmpty() || user.getEmail().trim().isEmpty() || 
            user.getPassword().trim().isEmpty() || confirmPassword.trim().isEmpty()) {
            return false;
        }
        
        // Validate email format
        if (!user.getEmail().matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            return false;
        }
        
        // Check if passwords match
        if (!user.getPassword().equals(confirmPassword)) {
            return false;
        }
        
        // Password strength validation
        if (!isPasswordStrong(user.getPassword())) {
            return false;
        }
        
        return true;
    }
    
    private boolean isPasswordStrong(String password) {
        // Check password length
        if (password.length() < 8) {
            return false;
        }
        
        // Check for uppercase letter
        if (!password.matches(".*[A-Z].*")) {
            return false;
        }
        
        // Check for lowercase letter
        if (!password.matches(".*[a-z].*")) {
            return false;
        }
        
        // Check for number
        if (!password.matches(".*\\d.*")) {
            return false;
        }
        
        // Check for special character
        if (!password.matches(".*[!@#$%^&*(),.?\":{}|<>].*")) {
            return false;
        }
        
        return true;
    }
} 