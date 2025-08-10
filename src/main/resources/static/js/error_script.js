document.addEventListener('DOMContentLoaded', function() {
    const closeButtons = document.querySelectorAll('.close-button');
    
    closeButtons.forEach(button => {
        button.addEventListener('click', function() {
            const notification = button.parentElement;
            notification.style.display = 'none';
        });
    });
});