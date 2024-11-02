<%@ page import="java.sql.*" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@page import="javax.swing.table.DefaultTableModel" %>
<%@page import="modelo.productos" %>
<%@page import="java.sql.Connection" %>
<%@page import="java.sql.DriverManager" %>
<%@page import="java.sql.PreparedStatement" %>
<%@page import="java.sql.ResultSet" %>
<%@page import="java.sql.SQLException" %>
<%@ page import="modelo.Cuenta" %>
<%@page import="modelo.Ventas" %>
<%@page import="modelo.Clientes_adm" %>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="modelo.Empleados_adm" %>

<%
    // Recuperar el usuario de la sesi�n
    Cuenta usuario1 = (Cuenta) session.getAttribute("usuario");
    
%>

 <%
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        if (username != null && password != null) {
            Connection conn = null;
            PreparedStatement stmt = null;
            ResultSet rs = null;

            try {
                Class.forName("com.mysql.jdbc.Driver");
                conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/newdb", "root", "danigero");

                String sql = "SELECT id, password, attempts, lock_time, mec, idCliente FROM users WHERE username = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setString(1, username);
                rs = stmt.executeQuery();

                if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    int attempts = rs.getInt("attempts");
                    Timestamp lockTime = rs.getTimestamp("lock_time");
                    String role = rs.getString("mec");
                    int idCliente = rs.getInt("idCliente");

                    long currentTimeMillis = System.currentTimeMillis();
                    boolean locked = false;

                    if (lockTime != null && (currentTimeMillis - lockTime.getTime()) < 300000) {
                        out.println("<p style='color:red;'>Tienes varios intentos fallidos. Por favor espera 5 minutos.</p>");
                        locked = true;
                    }

                    if (!locked) {
                        if (password.equals(dbPassword)) {
                            // Crear objeto Cuenta y almacenar en la sesi�n
                            Cuenta usuario = new Cuenta(rs.getInt("id"), username, dbPassword);
                            session.setAttribute("usuario", usuario);  // Guardar el objeto Cuenta en la sesi�n

                            
                            response.sendRedirect("index.jsp");   
                            

                            // Resetear intentos
                            String resetAttemptsSql = "UPDATE users SET attempts = 0, lock_time = NULL WHERE username = ?";
                            PreparedStatement resetStmt = conn.prepareStatement(resetAttemptsSql);
                            resetStmt.setString(1, username);
                            resetStmt.executeUpdate();
                            resetStmt.close();
                            } else {
                                attempts++;
                                if (attempts >= 3) {
                                    String lockSql = "UPDATE users SET lock_time = NOW() WHERE username = ?";
                                    PreparedStatement lockStmt = conn.prepareStatement(lockSql);
                                    lockStmt.setString(1, username);
                                    lockStmt.executeUpdate();
                                    lockStmt.close();
                                    out.println("<p style='color:red;'>Demasiados intentos fallidos. Cuenta bloqueada por 5 minutos.</p>");
                                } else {
                                    String updateAttemptsSql = "UPDATE users SET attempts = ? WHERE username = ?";
                                    PreparedStatement updateStmt = conn.prepareStatement(updateAttemptsSql);
                                    updateStmt.setInt(1, attempts);
                                    updateStmt.setString(2, username);
                                    updateStmt.executeUpdate();
                                    updateStmt.close();
                                    out.println("<p style='color:red;'>Credenciales inv�lidas. Intento " + attempts + " de 3.</p>");
                                }
                            }
                        }
            } else {
                out.println("<p style='color:red;'>Usuario no existe.</p>");
            }
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p style='color:red;'>Error conectando a la base de datos.</p>");
            } finally {
                try { if (rs != null) rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (stmt != null) stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                try { if (conn != null) conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        }
    %>

<!DOCTYPE html>
<html>
<head>
    <title>Menu</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <style>
        body {
            background-image: url('img/7.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            height: 100%;
            font-family: Arial, sans-serif;
            background-color: #f0f0f0;
            padding: 20px;
            margin: 0;
        }


        .navbar {
            padding: 10px 10px;
        }

        .navbar-brand img {
            width: 200px;
            height: auto;
        }

        .nav-link {
            font-size: 1.8rem;
            padding: 10px 15px;
        }

        .form-control {
            height: 50px;
        }

        .card-container {
            display: flex;
            flex-wrap: wrap; /* Permite que las tarjetas se envuelvan en m�ltiples l�neas */
            gap: 30px; /* Espacio entre las tarjetas */
            justify-content: center; /* Centra las tarjetas horizontalmente */
            align-items: center; /* Centra las tarjetas verticalmente (opcional) */
            padding: 20px; /* Espacio alrededor del contenedor */
        }

        .card {
            background-color: rgba(211, 211, 240, 0.8); /* Gris claro */
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            padding: 20px;
            width: 300px; /* Ancho fijo para las tarjetas */
            display: flex;
            flex-direction: column;
            justify-content: space-between; /* Distribuir el contenido */
        }

        .card img {
            width: 100%;
            height: 200px; /* Altura fija */
            object-fit: cover; /* Ajuste de imagen */
            border-radius: 8px; /* Bordes redondeados */
        }

        .button-group {
            display: flex; /* Usar flexbox para los botones */
            flex-direction: column; /* Apilar botones verticalmente */
            margin-top: 10px; /* Espacio entre el contenido y los botones */
        }

        .button-group .btn {
            width: 100%; /* Los botones ocupan todo el ancho */
            margin: 5px 0; /* Espacio entre botones */
        }
        
        .welcome-text {
            color: white; /* Cambia el color del texto (en este caso, un azul) */
            font-size: 1.7rem; /* Cambia el tama�o de la fuente (puedes usar px, em, rem, etc.) */
            font-weight: bold; /* Cambia el grosor del texto (opcional) */
            margin: 0 15px;
        }
        
        .btn-long {
            display: inline-block;
            font-size: 1.5rem; /* Tama�o de texto grande */
            padding: 10px 30px; /* Espacio interno del bot�n */
            width: 100%; /* Hacer que el bot�n ocupe todo el ancho posible */
            max-width: 300px; /* Limitar el ancho m�ximo */
            text-align: center;
            background-color: #14f4f1; /* Color de fondo verde */
            color: black; /* Texto blanco */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            transition: background-color 0.3s ease; /* Efecto suave al cambiar el color */
        }

        .btn-long:hover {
            background-color: #40b6b4; /* Cambiar el color al pasar el mouse */
        }

        .btn-long:active {
            background-color: #91e0df; /* Cambiar el color al hacer clic */
        }

        .btn-long:focus {
            outline: none; /* Remover contorno de enfoque */
            box-shadow: 0 0 5px rgba(40, 167, 69, 0.5); /* Sombra al hacer foco */
        }
        
    </style>
</head>
<body>
    <header>
           <nav class="navbar navbar-expand-lg navbar-night bg-night">
        <div class="container-fluid">
            <a class="navbar-brand" href="login.jsp">
                <img src="img/as.png">
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button> 
            <div class="collapse navbar-collapse" id="navbarSupportedContent">
                <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="index.jsp">Inicio</a>
                    </li>
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">Cat�logo</a>
                        <ul class="dropdown-menu" aria-labelledby="navbarDropdown">
                           
                        </ul>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#.jsp"><img src="img/10.png">Compras</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="contactanos.jsp">Contactanos</a>
                    </li>
                </ul>
                <form class="d-flex" action="buscarProductos.jsp" >
                    
                    <!-- Bot�n para Iniciar Sesi�n -->
                    <button type="button" class="btn btn-outline-success btn-long" data-bs-toggle="modal" data-bs-target="#loginModal" 
                            <%= (usuario1 != null) ? "style='display:none;'" : "" %>>
                        Iniciar Sesi�n
                    </button>

                    <!-- Mostrar el nombre del usuario si est� logueado y agregar un enlace para cerrar sesi�n -->
                    <% if (usuario1 != null) { %>
                        <span class="welcome-text">
                            <a href="CerrarSesion.jsp" style="color:inherit; text-decoration:none;"><%= usuario1.getUsername() %></a>
                        </span>
                    <% } %>
                    
                    <input class="form-control me-2" type="search" name="nombreProducto" placeholder="Buscar por nombre" aria-label="Search">
                    <button class="btn btn-outline-success" type="submit">BUSCAR</button>
                </form>
            </div>
        </div>
    </nav>

    <br>
    <!-- Modal de Iniciar Sesi�n -->
    <div class="modal fade" id="loginModal" tabindex="-1" aria-labelledby="loginModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Iniciar Sesi�n</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <!-- Removemos el action del formulario -->
                    <form id="loginForm" method="post">
                        <div class="mb-3">
                            <label for="username" class="form-label">Usuario</label>
                            <input type="text" class="form-control" id="username" name="username" required>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Contrase�a</label>
                            <input type="password" class="form-control" id="password" name="password" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Iniciar Sesi�n</button>
                    </form>

                    <p class="mt-3">�No tienes una cuenta? <a href="#" >Reg�strate aqu�</a></p>
                </div>
            </div>
        </div>
    </div>
    </header>