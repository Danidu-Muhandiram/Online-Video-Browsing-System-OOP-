<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="UserPackage.UserModel" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - GameHUB</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
    <style>
        .profile-header {
            background: linear-gradient(rgba(0, 0, 0, 0.7), rgba(0, 0, 0, 0.7)),
                        url('${pageContext.request.contextPath}/images/profile-bg.jpg');
            background-size: cover;
            background-position: center;
            padding: 4rem 0;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
        }
        .profile-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: linear-gradient(45deg, var(--purple), transparent);
            opacity: 0.3;
            animation: gradientShift 10s ease infinite;
        }
        @keyframes gradientShift {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .profile-picture {
            width: 150px;
            height: 150px;
            border-radius: 50%;
            object-fit: cover;
            border: 4px solid var(--purple);
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
        }
        .profile-picture:hover {
            transform: scale(1.05) rotate(5deg);
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.5);
        }
        .profile-picture-container {
            position: relative;
            display: inline-block;
        }
        .profile-picture-edit {
            position: absolute;
            bottom: 10px;
            right: 10px;
            background: var(--purple);
            color: white;
            width: 40px;
            height: 40px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        }
        .profile-picture-edit:hover {
            background: var(--purple-hover);
            transform: scale(1.1);
        }
        .profile-stats {
            display: flex;
            gap: 2rem;
            margin-top: 1rem;
        }
        .stat-item {
            text-align: center;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        .stat-item:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
        }
        .stat-value {
            font-size: 1.5rem;
            font-weight: bold;
            color: var(--purple);
            margin-bottom: 0.5rem;
        }
        .stat-label {
            color: var(--text-secondary);
            font-size: 0.9rem;
        }
        .profile-section {
            background: var(--bg-card);
            border-radius: 1rem;
            padding: 2rem;
            margin-bottom: 2rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .profile-section:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
        }
        .profile-section-title {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            color: var(--text-primary);
        }
        .profile-section-title .btn {
            font-size: 0.9rem;
            transition: all 0.3s ease;
        }
        .profile-section-title .btn:hover {
            transform: translateY(-2px);
        }
        .form-floating {
            margin-bottom: 1rem;
        }
        .form-floating > .form-control {
            background-color: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
            transition: all 0.3s ease;
        }
        .form-floating > .form-control:focus {
            background-color: rgba(255, 255, 255, 0.1);
            border-color: var(--purple);
            box-shadow: 0 0 0 0.25rem rgba(var(--purple-rgb), 0.25);
        }
        .form-floating > label {
            color: var(--text-secondary);
        }
        .danger-zone {
            border: 1px solid #dc3545;
            border-radius: 1rem;
            padding: 2rem;
            margin-top: 3rem;
            transition: all 0.3s ease;
        }
        .danger-zone:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(220, 53, 69, 0.2);
        }
        .danger-zone-title {
            color: #dc3545;
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }
        .toast-container {
            position: fixed;
            top: 20px;
            right: 20px;
            z-index: 1000;
        }
        .custom-toast {
            background: var(--bg-card);
            border: 1px solid rgba(255, 255, 255, 0.1);
            color: var(--text-primary);
        }
        .loading-spinner {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.7);
            z-index: 9999;
            justify-content: center;
            align-items: center;
        }
        .loading-spinner.show {
            display: flex;
        }
    </style>
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
                        <div class="profile-picture-edit" data-bs-toggle="modal" data-bs-target="#changePictureModal">
                            <i class="fas fa-camera"></i>
                        </div>
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
                <div class="row">
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="firstName" name="firstName" 
                                   value="<%= user.getFirstName() %>" readonly
                                   pattern="[A-Za-z\s]{2,50}" title="First name should only contain letters and spaces (2-50 characters)">
                            <label for="firstName">First Name</label>
                            <div class="invalid-feedback">Please enter a valid first name (2-50 characters, letters only)</div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="form-floating">
                            <input type="text" class="form-control" id="lastName" name="lastName" 
                                   value="<%= user.getLastName() %>" readonly
                                   pattern="[A-Za-z\s]{2,50}" title="Last name should only contain letters and spaces (2-50 characters)">
                            <label for="lastName">Last Name</label>
                            <div class="invalid-feedback">Please enter a valid last name (2-50 characters, letters only)</div>
                        </div>
                    </div>
                </div>
                <div class="form-floating">
                    <input type="email" class="form-control" id="email" name="email" 
                           value="<%= user.getEmail() %>" readonly
                           pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" title="Please enter a valid email address">
                    <label for="email">Email Address</label>
                    <div class="invalid-feedback">Please enter a valid email address</div>
                </div>
                <div class="form-floating">
                    <input type="text" class="form-control" id="username" name="username" 
                           value="<%= user.getUsername() %>" readonly
                           pattern="[A-Za-z0-9_]{3,20}" title="Username should be 3-20 characters (letters, numbers, and underscores only)">
                    <label for="username">Username</label>
                    <div class="invalid-feedback">Username should be 3-20 characters (letters, numbers, and underscores only)</div>
                </div>
                <div class="text-end d-none" id="personalInfoActions">
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
            </div>
            <form id="changePasswordForm" action="UserController" method="post">
                <input type="hidden" name="action" value="changePassword">
                <div class="form-floating">
                    <input type="password" class="form-control" id="currentPassword" name="currentPassword" required>
                    <label for="currentPassword">Current Password</label>
                    <div class="invalid-feedback">Please enter your current password</div>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="newPassword" name="newPassword" required
                           pattern="^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$"
                           title="Password must be at least 8 characters long and include letters, numbers, and special characters">
                    <label for="newPassword">New Password</label>
                    <div class="invalid-feedback">Password must be at least 8 characters long and include letters, numbers, and special characters</div>
                </div>
                <div class="form-floating">
                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                    <label for="confirmPassword">Confirm New Password</label>
                    <div class="invalid-feedback">Passwords do not match</div>
                </div>
                <div class="password-strength mt-2 mb-3">
                    <div class="progress" style="height: 5px;">
                        <div class="progress-bar" role="progressbar" style="width: 0%"></div>
                    </div>
                    <small class="text-muted password-strength-text">Password strength: Too weak</small>
                </div>
                <div class="text-end">
                    <button type="submit" class="btn btn-purple">
                        <i class="fas fa-key me-2"></i>Change Password
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
    <div class="modal fade" id="changePictureModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Change Profile Picture</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form id="changePictureForm" action="UserController" method="post" enctype="multipart/form-data">
                        <input type="hidden" name="action" value="updateProfilePicture">
                        <div class="mb-3">
                            <label for="profilePictureFile" class="form-label">Choose a new profile picture</label>
                            <input type="file" class="form-control" id="profilePictureFile" name="profilePicture" 
                                   accept="image/*" required>
                        </div>
                        <div class="text-end">
                            <button type="submit" class="btn btn-purple">Upload Picture</button>
                        </div>
                    </form>
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
    
    <script>
        // Initialize AOS
        AOS.init({
            duration: 800,
            once: true
        });
        
        // Show loading spinner
        function showLoading() {
            $('.loading-spinner').addClass('show');
        }
        
        // Hide loading spinner
        function hideLoading() {
            $('.loading-spinner').removeClass('show');
        }
        
        // Show toast message
        function showToast(message, type = 'success') {
            const toastClass = type === 'error' ? 'bg-danger' : 'bg-success';
            const toast = '<div class="toast custom-toast ' + toastClass + '" role="alert">' +
                         '<div class="toast-body text-white">' +
                         message +
                         '</div>' +
                         '</div>';
            $('.toast-container').append(toast);
            const toastElement = $('.toast').last();
            const bsToast = new bootstrap.Toast(toastElement, {
                autohide: true,
                delay: 5000
            });
            bsToast.show();
        }
        
        $(document).ready(function() {
            // Check for error messages in URL parameters
            const urlParams = new URLSearchParams(window.location.search);
            const error = urlParams.get('error');
            if (error) {
                showToast(decodeURIComponent(error), 'error');
            }
            
            // Check for success messages in URL parameters
            const success = urlParams.get('success');
            if (success) {
                showToast(decodeURIComponent(success), 'success');
            }

            // Enhanced Personal Information Form Handling
            $('#editPersonalInfo').click(function() {
                $('#personalInfoForm input').prop('readonly', false);
                $('#personalInfoActions').removeClass('d-none');
                $(this).addClass('d-none');
                
                // Add input validation classes
                $('#personalInfoForm input').addClass('needs-validation');
            });

            $('#cancelPersonalInfo').click(function() {
                $('#personalInfoForm input').prop('readonly', true);
                $('#personalInfoForm input').removeClass('is-invalid');
                $('#personalInfoActions').addClass('d-none');
                $('#editPersonalInfo').removeClass('d-none');
                // Reset form values
                $('#personalInfoForm')[0].reset();
            });

            // Real-time validation for personal information form
            $('#personalInfoForm input').on('input', function() {
                if (this.checkValidity()) {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                } else {
                    $(this).removeClass('is-valid').addClass('is-invalid');
                }
            });

            // Enhanced Password Form Validation
            let passwordStrength = 0;
            
            function updatePasswordStrength(password) {
                let strength = 0;
                
                // Length check
                if (password.length >= 8) strength += 1;
                
                // Contains number
                if (/\d/.test(password)) strength += 1;
                
                // Contains letter
                if (/[A-Za-z]/.test(password)) strength += 1;
                
                // Contains special character
                if (/[^A-Za-z0-9]/.test(password)) strength += 1;
                
                // Contains both uppercase and lowercase
                if (/[A-Z]/.test(password) && /[a-z]/.test(password)) strength += 1;
                
                passwordStrength = strength;
                
                // Update progress bar
                const progressBar = $('.password-strength .progress-bar');
                const strengthText = $('.password-strength-text');
                
                progressBar.css('width', (strength * 20) + '%');
                
                if (strength <= 1) {
                    progressBar.removeClass().addClass('progress-bar bg-danger');
                    strengthText.text('Password strength: Too weak');
                } else if (strength <= 3) {
                    progressBar.removeClass().addClass('progress-bar bg-warning');
                    strengthText.text('Password strength: Medium');
                } else {
                    progressBar.removeClass().addClass('progress-bar bg-success');
                    strengthText.text('Password strength: Strong');
                }
            }

            $('#newPassword').on('input', function() {
                updatePasswordStrength($(this).val());
                
                // Check if passwords match
                if ($('#confirmPassword').val()) {
                    if ($(this).val() === $('#confirmPassword').val()) {
                        $('#confirmPassword').removeClass('is-invalid').addClass('is-valid');
                    } else {
                        $('#confirmPassword').removeClass('is-valid').addClass('is-invalid');
                    }
                }
            });

            $('#confirmPassword').on('input', function() {
                if ($(this).val() === $('#newPassword').val()) {
                    $(this).removeClass('is-invalid').addClass('is-valid');
                } else {
                    $(this).removeClass('is-valid').addClass('is-invalid');
                }
            });

            // Change Password Form Validation
            $('#changePasswordForm').submit(function(e) {
                e.preventDefault();
                const currentPassword = $('#currentPassword').val();
                const newPassword = $('#newPassword').val();
                const confirmPassword = $('#confirmPassword').val();
                let isValid = true;

                if (!currentPassword) {
                    $('#currentPassword').addClass('is-invalid');
                    isValid = false;
                }

                if (passwordStrength < 3) {
                    showToast('Please choose a stronger password', 'error');
                    isValid = false;
                }

                if (newPassword !== confirmPassword) {
                    $('#confirmPassword').addClass('is-invalid');
                    showToast('New passwords do not match!', 'error');
                    isValid = false;
                }

                if (isValid) {
                    showLoading();
                    this.submit();
                }
            });

            // Profile Picture Preview and Validation
            $('#profilePictureFile').change(function() {
                const file = this.files[0];
                if (file) {
                    // Check file size (max 5MB)
                    if (file.size > 5 * 1024 * 1024) {
                        showToast('File size must be less than 5MB', 'error');
                        this.value = '';
                        return;
                    }

                    // Check file type
                    const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
                    if (!validTypes.includes(file.type)) {
                        showToast('Please select a valid image file (JPEG, PNG, or GIF)', 'error');
                        this.value = '';
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function(e) {
                        $('#profilePicture').attr('src', e.target.result);
                    }
                    reader.readAsDataURL(file);
                }
            });

            // Delete Account Confirmation
            $('#deleteAccountForm').submit(function(e) {
                e.preventDefault();
                const password = $('#deletePassword').val();
                
                if (!password) {
                    showToast('Please enter your password to confirm account deletion', 'error');
                    return;
                }

                if (confirm('Are you sure you want to delete your account? This action cannot be undone.')) {
                    showLoading();
                    this.submit();
                }
            });
            
            // Form submission handlers
            $('form').on('submit', function() {
                showLoading();
            });
            
            // Handle form submission success
            $(document).ajaxSuccess(function(event, xhr, settings) {
                hideLoading();
                if (xhr.responseJSON) {
                    if (xhr.responseJSON.message) {
                        showToast(xhr.responseJSON.message, xhr.responseJSON.type || 'success');
                    }
                    if (xhr.responseJSON.redirect) {
                        window.location.href = xhr.responseJSON.redirect;
                    }
                }
            });
            
            // Handle form submission error
            $(document).ajaxError(function(event, xhr, settings, error) {
                hideLoading();
                let errorMessage = 'An error occurred. Please try again.';
                
                if (xhr.responseJSON && xhr.responseJSON.message) {
                    errorMessage = xhr.responseJSON.message;
                } else if (xhr.status === 409) {
                    errorMessage = 'This email address is already registered.';
                } else if (xhr.status === 401) {
                    errorMessage = 'Invalid password. Please try again.';
                } else if (xhr.status === 404) {
                    errorMessage = 'The requested resource was not found.';
                }
                
                showToast(errorMessage, 'error');
            });
        });
    </script>
</body>
</html>