document.addEventListener('DOMContentLoaded', function() {
    /**
     * Inicializa el control de mostrar/ocultar contraseña.
     */
    const passwordInput = document.getElementById('password');
    const toggleIcon = document.getElementById('iconoMostrar');
    
    /**
     * Alterna el tipo del input password y actualiza el icono visual.
     */
    toggleIcon.addEventListener('click', function() {
        const type = passwordInput.getAttribute('type') === 'password' ? 'text' : 'password';
        passwordInput.setAttribute('type', type);
        
        toggleIcon.classList.toggle('fa-eye-slash');
    });
});
