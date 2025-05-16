package UserPackage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/uploadProfilePicture")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5, // 5 MB
    maxRequestSize = 1024 * 1024 * 10 // 10 MB
)
public class UpdateProfilePictureServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final Logger logger = Logger.getLogger(UpdateProfilePictureServlet.class.getName());
    private UserController userController;

    @Override
    public void init() throws ServletException {
        userController = new UserController();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                        sendJsonResponse(response, false, "Invalid file type. Please upload JPG, JPEG, PNG or GIF files only!");
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
                    userController.updateUserProfilePicture(user.getUserId(), newFileName);

                    // Update session
                    session.setAttribute("user", user);

                    // Send success response with filename
                    sendJsonResponse(response, true, "Profile picture updated successfully!", newFileName);
                } else {
                    sendJsonResponse(response, false, "No file was uploaded!");
                }
            } catch (Exception e) {
                logger.log(Level.SEVERE, "Error uploading profile picture", e);
                sendJsonResponse(response, false, "Failed to upload profile picture: " + e.getMessage());
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }

    // Helper method to send JSON response
    private void sendJsonResponse(HttpServletResponse response, boolean success, String message) throws IOException {
        sendJsonResponse(response, success, message, null);
    }

    private void sendJsonResponse(HttpServletResponse response, boolean success, String message, String filename) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        if (filename != null) {
            response.getWriter().write(String.format("{\"success\": %b, \"message\": \"%s\", \"filename\": \"%s\"}", 
                success, message, filename));
        } else {
            response.getWriter().write(String.format("{\"success\": %b, \"message\": \"%s\"}", success, message));
        }
    }
} 