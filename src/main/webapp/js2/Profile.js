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
    console.log('Document ready - initializing event handlers');
    
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

    // Toggle Password Form
    $('#togglePasswordForm').click(function() {
        $('#changePasswordForm').toggleClass('d-none');
        $(this).toggleClass('d-none');
    });

    $('#cancelPasswordChange').click(function() {
        $('#changePasswordForm').addClass('d-none');
        $('#togglePasswordForm').removeClass('d-none');
        $('#changePasswordForm')[0].reset();
        $('.password-strength .progress-bar').css('width', '0%');
        $('.password-strength-text').text('Too weak');
    });

    // Toggle Password Visibility
    $('.toggle-password').click(function() {
        const input = $(this).closest('.input-group').find('input');
        const icon = $(this).find('i');
        
        if (input.attr('type') === 'password') {
            input.attr('type', 'text');
            icon.removeClass('fa-eye').addClass('fa-eye-slash');
        } else {
            input.attr('type', 'password');
            icon.removeClass('fa-eye-slash').addClass('fa-eye');
        }
    });

    // Profile Picture Preview and Validation
    $('#profilePicture').change(function() {
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
                $('#imagePreview').attr('src', e.target.result);
                $('.preview-container').removeClass('d-none');
            }
            reader.readAsDataURL(file);
        } else {
            $('.preview-container').addClass('d-none');
        }
    });

    // Profile Picture Form Submission
    $('#uploadPictureBtn').click(function(e) {
        e.preventDefault();
        
        const fileInput = $('#profilePicture')[0];
        const file = fileInput.files[0];
        
        if (!file) {
            showToast('Please select a file to upload', 'error');
            return;
        }

        // Check file size (max 5MB)
        if (file.size > 5 * 1024 * 1024) {
            showToast('File size must be less than 5MB', 'error');
            return;
        }

        // Check file type
        const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
        if (!validTypes.includes(file.type)) {
            showToast('Please select a valid image file (JPEG, PNG, or GIF)', 'error');
            return;
        }

        showLoading();
        
        // Create FormData object
        const formData = new FormData();
        formData.append('profilePicture', file);
        
        // Send AJAX request
        $.ajax({
            url: 'uploadProfilePicture',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                hideLoading();
                try {
                    const result = typeof response === 'string' ? JSON.parse(response) : response;
                    if (result.success) {
                        showToast(result.message || 'Profile picture updated successfully', 'success');
                        // Close modal
                        $('#changePictureModal').modal('hide');
                        // Update the profile picture immediately
                        if (result.filename) {
                            const timestamp = new Date().getTime();
                            const newImagePath = 'uploads/profiles/' + result.filename + '?t=' + timestamp;
                            $('.profile-picture').attr('src', newImagePath);
                        }
                        // Reload page after a short delay
                        setTimeout(() => {
                            window.location.reload();
                        }, 1500);
                    } else {
                        showToast(result.message || 'Failed to update profile picture', 'error');
                    }
                } catch (e) {
                    console.error('Error parsing response:', e);
                    showToast('An error occurred while processing the response', 'error');
                }
            },
            error: function(xhr, status, error) {
                hideLoading();
                console.error('Upload failed:', error);
                showToast('Failed to upload profile picture. Please try again.', 'error');
            }
        });
    });

    // Add click handler for the change picture button
    $(document).on('click', '.change-picture-btn', function() {
        console.log('Change picture button clicked');
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

    // Function to upload photo from any directory
    function uploadPhotoFromDirectory() {
        // Create a file input element
        const fileInput = document.createElement('input');
        fileInput.type = 'file';
        fileInput.accept = 'image/jpeg,image/png,image/gif';
        fileInput.style.display = 'none';
        document.body.appendChild(fileInput);

        // Handle file selection
        fileInput.addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                // Check file size (max 5MB)
                if (file.size > 5 * 1024 * 1024) {
                    showToast('File size must be less than 5MB', 'error');
                    return;
                }

                // Check file type
                const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
                if (!validTypes.includes(file.type)) {
                    showToast('Please select a valid image file (JPEG, PNG, or GIF)', 'error');
                    return;
                }

                // Show preview
                const reader = new FileReader();
                reader.onload = function(e) {
                    $('#profilePicture').attr('src', e.target.result);
                    $('.preview-container').removeClass('d-none');
                };
                reader.readAsDataURL(file);

                // Upload the file
                const formData = new FormData();
                formData.append('profilePicture', file);

                showLoading();

                $.ajax({
                    url: '/VideoBrowsingSystem/uploadProfilePicture',
                    type: 'POST',
                    data: formData,
                    processData: false,
                    contentType: false,
                    success: function(response) {
                        hideLoading();
                        try {
                            const result = typeof response === 'string' ? JSON.parse(response) : response;
                            if (result.success) {
                                showToast(result.message || 'Profile picture updated successfully', 'success');
                                // Update the profile picture immediately
                                if (result.filename) {
                                    const timestamp = new Date().getTime();
                                    $('#profilePicture').attr('src', '/VideoBrowsingSystem/uploads/profiles/' + result.filename + '?t=' + timestamp);
                                }
                                // Reload page after a short delay
                                setTimeout(() => {
                                    window.location.reload();
                                }, 1500);
                            } else {
                                showToast(result.message || 'Failed to update profile picture', 'error');
                            }
                        } catch (e) {
                            console.error('Error parsing response:', e);
                            showToast('An error occurred while processing the response', 'error');
                        }
                    },
                    error: function(xhr, status, error) {
                        hideLoading();
                        console.error('Upload error:', error);
                        let errorMessage = 'An error occurred while uploading the profile picture';
                        try {
                            const response = JSON.parse(xhr.responseText);
                            if (response.message) {
                                errorMessage = response.message;
                            }
                        } catch (e) {
                            console.error('Error parsing error response:', e);
                        }
                        showToast(errorMessage, 'error');
                    }
                });
            }
        });

        // Trigger file input click
        fileInput.click();

        // Clean up
        setTimeout(() => {
            document.body.removeChild(fileInput);
        }, 1000);
    }

    // Add click handler for the upload button
    $('#uploadPhotoBtn').click(function(e) {
        e.preventDefault();
        uploadPhotoFromDirectory();
    });

    // Add drag and drop functionality
    $(document).on('dragover', function(e) {
        e.preventDefault();
        e.stopPropagation();
    });

    $(document).on('drop', function(e) {
        e.preventDefault();
        e.stopPropagation();

        const file = e.originalEvent.dataTransfer.files[0];
        if (file) {
            // Check file size (max 5MB)
            if (file.size > 5 * 1024 * 1024) {
                showToast('File size must be less than 5MB', 'error');
                return;
            }

            // Check file type
            const validTypes = ['image/jpeg', 'image/png', 'image/gif'];
            if (!validTypes.includes(file.type)) {
                showToast('Please select a valid image file (JPEG, PNG, or GIF)', 'error');
                return;
            }

            // Show preview
            const reader = new FileReader();
            reader.onload = function(e) {
                $('#profilePicture').attr('src', e.target.result);
                $('.preview-container').removeClass('d-none');
            };
            reader.readAsDataURL(file);

            // Upload the file
            const formData = new FormData();
            formData.append('profilePicture', file);

            showLoading();

            $.ajax({
                url: '/VideoBrowsingSystem/uploadProfilePicture',
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function(response) {
                    hideLoading();
                    try {
                        const result = typeof response === 'string' ? JSON.parse(response) : response;
                        if (result.success) {
                            showToast(result.message || 'Profile picture updated successfully', 'success');
                            // Update the profile picture immediately
                            if (result.filename) {
                                const timestamp = new Date().getTime();
                                $('#profilePicture').attr('src', '/VideoBrowsingSystem/uploads/profiles/' + result.filename + '?t=' + timestamp);
                            }
                            // Reload page after a short delay
                            setTimeout(() => {
                                window.location.reload();
                            }, 1500);
                        } else {
                            showToast(result.message || 'Failed to update profile picture', 'error');
                        }
                    } catch (e) {
                        console.error('Error parsing response:', e);
                        showToast('An error occurred while processing the response', 'error');
                    }
                },
                error: function(xhr, status, error) {
                    hideLoading();
                    console.error('Upload error:', error);
                    let errorMessage = 'An error occurred while uploading the profile picture';
                    try {
                        const response = JSON.parse(xhr.responseText);
                        if (response.message) {
                            errorMessage = response.message;
                        }
                    } catch (e) {
                        console.error('Error parsing error response:', e);
                    }
                    showToast(errorMessage, 'error');
                }
            });
        }
    });
});
