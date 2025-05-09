package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private UserController userController;
    
    @Override
    public void init() throws ServletException {
        userController = new UserController();
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel.User user = (UserModel.User) session.getAttribute("user");
        
        if (user != null) {
            String currentPassword = request.getParameter("currentPassword");
            String newPassword = request.getParameter("newPassword");
            
            // Verify current password
            if (userController.verifyPassword(user.getUserId(), currentPassword)) {
                // Update password
                userController.updatePassword(user.getUserId(), newPassword);
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
} 