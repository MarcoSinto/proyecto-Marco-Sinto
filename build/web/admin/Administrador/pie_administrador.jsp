
    <script>
        function toggleMenu() {
            var sidebar = document.querySelector('.sidebar');
            if (sidebar.style.display === 'none' || sidebar.style.display === '') {
                sidebar.style.display = 'block'; // Muestra el sidebar
            } else {
                sidebar.style.display = 'none'; // Oculta el sidebar
            }
        }

        function hideMenu() {
            var sidebar = document.querySelector('.sidebar');
            sidebar.style.display = 'none'; // Oculta el sidebar
        }

        // Llama a la funci�n para ocultar el sidebar al cargar la p�gina
        window.onload = hideMenu;
    </script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.min.js"></script>
</body>
</html>