// Dark Mode Toggle
const darkModeToggle = document.getElementById('darkModeToggle');
const htmlElement = document.documentElement;

// Check for saved theme preference
const savedTheme = localStorage.getItem('theme');
if (savedTheme) {
    htmlElement.setAttribute('data-theme', savedTheme);
    updateDarkModeIcon(savedTheme === 'dark');
}

darkModeToggle.addEventListener('click', () => {
    const currentTheme = htmlElement.getAttribute('data-theme');
    const newTheme = currentTheme === 'dark' ? 'light' : 'dark';
    
    htmlElement.setAttribute('data-theme', newTheme);
    localStorage.setItem('theme', newTheme);
    updateDarkModeIcon(newTheme === 'dark');
});

function updateDarkModeIcon(isDark) {
    const icon = darkModeToggle.querySelector('i');
    icon.className = isDark ? 'fas fa-sun' : 'fas fa-moon';
}

// Sample Video Data (Replace with actual API data)
const sampleVideos = [
    {
        id: 1,
        title: 'Introduction to Web Development',
        thumbnail: 'https://picsum.photos/300/169',
        duration: '10:30',
        views: '1.2K',
        uploadDate: '2024-02-20',
        creator: 'Tech Academy'
    },
    // Add more sample videos here
];

// Populate Video Grid
function populateVideoGrid() {
    const videoGrid = document.getElementById('videoGrid');
    
    sampleVideos.forEach(video => {
        const videoCard = createVideoCard(video);
        videoGrid.appendChild(videoCard);
    });
}

function createVideoCard(video) {
    const col = document.createElement('div');
    col.className = 'col-sm-6 col-md-4 col-lg-3';
    
    col.innerHTML = `
        <div class="video-card" onclick="openVideoPlayer('${video.id}')">
            <div class="video-thumbnail">
                <img src="${video.thumbnail}" alt="${video.title}">
                <span class="video-duration">${video.duration}</span>
            </div>
            <div class="p-2">
                <h6 class="mb-1">${video.title}</h6>
                <small class="text-muted">
                    ${video.creator} • ${video.views} views • ${formatDate(video.uploadDate)}
                </small>
            </div>
        </div>
    `;
    
    return col;
}

function formatDate(dateString) {
    const date = new Date(dateString);
    return date.toLocaleDateString('en-US', { 
        year: 'numeric', 
        month: 'short', 
        day: 'numeric' 
    });
}

// Video Player Functions
function openVideoPlayer(videoId) {
    const modal = new bootstrap.Modal(document.getElementById('videoPlayerModal'));
    // Here you would typically fetch the video data and update the player
    modal.show();
}

// Keyboard Shortcuts
document.addEventListener('keydown', (e) => {
    if (e.code === 'Space' && e.target.tagName !== 'INPUT' && e.target.tagName !== 'TEXTAREA') {
        e.preventDefault();
        const video = document.getElementById('mainVideoPlayer');
        if (video) {
            video.paused ? video.play() : video.pause();
        }
    }
});

// Infinite Scroll
let isLoading = false;
window.addEventListener('scroll', () => {
    if (isLoading) return;
    
    const scrollPosition = window.innerHeight + window.scrollY;
    const pageHeight = document.documentElement.scrollHeight;
    
    if (scrollPosition >= pageHeight - 500) {
        loadMoreVideos();
    }
});

function loadMoreVideos() {
    isLoading = true;
    // Simulate API call delay
    setTimeout(() => {
        // Add more videos to the grid
        populateVideoGrid();
        isLoading = false;
    }, 1000);
}

