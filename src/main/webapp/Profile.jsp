<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="UserPackage.UserModel" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - GameHUB</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <link rel="icon" type="image/png" sizes="16x16" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <link rel="apple-touch-icon" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/Profile.css">
    
</head>
<body class="dark-theme">
    <%
    UserModel.User user = (UserModel.User)session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
    %>

    <!-- Loading Spinner -->
    <div class="loading-spinner">
        <div class="spinner-border text-purple" role="status">
            <span class="visually-hidden">Loading...</span>
        </div>
    </div>

    <!-- Toast Container -->
    <div class="toast-container"></div>

    <!-- Navigation Bar -->
    <nav class="navbar navbar-expand-lg navbar-dark sticky-top">
        <div class="container">
            <a class="navbar-brand fs-3 fw-bold d-flex align-items-center" href="Home.jsp">
                <i class="fas fa-gamepad me-2"></i>
                <span>GameHUB</span>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarScroll">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarScroll">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="Home.jsp">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#">Trending</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Profile Header -->
    <div class="profile-header" data-aos="fade-down">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-md-3 text-center">
                    <div class="profile-picture-container">
                        <img src="${pageContext.request.contextPath}/uploads/profiles/<%= user.getProfilePicture() != null ? user.getProfilePicture() : "default_avatar.png" %>" 
                             alt="Profile Picture" class="profile-picture" id="profilePicture">
                        <button class="btn btn-purple btn-sm change-picture-btn" data-bs-toggle="modal" data-bs-target="#changePictureModal">
                            <i class="fas fa-camera me-2"></i>Change Picture
                        </button>
                    </div>
                </div>
                <div class="col-md-9">
                    <h1 class="text-white mb-2" data-aos="fade-right" data-aos-delay="100"><%= user.getUsername() %></h1>
                    <p class="text-light mb-3" data-aos="fade-right" data-aos-delay="200"><%= user.getEmail() %></p>
                    <div class="profile-stats" data-aos="fade-up" data-aos-delay="300">
                        <div class="stat-item">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Videos</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Followers</div>
                        </div>
                        <div class="stat-item">
                            <div class="stat-value">0</div>
                            <div class="stat-label">Following</div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Profile Content -->
    <div class="container">
        <!-- Profile Picture Management -->
        <div class="profile-section" data-aos="fade-up">
            <div class="profile-section-title">
                <span><i class="fas fa-camera me-2"></i>Profile Picture</span>
                <button class="btn btn-purple" data-bs-toggle="modal" data-bs-target="#changePictureModal">
                    <i class="fas fa-camera me-2"></i>Change Picture
                </button>
            </div>
            
        </div>


        <!-- Personal Information -->
        <div class="profile-section" data-aos="fade-up">
            <div class="profile-section-title">
                <span><i class="fas fa-user me-2"></i>Personal Information</span>
                <button class="btn btn-purple" id="editPersonalInfo">
                    <i class="fas fa-edit me-2"></i>Edit
                </button>
            </div>
            <form id="personalInfoForm" action="UserController" method="post">
                <input type="hidden" name="action" value="updateProfile">
                <div class="row g-4">
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">First Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="firstName" name="firstName" 
                                       value="<%= user.getFirstName() %>" readonly
                                       pattern="[A-Za-z\s]{2,50}" title="First name should only contain letters and spaces (2-50 characters)">
                            </div>
                            <div class="invalid-feedback">Please enter a valid first name (2-50 characters, letters only)</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Last Name</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-user"></i></span>
                                <input type="text" class="form-control" id="lastName" name="lastName" 
                                       value="<%= user.getLastName() %>" readonly
                                       pattern="[A-Za-z\s]{2,50}" title="Last name should only contain letters and spaces (2-50 characters)">
                            </div>
                            <div class="invalid-feedback">Please enter a valid last name (2-50 characters, letters only)</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Email Address</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                <input type="email" class="form-control" id="email" name="email" 
                                       value="<%= user.getEmail() %>" readonly
                                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Please enter a valid email address">
                            </div>
                            <div class="invalid-feedback">Please enter a valid email address</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Username</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-at"></i></span>
                                <input type="text" class="form-control" id="username" name="username" 
                                       value="<%= user.getUsername() %>" readonly
                                       pattern="[A-Za-z0-9_]{3,20}" title="Username should be 3-20 characters (letters, numbers, and underscores only)">
                            </div>
                            <div class="invalid-feedback">Username should be 3-20 characters (letters, numbers, and underscores only)</div>
                        </div>
                    </div>
                </div>
                <div class="text-end mt-4 d-none" id="personalInfoActions">
                    <button type="button" class="btn btn-secondary me-2" id="cancelPersonalInfo">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-purple" id="savePersonalInfo">
                        <i class="fas fa-save me-2"></i>Save Changes
                    </button>
                </div>
            </form>
        </div>

        <!-- Change Password -->
        <div class="profile-section" data-aos="fade-up" data-aos-delay="100">
            <div class="profile-section-title">
                <span><i class="fas fa-lock me-2"></i>Change Password</span>
                <button class="btn btn-purple" id="togglePasswordForm">
                    <i class="fas fa-key me-2"></i>Change Password
                </button>
            </div>
            <form id="changePasswordForm" action="UserController" method="post" class="d-none">
                <input type="hidden" name="action" value="changePassword">
                <div class="row g-4">
                    <div class="col-md-12">
                        <div class="form-group">
                            <label class="form-label">Current Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">Please enter your current password</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">New Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="password" class="form-control" id="newPassword" name="newPassword" required
                                       pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
                                       title="Password must be at least 8 characters long and include letters, numbers, and special characters">
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">Password must be at least 8 characters long and include letters, numbers, and special characters</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-group">
                            <label class="form-label">Confirm New Password</label>
                            <div class="input-group">
                                <span class="input-group-text"><i class="fas fa-key"></i></span>
                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                    <i class="fas fa-eye"></i>
                                </button>
                            </div>
                            <div class="invalid-feedback">Passwords do not match</div>
                        </div>
                    </div>
                </div>
                <div class="password-strength mt-3">
                    <div class="d-flex justify-content-between align-items-center mb-2">
                        <small class="text-muted">Password Strength</small>
                        <small class="password-strength-text">Too weak</small>
                    </div>
                    <div class="progress" style="height: 5px;">
                        <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                    </div>
                    <div class="password-requirements mt-3">
                        <small class="d-block text-muted mb-2">Password Requirements:</small>
                        <ul class="list-unstyled">
                            <li class="requirement" data-requirement="length">
                                <i class="fas fa-times-circle text-danger me-2"></i>
                                At least 8 characters
                            </li>
                            <li class="requirement" data-requirement="letter">
                                <i class="fas fa-times-circle text-danger me-2"></i>
                                At least one letter
                            </li>
                            <li class="requirement" data-requirement="number">
                                <i class="fas fa-times-circle text-danger me-2"></i>
                                At least one number
                            </li>
                            <li class="requirement" data-requirement="special">
                                <i class="fas fa-times-circle text-danger me-2"></i>
                                At least one special character
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="text-end mt-4">
                    <button type="button" class="btn btn-secondary me-2" id="cancelPasswordChange">
                        <i class="fas fa-times me-2"></i>Cancel
                    </button>
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-save me-2"></i>Update Password
                    </button>
                </div>
            </form>
        </div>

        <!-- Danger Zone -->
        <div class="danger-zone" data-aos="fade-up" data-aos-delay="200">
            <div class="danger-zone-title">
                <i class="fas fa-exclamation-triangle"></i>
                <span>Danger Zone</span>
            </div>
            <p class="text-light mb-4">Once you delete your account, there is no going back. Please be certain.</p>
            <button class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#deleteAccountModal">
                Delete Account
            </button>
        </div>
    </div>

    <!-- Change Picture Modal -->
    <div class="modal fade" id="changePictureModal" tabindex="-1" aria-labelledby="changePictureModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="changePictureModalLabel">Change Profile Picture</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form id="profilePictureForm" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="profilePicture" class="form-label">Select New Picture</label>
                            <input type="file" class="form-control" id="profilePicture" name="profilePicture" accept="image/*" required>
                            <div class="form-text">Allowed formats: JPG, JPEG, PNG, GIF. Maximum size: 5MB</div>
                        </div>
                        <div class="preview-container text-center d-none">
                            <img id="imagePreview" src="#" alt="Preview" class="img-fluid rounded mb-3" style="max-height: 200px;">
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="button" class="btn btn-purple" id="uploadPictureBtn">
                        <i class="fas fa-upload me-2"></i>Upload Picture
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Account Modal -->
    <div class="modal fade" id="deleteAccountModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Delete Account</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="deleteAccountForm" action="UserController" method="post">
                        <input type="hidden" name="action" value="deleteAccount">
                        <div class="form-floating mb-3">
                            <input type="password" class="form-control" id="deletePassword" name="password" required>
                            <label for="deletePassword">Enter your password to confirm</label>
                        </div>
                        <div class="text-end">
                            <button type="button" class="btn btn-secondary me-2" data-bs-dismiss="modal">Cancel</button>
                            <button type="submit" class="btn btn-danger">Delete Account</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- AOS Animation Library -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/js2/Profile.js"></script>
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true
        });
    </script>
</body>
</html>