<% 
    // Invalida la sesi�n actual
    session.invalidate();
    
    // Redirige al usuario a la p�gina de inicio o a la p�gina que prefieras
    response.sendRedirect("index.jsp");
%>