// Initialize
document.addEventListener('DOMContentLoaded', () => {
    populateVideoGrid();
    
    // Handle login form submission
    document.getElementById('loginForm')?.addEventListener('submit', (e) => {
        e.preventDefault();
        // Add login logic here
    });

    // Sidebar Toggle
    const sidebarToggle = document.getElementById('sidebarToggle');
    const sidebar = document.querySelector('.sidebar');
    const mainContent = document.querySelector('.col-md-9');
    
    // Create overlay for mobile
    const overlay = document.createElement('div');
    overlay.className = 'sidebar-overlay';
    document.body.appendChild(overlay);

    function toggleSidebar() {
        sidebar?.classList.toggle('show');
        overlay.classList.toggle('show');
        document.body.style.overflow = sidebar?.classList.contains('show') ? 'hidden' : '';
    }

    sidebarToggle?.addEventListener('click', toggleSidebar);
    overlay.addEventListener('click', toggleSidebar);

    // Playlist Toggle
    const playlistItems = document.querySelectorAll('.playlist-item');
    playlistItems.forEach(item => {
        item.addEventListener('click', () => {
            const submenu = item.nextElementSibling;
            const icon = item.querySelector('.playlist-toggle');
            
            // Toggle active state
            item.classList.toggle('active');
            
            // Animate submenu
            if (submenu?.style.display === 'none' || !submenu?.style.display) {
                submenu.style.display = 'block';
                submenu.style.maxHeight = '0px';
                setTimeout(() => {
                    submenu.style.maxHeight = submenu.scrollHeight + 'px';
                }, 0);
            } else {
                submenu.style.maxHeight = '0px';
                setTimeout(() => {
                    submenu.style.display = 'none';
                }, 300);
            }
            
            // Rotate icon
            if (icon) {
                icon.style.transform = item.classList.contains('active') ? 'rotate(90deg)' : 'rotate(0)';
            }
        });
    });

    // Hover effects for list items
    const listItems = document.querySelectorAll('.list-group-item');
    listItems.forEach(item => {
        item.addEventListener('mouseenter', () => {
            const icon = item.querySelector('i');
            if (icon) {
                icon.style.transform = 'scale(1.2)';
            }
        });

        item.addEventListener('mouseleave', () => {
            const icon = item.querySelector('i');
            if (icon) {
                icon.style.transform = 'scale(1)';
            }
        });
    });

    // Active state management
    const mainMenuItems = document.querySelectorAll('.nav-section .list-group-item');
    mainMenuItems.forEach(item => {
        if (!item.classList.contains('playlist-item')) {
            item.addEventListener('click', () => {
                // Remove active class from all items
                mainMenuItems.forEach(menuItem => menuItem.classList.remove('active'));
                // Add active class to clicked item
                item.classList.add('active');
            });
        }
    });

    // Handle subscription channel click
    const subscriptionItems = document.querySelectorAll('.subscription-item');
    subscriptionItems.forEach(item => {
        item.addEventListener('click', () => {
            const badge = item.querySelector('.badge');
            if (badge?.classList.contains('bg-danger')) {
                // Remove LIVE badge when clicked
                badge.remove();
            } else if (badge) {
                // Reset notification count
                badge.textContent = '0';
                badge.style.opacity = '0';
                setTimeout(() => badge.remove(), 300);
            }
        });
    });

    // Search Functionality
    const searchInput = document.getElementById('searchInput');
    const searchSuggestions = document.getElementById('searchSuggestions');
    let recentSearches = JSON.parse(localStorage.getItem('recentSearches') || '[]');

    function updateRecentSearches() {
        const suggestionsList = searchSuggestions?.querySelector('.suggestions-list');
        if (!suggestionsList) return;

        suggestionsList.innerHTML = '';
        recentSearches.forEach(search => {
            const div = document.createElement('div');
            div.className = 'p-2 d-flex align-items-center suggestion-item';
            div.innerHTML = `
                <i class="fas fa-history me-2 text-muted"></i>
                <span>${search}</span>
                <button class="btn btn-link btn-sm ms-auto remove-search" data-search="${search}">
                    <i class="fas fa-times"></i>
                </button>
            `;
            suggestionsList.appendChild(div);
        });
    }

    // Search Input Handler
    searchInput?.addEventListener('keyup', (e) => {
        if (e.key === 'Enter' && searchInput.value.trim()) {
            // Add to recent searches
            const search = searchInput.value.trim();
            recentSearches = [search, ...recentSearches.filter(s => s !== search)].slice(0, 5);
            localStorage.setItem('recentSearches', JSON.stringify(recentSearches));
            updateRecentSearches();
            
            // Perform search (implement your search logic here)
            console.log('Searching for:', search);
        }
    });

    // Clear Recent Searches
    const clearSearchesBtn = searchSuggestions?.querySelector('.btn-link');
    clearSearchesBtn?.addEventListener('click', () => {
        recentSearches = [];
        localStorage.removeItem('recentSearches');
        updateRecentSearches();
    });

    // Remove Individual Search
    searchSuggestions?.addEventListener('click', (e) => {
        if (e.target.closest('.remove-search')) {
            const search = e.target.closest('.remove-search').dataset.search;
            recentSearches = recentSearches.filter(s => s !== search);
            localStorage.setItem('recentSearches', JSON.stringify(recentSearches));
            updateRecentSearches();
        }
    });

    // Initialize recent searches
    updateRecentSearches();

    // Notification Badge Update
    function updateNotificationBadge() {
        const badge = document.querySelector('.badge');
        const count = parseInt(badge?.textContent || '0');
        if (count > 0) {
            badge.style.animation = 'pulse 1s';
            setTimeout(() => badge.style.animation = '', 1000);
        }
    }

    // Notification Click Handler
    const notificationDropdown = document.querySelector('.notification-dropdown');
    notificationDropdown?.addEventListener('click', (e) => {
        if (e.target.closest('.notification-item')) {
            const badge = document.querySelector('.badge');
            const count = parseInt(badge?.textContent || '0');
            if (count > 0) {
                badge.textContent = count - 1;
                updateNotificationBadge();
            }
        }
    });
});

