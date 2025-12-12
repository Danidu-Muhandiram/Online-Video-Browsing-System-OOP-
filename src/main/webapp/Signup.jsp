<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up - GameHUB</title>
    <!-- Favicon -->
    <link rel="icon" type="image/png" sizes="32x32" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <link rel="icon" type="image/png" sizes="16x16" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <link rel="apple-touch-icon" href="https://cdn-icons-png.flaticon.com/512/3659/3659784.png">
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <!-- AOS Animation Library -->
    <link href="https://unpkg.com/aos@2.3.1/dist/aos.css" rel="stylesheet">
    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/styles.css">
</head>
<body class="dark-theme auth-page">
    <div class="auth-wrapper">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10 col-lg-10">
                    <div class="auth-card" data-aos="fade-right" data-aos-duration="800">
                        <div class="row g-0">
                            <div class="col-md-6 d-none d-md-block">
                                <div class="auth-image h-100">
                                    <div class="overlay"></div>
                                    <div class="auth-image-content">
                                        <div class="logo-wrapper mb-4">
                                            <a class="logo">
                                                <i class="fas fa-gamepad me-2 text-purple"></i>
                                                <span class="fw-bold">GameHUB</span>
                                            </a>
                                        </div>
                                        <h2 class="auth-image-title">Join Our Gaming Community</h2>
                                        <p class="auth-image-text">Discover, watch, and share your favorite gaming content.</p>
                                        <div class="auth-features">
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Access exclusive content</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Save your favorite videos</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Join live streaming events</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Discover your own creativity</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="auth-form-wrapper p-4 p-md-5">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h2 class="auth-title">Create Account</h2>
                                        <a href="${pageContext.request.contextPath}/index.jsp" class="d-md-none">
                                            <i class="fas fa-gamepad text-purple fs-4"></i>
                                        </a>
                                    </div>
                                    
                                    <form id="signupForm" class="auth-form" action="${pageContext.request.contextPath}/UserInsertServlet" method="post" novalidate>
                                        <div class="row">
                                            <div class="col-md-6 mb-3">
                                                <label for="firstName" class="form-label">First Name</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                                    <div class="invalid-feedback">Please enter your first name.</div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mb-3">
                                                <label for="lastName" class="form-label">Last Name</label>
                                                <div class="input-group">
                                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                                    <div class="invalid-feedback">Please enter your last name.</div>
                                                </div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="username" class="form-label">Username</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-at"></i></span>
                                                <input type="text" class="form-control" id="username" name="username" required>
                                                <div class="invalid-feedback">Please choose a username.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="email" class="form-label">Email Address</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                                <input type="email" class="form-control" id="email" name="email" required>
                                                <div class="invalid-feedback">Please enter a valid email address.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="password" class="form-label">Password</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                                <input type="password" class="form-control" id="password" name="password" required>
                                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <div class="invalid-feedback">Please enter a password.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="mb-3">
                                            <label for="confirmPassword" class="form-label">Confirm Password</label>
                                            <div class="input-group">
                                                <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                                <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" required>
                                                <button class="btn btn-outline-secondary toggle-password" type="button">
                                                    <i class="fas fa-eye"></i>
                                                </button>
                                                <div class="invalid-feedback">Passwords do not match.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="password-strength mb-3 d-none" id="passwordStrength">
                                            <p class="mb-2">Password strength: <span id="strengthText">Weak</span></p>
                                            <div class="progress">
                                                <div id="strengthProgress" class="progress-bar bg-danger" role="progressbar" style="width: 25%"></div>
                                            </div>
                                            <ul class="password-requirements mt-2">
                                                <li id="length"><i class="fas fa-times-circle"></i> At least 8 characters</li>
                                                <li id="uppercase"><i class="fas fa-times-circle"></i> At least 1 uppercase letter</li>
                                                <li id="lowercase"><i class="fas fa-times-circle"></i> At least 1 lowercase letter</li>
                                                <li id="number"><i class="fas fa-times-circle"></i> At least 1 number</li>
                                                <li id="special"><i class="fas fa-times-circle"></i> At least 1 special character</li>
                                            </ul>
                                        </div>
                                        
                                        <div class="mb-3 form-check">
                                            <input type="checkbox" class="form-check-input" id="termsCheck" name="termsCheck" required>
                                            <label class="form-check-label" for="termsCheck">
                                                I agree to the <a href="#" class="text-purple">Terms of Service</a> and <a href="#" class="text-purple">Privacy Policy</a>
                                            </label>
                                            <div class="invalid-feedback">You must agree before submitting.</div>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-purple w-100 btn-lg mb-3">
                                            <span class="spinner-border spinner-border-sm d-none me-2" role="status" aria-hidden="true" id="signupSpinner"></span>
                                            Create Account
                                        </button>
                                        
                                        <div class="text-center">
                                            <p class="mb-0">Already have an account? <a href="${pageContext.request.contextPath}/Login.jsp" class="text-purple">Log In</a></p>
                                        </div>
                                    </form>
                                    
                                    <div class="auth-divider">
                                        <span>or sign up with</span>
                                    </div>
                                    
                                    <div class="social-auth">
                                        <button class="btn btn-outline-light social-btn">
                                            <i class="fab fa-google"></i>
                                        </button>
                                        <button class="btn btn-outline-light social-btn">
                                            <i class="fab fa-facebook-f"></i>
                                        </button>
                                        <button class="btn btn-outline-light social-btn">
                                            <i class="fab fa-twitter"></i>
                                        </button>
                                        <button class="btn btn-outline-light social-btn">
                                            <i class="fab fa-discord"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <!-- AOS Animation Library -->
    <script src="https://unpkg.com/aos@2.3.1/dist/aos.js"></script>
    <!-- Custom JS -->
   
    <script src="${pageContext.request.contextPath}/js2/script.js"></script>
    
</body>
</html> 