<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - GameHUB</title>
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
                                            <a href="${pageContext.request.contextPath}/index.jsp" class="logo">
                                                <i class="fas fa-gamepad me-2 text-purple"></i>
                                                <span class="fw-bold">GameHUB</span>
                                            </a>
                                        </div>
                                        <h2 class="auth-image-title">Welcome Back!</h2>
                                        <p class="auth-image-text">Sign in to continue your gaming journey.</p>
                                        <div class="auth-features">
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Access your favorite content</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Track your progress</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Join live events</span>
                                            </div>
                                            <div class="auth-feature">
                                                <i class="fas fa-check-circle"></i>
                                                <span>Connect with gamers</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="auth-form-wrapper p-4 p-md-5">
                                    <div class="d-flex justify-content-between align-items-center mb-4">
                                        <h2 class="auth-title">Sign In</h2>
                                        <a href="${pageContext.request.contextPath}/index.jsp" class="d-md-none">
                                            <i class="fas fa-gamepad text-purple fs-4"></i>
                                        </a>
                                    </div>
                                    
                                    <% if (request.getAttribute("error") != null) { %>
                                        <div class="alert alert-danger" role="alert">
                                            <%= request.getAttribute("error") %>
                                        </div>
                                    <% } %>
                                    
                                    <form id="loginForm" class="auth-form" action="${pageContext.request.contextPath}/LoginServlet" method="post" novalidate>
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
                                                <div class="invalid-feedback">Please enter your password.</div>
                                            </div>
                                        </div>
                                        
                                        <div class="d-flex justify-content-between align-items-center mb-3">
                                            <div class="form-check">
                                                <input type="checkbox" class="form-check-input" id="rememberMe" name="rememberMe">
                                                <label class="form-check-label" for="rememberMe">Remember me</label>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/forgot-password.jsp" class="text-purple">Forgot Password?</a>
                                        </div>
                                        
                                        <button type="submit" class="btn btn-purple w-100 btn-lg mb-3">
                                            <span class="spinner-border spinner-border-sm d-none me-2" role="status" aria-hidden="true" id="loginSpinner"></span>
                                            Sign In
                                        </button>
                                        
                                        <div class="text-center">
                                            <p class="mb-0">Don't have an account? <a href="${pageContext.request.contextPath}/Signup.jsp" class="text-purple">Sign Up</a></p>
                                        </div>
                                    </form>
                                    
                                    <div class="auth-divider">
                                        <span>or sign in with</span>
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
    <script src="${pageContext.request.contextPath}/js/script.js"></script>
    
    <script>
        // Initialize AOS
        AOS.init();
        
        // Form validation
        (function() {
            'use strict';
            
            const form = document.getElementById('loginForm');
            
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                }
                form.classList.add('was-validated');
            });
            
            // Password toggle functionality
            document.querySelectorAll('.toggle-password').forEach(button => {
                button.addEventListener('click', function() {
                    const input = this.parentElement.querySelector('input');
                    const icon = this.querySelector('i');
                    
                    if (input.type === 'password') {
                        input.type = 'text';
                        icon.classList.remove('fa-eye');
                        icon.classList.add('fa-eye-slash');
                    } else {
                        input.type = 'password';
                        icon.classList.remove('fa-eye-slash');
                        icon.classList.add('fa-eye');
                    }
                });
            });
        })();
    </script>
</body>
</html> 