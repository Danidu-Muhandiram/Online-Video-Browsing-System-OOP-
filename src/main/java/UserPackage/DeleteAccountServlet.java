package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;

@WebServlet("/DeleteAccountServlet")
public class DeleteAccountServlet extends HttpServlet {
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
            String password = request.getParameter("password");
            
            // Verify password before deletion
            if (userController.verifyPassword(user.getUserId(), password)) {
                // Delete user's profile picture if exists
                if (user.getProfilePicture() != null) {
                    String picturePath = getServletContext().getRealPath("/uploads/profiles/" + user.getProfilePicture());
                    File pictureFile = new File(picturePath);
                    if (pictureFile.exists()) {
                        pictureFile.delete();
                    }
                }
                
                // Delete user from database
                userController.deleteUser(user.getUserId());
                
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
} 