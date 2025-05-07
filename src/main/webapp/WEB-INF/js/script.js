// Initialize AOS animations
AOS.init();

// Password visibility toggle
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

// Password strength checker
const passwordInput = document.getElementById('password');
const strengthDiv = document.getElementById('passwordStrength');
const strengthText = document.getElementById('strengthText');
const strengthProgress = document.getElementById('strengthProgress');
const requirements = {
    length: document.getElementById('length'),
    uppercase: document.getElementById('uppercase'),
    lowercase: document.getElementById('lowercase'),
    number: document.getElementById('number'),
    special: document.getElementById('special')
};

if (passwordInput) {
    passwordInput.addEventListener('input', function() {
        const password = this.value;
        let strength = 0;
        
        // Show strength div if password is not empty
        if (password.length > 0) {
            strengthDiv.classList.remove('d-none');
        } else {
            strengthDiv.classList.add('d-none');
            return;
        }
        
        // Check password requirements
        const hasLength = password.length >= 8;
        const hasUppercase = /[A-Z]/.test(password);
        const hasLowercase = /[a-z]/.test(password);
        const hasNumber = /[0-9]/.test(password);
        const hasSpecial = /[!@#$%^&*(),.?":{}|<>]/.test(password);
        
        // Update requirement indicators
        updateRequirement(requirements.length, hasLength);
        updateRequirement(requirements.uppercase, hasUppercase);
        updateRequirement(requirements.lowercase, hasLowercase);
        updateRequirement(requirements.number, hasNumber);
        updateRequirement(requirements.special, hasSpecial);
        
        // Calculate strength
        strength += hasLength ? 20 : 0;
        strength += hasUppercase ? 20 : 0;
        strength += hasLowercase ? 20 : 0;
        strength += hasNumber ? 20 : 0;
        strength += hasSpecial ? 20 : 0;
        
        // Update strength indicator
        strengthProgress.style.width = `${strength}%`;
        if (strength <= 20) {
            strengthProgress.className = 'progress-bar bg-danger';
            strengthText.textContent = 'Weak';
        } else if (strength <= 40) {
            strengthProgress.className = 'progress-bar bg-warning';
            strengthText.textContent = 'Fair';
        } else if (strength <= 60) {
            strengthProgress.className = 'progress-bar bg-info';
            strengthText.textContent = 'Good';
        } else if (strength <= 80) {
            strengthProgress.className = 'progress-bar bg-primary';
            strengthText.textContent = 'Strong';
        } else {
            strengthProgress.className = 'progress-bar bg-success';
            strengthText.textContent = 'Very Strong';
        }
    });
}

function updateRequirement(element, isValid) {
    if (element) {
        const icon = element.querySelector('i');
        if (isValid) {
            icon.className = 'fas fa-check-circle text-success';
        } else {
            icon.className = 'fas fa-times-circle text-danger';
        }
    }
}

