document.addEventListener('DOMContentLoaded', function() {
    const descriptionField = document.getElementById('notice-description');
    const wordCountDisplay = document.createElement('div');
    wordCountDisplay.className = 'word-count';
    wordCountDisplay.style.color = '#666';
    wordCountDisplay.style.fontSize = '0.9em';
    wordCountDisplay.style.marginTop = '5px';
    
    // Insert the word count display after the description field
    descriptionField.parentNode.insertBefore(wordCountDisplay, descriptionField.nextSibling);

    function updateWordCount() {
        const text = descriptionField.value.trim();
        const words = text.split(/\s+/).filter(word => word.length > 0);
        const wordCount = words.length;
        
        wordCountDisplay.textContent = `${wordCount}/75 words`;
        
        if (wordCount > 75) {
            wordCountDisplay.style.color = '#dc3545';
            descriptionField.style.borderColor = '#dc3545';
        } else {
            wordCountDisplay.style.color = '#666';
            descriptionField.style.borderColor = '#ced4da';
        }
    }

    // Add event listeners for input and paste events
    descriptionField.addEventListener('input', updateWordCount);
    descriptionField.addEventListener('paste', function(e) {
        // Allow the paste to happen first
        setTimeout(updateWordCount, 0);
    });

    // Add form validation
    const noticeForm = document.getElementById('notice-form');
    if (noticeForm) {
        noticeForm.addEventListener('submit', function(e) {
            const text = descriptionField.value.trim();
            const words = text.split(/\s+/).filter(word => word.length > 0);
            
            if (words.length > 75) {
                e.preventDefault();
                alert('Description cannot exceed 75 words. Please shorten your text.');
                descriptionField.focus();
            }
        });
    }

    // Initial word count update
    updateWordCount();
}); /**
 * 
 */