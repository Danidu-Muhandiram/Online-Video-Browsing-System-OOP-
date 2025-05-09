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

@WebServlet("/UpdateProfilePictureServlet")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024, // 1 MB
    maxFileSize = 1024 * 1024 * 5,    // 5 MB
    maxRequestSize = 1024 * 1024 * 10  // 10 MB
)
public class UpdateProfilePictureServlet extends HttpServlet {
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
                    userController.updateUserProfilePicture(user.getUserId(), newFileName);
                    
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
} 