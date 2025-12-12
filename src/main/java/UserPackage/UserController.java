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
import java.util.logging.Logger;
import java.util.logging.Level;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/UserController")
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
		maxFileSize = 1024 * 1024 * 5, // 5 MB
		maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UserController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final Logger logger = Logger.getLogger(UserController.class.getName());

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

	// Update database schema if needed
	private void updateDatabaseSchema() {
		try (Connection conn = DBConnection.getConnection()) {
			// Check if avatar column exists
			try {
				PreparedStatement checkStmt = conn.prepareStatement("SELECT avatar FROM users LIMIT 1");
				checkStmt.executeQuery();
			} catch (SQLException e) {
				// Column doesn't exist, add it
				PreparedStatement alterStmt = conn
						.prepareStatement("ALTER TABLE users ADD COLUMN avatar VARCHAR(255) DEFAULT NULL");
				alterStmt.executeUpdate();
			}

			// Check if user_type column exists
			try {
				PreparedStatement checkStmt = conn.prepareStatement("SELECT user_type FROM users LIMIT 1");
				checkStmt.executeQuery();
			} catch (SQLException e) {
				// Column doesn't exist, add it
				PreparedStatement alterStmt = conn
						.prepareStatement("ALTER TABLE users ADD COLUMN user_type VARCHAR(50) DEFAULT 'user'");
				alterStmt.executeUpdate();

				// Update existing records
				PreparedStatement updateStmt = conn
						.prepareStatement("UPDATE users SET user_type = 'user' WHERE user_type IS NULL");
				updateStmt.executeUpdate();
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error updating database schema", e);
		}
	}

	// Login user
	public List<UserModel.User> loginUser(String email, String password) {
		List<UserModel.User> users = new ArrayList<>();
		String query = "SELECT user_id, first_name, last_name, username, email, password, profile_picture, user_type FROM users WHERE email = ? AND password = ?";

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, email);
			pstmt.setString(2, password);

			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					UserModel.User user = new UserModel.User();
					user.setUserId(rs.getString("user_id"));
					user.setFirstName(rs.getString("first_name"));
					user.setLastName(rs.getString("last_name"));
					user.setUsername(rs.getString("username"));
					user.setEmail(rs.getString("email"));
					user.setPassword(rs.getString("password"));
					user.setProfilePicture(rs.getString("profile_picture"));
					user.setUserType(rs.getString("user_type"));
					users.add(user);
				}
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error during login", e);
		}

		return users;
	}

	// Register user
	public boolean registerUser(UserModel.User user) {
		String query = "INSERT INTO users (first_name, last_name, username, email, password, user_type) VALUES (?, ?, ?, ?, ?, ?)";
		boolean success = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, user.getFirstName());
			pstmt.setString(2, user.getLastName());
			pstmt.setString(3, user.getUsername());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getPassword());
			pstmt.setString(6, user.getUserType() != null ? user.getUserType() : "user");

			int rowsAffected = pstmt.executeUpdate();
			success = rowsAffected > 0;
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error registering user", e);
		}

		return success;
	}

	// Update user profile
	public boolean updateUser(UserModel.User user) {
		String query = "UPDATE users SET first_name = ?, last_name = ?, username = ?, email = ? WHERE user_id = ?";
		boolean success = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, user.getFirstName());
			pstmt.setString(2, user.getLastName());
			pstmt.setString(3, user.getUsername());
			pstmt.setString(4, user.getEmail());
			pstmt.setString(5, user.getUserId());

			int rowsAffected = pstmt.executeUpdate();
			success = rowsAffected > 0;
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error updating user", e);
		}

		return success;
	}

	// Update user profile picture
	public boolean updateUserProfilePicture(String userId, String filename) {
		String query = "UPDATE users SET profile_picture = ? WHERE user_id = ?";
		boolean success = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, filename);
			pstmt.setString(2, userId);

			int rowsAffected = pstmt.executeUpdate();
			success = rowsAffected > 0;
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error updating profile picture", e);
		}

		return success;
	}

	// Update user password
	public boolean changePassword(String userId, String newPassword) {
		String query = "UPDATE users SET password = ? WHERE user_id = ?";
		boolean success = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, newPassword);
			pstmt.setString(2, userId);

			int rowsAffected = pstmt.executeUpdate();
			success = rowsAffected > 0;
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error changing password", e);
		}

		return success;
	}

	// Verify user password
	public boolean verifyPassword(String userId, String password) {
		String query = "SELECT password FROM users WHERE user_id = ?";
		boolean verified = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, userId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					String storedPassword = rs.getString("password");
					verified = password.equals(storedPassword);
				}
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error verifying password", e);
		}

		return verified;
	}

	// Delete user account
	public boolean deleteUser(String userId) {
		String query = "DELETE FROM users WHERE user_id = ?";
		boolean success = false;

		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(query)) {
			
			pstmt.setString(1, userId);

			int rowsAffected = pstmt.executeUpdate();
			success = rowsAffected > 0;
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error deleting user", e);
		}

		return success;
	}

	public UserModel.User getUserById(String userId) {
		String sql = "SELECT * FROM users WHERE user_id = ?";
		UserModel.User user = null;
		
		try (Connection conn = DBConnection.getConnection();
			 PreparedStatement pstmt = conn.prepareStatement(sql)) {
			
			pstmt.setString(1, userId);
			try (ResultSet rs = pstmt.executeQuery()) {
				if (rs.next()) {
					user = new UserModel.User();
					user.setUserId(rs.getString("user_id"));
					user.setFirstName(rs.getString("first_name"));
					user.setLastName(rs.getString("last_name"));
					user.setUsername(rs.getString("username"));
					user.setEmail(rs.getString("email"));
					user.setProfilePicture(rs.getString("profile_picture"));
					user.setUserType(rs.getString("user_type"));
				}
			}
		} catch (SQLException e) {
			logger.log(Level.SEVERE, "Error getting user by ID", e);
		}
		
		return user;
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

	// Helper method to send JSON response
	private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(String.format("{\"success\": %b, \"message\": \"%s\"}", success, message));
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
			boolean updated = updateUser(user);
			if (updated) {
				// Update session
				session.setAttribute("user", user);
				response.sendRedirect("Profile.jsp?success=Profile updated successfully!");
			} else {
				response.sendRedirect("Profile.jsp?error=Failed to update profile!");
			}
		} else {
			response.sendRedirect("Login.jsp");
		}
	}

	// Update profile picture
	private void updateProfilePicture(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
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
						sendJsonResponse(response, false,
								"Invalid file type. Please upload JPG, JPEG, PNG or GIF files only!");
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
							sendJsonResponse(response, false, "Failed to create upload directory!");
							return;
						}
					}

					// Ensure the directory is writable
					if (!uploadDir.canWrite()) {
						sendJsonResponse(response, false, "Upload directory is not writable!");
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
						sendJsonResponse(response, false, "Failed to save the uploaded file!");
						return;
					}

					// Update user's profile picture in database
					user.setProfilePicture(newFileName);
					updateUserProfilePicture(user.getUserId(), newFileName);

					// Update session
					session.setAttribute("user", user);

					// Send success response
					sendJsonResponse(response, true, "Profile picture updated successfully!");
				} else {
					sendJsonResponse(response, false, "No file was uploaded!");
				}
			} catch (Exception e) {
				e.printStackTrace();
				sendJsonResponse(response, false, "Failed to upload profile picture: " + e.getMessage());
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
				boolean updated = changePassword(user.getUserId(), newPassword);
				if (updated) {
					sendJsonResponse(response, true, "Password updated successfully!");
				} else {
					sendJsonResponse(response, false, "Failed to update password!");
				}
			} else {
				sendJsonResponse(response, false, "Current password is incorrect!");
			}
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
				boolean deleted = deleteUser(user.getUserId());
				if (deleted) {
					// Invalidate session
					session.invalidate();
					// Redirect to login page
					response.sendRedirect("Login.jsp");
				} else {
					response.sendRedirect("Profile.jsp?error=Failed to delete account!");
				}
			} else {
				response.sendRedirect("Profile.jsp?error=Password is incorrect!");
			}
		} else {
			response.sendRedirect("Login.jsp");
		}
	}
}