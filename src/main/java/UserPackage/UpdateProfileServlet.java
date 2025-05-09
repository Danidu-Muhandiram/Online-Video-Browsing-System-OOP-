package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {
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
            userController.updateUser(user);
            
            // Update session
            session.setAttribute("user", user);
            
            // Redirect back to profile page
            response.sendRedirect("Profile.jsp");
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
} 