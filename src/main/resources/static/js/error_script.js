document.addEventListener('DOMContentLoaded', function() {
    /**
     * Inicializa el cierre visual de notificaciones sin recargar la página.
     */
    const closeButtons = document.querySelectorAll('.close-button');
    
    closeButtons.forEach(button => {
        /**
         * Oculta la notificación contenedora del botón pulsado.
         */
        button.addEventListener('click', function() {
            const notification = button.parentElement;
            notification.style.display = 'none';
        });
    });
});