// Lazy Loading for Images
if ('IntersectionObserver' in window) {
    const imageObserver = new IntersectionObserver((entries, observer) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                const img = entry.target;
                img.src = img.dataset.src;
                observer.unobserve(img);
            }
        });
    });

    document.querySelectorAll('img[data-src]').forEach(img => {
        imageObserver.observe(img);
    });
}

// Share functionality
function shareVideo(videoId) {
    if (navigator.share) {
        navigator.share({
            title: 'Check out this video',
            url: `${window.location.origin}/video/${videoId}`
        }).catch(console.error);
    } else {
        // Fallback for browsers that don't support Web Share API
        const shareUrl = `${window.location.origin}/video/${videoId}`;
        navigator.clipboard.writeText(shareUrl)
            .then(() => alert('Link copied to clipboard!'))
            .catch(console.error);
    }
}

// Add these animations to your CSS
const style = document.createElement('style');
style.textContent = `
    @keyframes pulse {
        0% { transform: scale(1); }
        50% { transform: scale(1.2); }
        100% { transform: scale(1); }
    }

    @keyframes rotate {
        from { transform: rotate(0deg); }
        to { transform: rotate(360deg); }
    }

    .theme-transition {
        transition: all 0.3s ease-in-out;
    }

    .suggestion-item {
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .suggestion-item:hover {
        background-color: var(--secondary-color);
    }
`;
document.head.appendChild(style);

// Add dynamic badge update for new content
function updateBadgeCount(elementId, count) {
    const badge = document.querySelector(`#${elementId} .badge`);
    if (badge) {
        badge.textContent = count;
        badge.style.animation = 'pulse 0.5s ease';
        setTimeout(() => badge.style.animation = '', 500);
    }
}

// Simulate new content updates
setInterval(() => {
    const sections = ['watchLater', 'likedVideos'];
    const randomSection = sections[Math.floor(Math.random() * sections.length)];
    const randomCount = Math.floor(Math.random() * 5) + 1;
    updateBadgeCount(randomSection, randomCount);
}, 30000); 