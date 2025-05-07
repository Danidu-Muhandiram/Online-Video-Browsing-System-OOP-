// Form validation and initialization
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM Content Loaded');
    
    try {
        // Initialize AOS animations
        if (typeof AOS !== 'undefined') {
            AOS.init();
            console.log('AOS initialized successfully');
        } else {
            console.error('AOS is not defined');
        }

        // Form validation
        const form = document.getElementById('signupForm');
        if (form) {
            console.log('Signup form found');
            form.addEventListener('submit', function(event) {
                if (!form.checkValidity()) {
                    event.preventDefault();
                    event.stopPropagation();
                    console.log('Form validation failed');
                }
                form.classList.add('was-validated');
            });
        } else {
            console.error('Signup form not found');
        }

        // Password visibility toggle
        const toggleButtons = document.querySelectorAll('.toggle-password');
        console.log('Found toggle buttons:', toggleButtons.length);
        
        toggleButtons.forEach(button => {
            button.addEventListener('click', function(event) {
                const input = this.parentElement.querySelector('input');
                const icon = this.querySelector('i');
                
                if (!input || !icon) {
                    console.error('Input or icon not found');
                    return;
                }
                
                // Toggle password visibility
                if (input.type === 'password') {
                    input.type = 'text';
                    icon.classList.remove('fa-eye');
                    icon.classList.add('fa-eye-slash');
                } else {
                    input.type = 'password';
                    icon.classList.remove('fa-eye-slash');
                    icon.classList.add('fa-eye');
                }
                
                // Prevent form submission
                event.preventDefault();
            });
        });

        // Password strength checker and confirmation validation
        const password = document.getElementById('password');
        const confirmPassword = document.getElementById('confirmPassword');
        const strengthDiv = document.getElementById('passwordStrength');
        const strengthText = document.getElementById('strengthText');
        const strengthProgress = document.getElementById('strengthProgress');

        if (password && confirmPassword && strengthDiv && strengthText && strengthProgress) {
            console.log('All password elements found');
            
            // Password strength checker
            password.addEventListener('input', function() {
                const value = this.value;
                if (value.length > 0) {
                    strengthDiv.classList.remove('d-none');
                    
                    let strength = 0;
                    const requirements = {
                        length: value.length >= 8,
                        uppercase: /[A-Z]/.test(value),
                        lowercase: /[a-z]/.test(value),
                        number: /[0-9]/.test(value),
                        special: /[^A-Za-z0-9]/.test(value)
                    };
                    
                    Object.values(requirements).forEach(met => {
                        if (met) strength += 20;
                    });
                    
                    // Update progress bar
                    strengthProgress.style.width = strength + '%';
                    
                    // Update text and color
                    if (strength <= 20) {
                        strengthText.textContent = 'Very Weak';
                        strengthProgress.className = 'progress-bar bg-danger';
                    } else if (strength <= 40) {
                        strengthText.textContent = 'Weak';
                        strengthProgress.className = 'progress-bar bg-warning';
                    } else if (strength <= 60) {
                        strengthText.textContent = 'Medium';
                        strengthProgress.className = 'progress-bar bg-info';
                    } else if (strength <= 80) {
                        strengthText.textContent = 'Strong';
                        strengthProgress.className = 'progress-bar bg-primary';
                    } else {
                        strengthText.textContent = 'Very Strong';
                        strengthProgress.className = 'progress-bar bg-success';
                    }
                    
                    // Update requirement icons
                    Object.entries(requirements).forEach(([req, met]) => {
                        const icon = document.querySelector(`#${req} i`);
                        if (icon) {
                            if (met) {
                                icon.className = 'fas fa-check-circle text-success';
                            } else {
                                icon.className = 'fas fa-times-circle text-danger';
                            }
                        }
                    });

                    // Check password confirmation
                    if (confirmPassword.value) {
                        validatePasswordConfirmation();
                    }
                } else {
                    strengthDiv.classList.add('d-none');
                }
            });

            // Password confirmation validation
            confirmPassword.addEventListener('input', validatePasswordConfirmation);
        } else {
            console.error('Some password elements not found:', {
                password: !!password,
                confirmPassword: !!confirmPassword,
                strengthDiv: !!strengthDiv,
                strengthText: !!strengthText,
                strengthProgress: !!strengthProgress
            });
        }

        function validatePasswordConfirmation() {
            if (password.value !== confirmPassword.value) {
                confirmPassword.setCustomValidity('Passwords do not match');
            } else {
                confirmPassword.setCustomValidity('');
            }
        }
    } catch (error) {
        console.error('Error in initialization:', error);
    }
});

