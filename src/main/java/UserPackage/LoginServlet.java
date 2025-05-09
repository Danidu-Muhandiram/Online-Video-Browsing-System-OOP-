package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private UserController userController;
	
	@Override
	public void init() throws ServletException {
		userController = new UserController();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// Redirect GET requests to login page
		response.sendRedirect("Login.jsp");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String email = request.getParameter("email");
		String password = request.getParameter("password");
		String rememberMe = request.getParameter("rememberMe");
		
		try {
			// Validate input
			if (email == null || password == null || email.trim().isEmpty() || password.trim().isEmpty()) {
				request.setAttribute("error", "Please enter both email and password");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
				return;
			}
			
			// Attempt login
			List<UserModel.User> userLogin = userController.loginUser(email, password);
			
			if (userLogin != null && !userLogin.isEmpty()) {
				UserModel.User user = userLogin.get(0);
				
				// Create session
				HttpSession session = request.getSession();
				session.setAttribute("user", user);
				session.setAttribute("username", user.getUsername());
				session.setAttribute("firstName", user.getFirstName());
				
				// Set remember me cookie if requested
				if (rememberMe != null && rememberMe.equals("on")) {
					// TODO: Implement remember me functionality with secure cookie
				}
				
				// Redirect to home page
				response.sendRedirect("Profile.jsp");
			} else {
				request.setAttribute("error", "Invalid email or password. Please try again.");
				request.getRequestDispatcher("Login.jsp").forward(request, response);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("error", "An error occurred during login. Please try again later.");
			request.getRequestDispatcher("Login.jsp").forward(request, response);
		}
	}
}
