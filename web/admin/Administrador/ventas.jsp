<%@ page import="javax.swing.table.DefaultTableModel" %>
<%@ include file="template_administrador.jsp" %>


<div class="container">
    <div class="row">
        <!-- Columna izquierda con Formulario y bot�n centrado -->
        <div class="col-md-6 d-flex flex-column">
            <h3>Formulario Ventas</h3>
            <div class="text-center">
                <button type="button" name="btn_nuevo" id="btn_nuevo" class="btn btn-info center-button" data-toggle="modal" data-target="#modal_producto" onclick="limpiar()">Nuevo</button>
            </div>
        </div>

        <!-- Columna derecha con Buscar Producto e input centrado -->
        <div class="col-md-6 d-flex flex-column align-items-end">
            <h3>Buscar Venta</h3>
            <div class="d-flex align-items-center">
                <!-- Input de b�squeda -->
                <input type="text" id="buscar_id" name="buscar_venta" placeholder="Buscar por ID" class="form-control" style="width: 200px; margin-right: 10px;">
                
                <!-- Select para seleccionar entre Producto o Venta -->
                <select name="buscar_modal" id="buscar_modal" class="form-control" style="width: 150px; margin-right: 10px;" required>
                    <option value="">Seleccionar</option>
                    <option value="modal_buscarVenta">Venta</option>
                    <option value="modal_buscarCliente">Cliente</option>
                    <option value="modal_buscarEmpleado">Empleado</option>
                </select>
                
                <!-- Bot�n para buscar que abre el modal -->
                <button type="button" name="btn_buscar_producto" id="btn_buscar_producto" class="btn btn-primary">Buscar</button>
            </div>
        </div>
    </div>
</div>
<br>



<div class="container">
    <div class="modal fade" id="modal_producto" role="dialog">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-body">
                    <form action="sr_ventas" method="post" enctype="multipart/form-data" class="form-group">
                        <label for="lbl_id"><b>ID Venta</b></label>
                        <input type="text" name="txt_idVenta" id="txt_idVenta" class="form-control" value="0" readonly> 
                        
                        <label for="lbl_noFactura"><b>No. Factura</b></label>
                        <input type="text" name="txt_noFactura" id="txt_noFactura" class="form-control" placeholder="Ejemplo: 12312" required>
                        <br>

                        <label for="lbl_serie"><b>Serie</b></label>
                        <input type="text" name="txt_serie" id="txt_serie" class="form-control" placeholder="Ejemplo: E" maxlength="1" required>

                        <!-- Campo de fecha para el formulario -->
                        <label for="lbl_fecha_factura"><b>Fecha Factura</b></label>
                        <input type="date" name="txt_fecha_factura" id="txt_fecha_factura" class="form-control" required>
                        <!-- Campo de fecha en formato texto que ser� oculto -->
                        <input type="hidden" name="txt_fechafactura" id="txt_fechafactura" class="form-control" readonly>
                            
                        <label for="lbl_idCliente"><b>ID Cliente</b></label>
                        <input type="text" name="txt_idCliente" id="txt_idCliente" class="form-control" placeholder="ID del cliente" required>
                        
                        <label for="lbl_idEmpleado"><b>ID Empleado</b></label>
                        <input type="text" name="txt_idEmpleado" id="txt_idEmpleado" class="form-control" placeholder="ID del empleado" required>
                
                        <br>
                        <button name="btn_agregar" id="btn_agregar" value="agregar" class="btn btn-primary btn-lg">Agregar</button>
                        <button name="btn_modificar" id="btn_modificar" value="modificar" class="btn btn-success btn-lg">Modificar</button>
                        <button name="btn_eliminar" id="btn_eliminar" value="eliminar" class="btn btn-danger btn-lg" onclick="return confirm('�Desea eliminar esta venta?')">Eliminar</button>
                        <button type="button" class="btn btn-warning btn-lg" id="closeModal">Cerrar</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <table class="table table-striped">
        <thead>
            <tr>
                <th>ID</th>
                <th>No. Factura</th>
                <th>Serie</th>
                <th>Fecha Factura</th>
                <th>ID Cliente</th>
                <th>ID Empleado</th>
                <th>Fecha Ingreso</th>
            </tr>
        </thead>
        <tbody id="tbl_ventas">
            <% 
            Ventas venta = new Ventas();  
            DefaultTableModel tabla = venta.leerVentas(); 
            
            for (int t = 0; t < tabla.getRowCount(); t++) {
                out.println("<tr data-id='" + tabla.getValueAt(t, 0) + "'>");
                out.println("<td>" + tabla.getValueAt(t, 0) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 1) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 2) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 3) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 4) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 5) + "</td>");
                out.println("<td>" + tabla.getValueAt(t, 6) + "</td>");
                out.println("</tr>");
            }
            %>
        </tbody>
    </table>
</div>

        
        
  <div class="modal fade" id="modal_buscar_venta" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Venta</h5>
                <div class="form-group">
                    <input type="text" id="buscar" placeholder="Buscar ID venta" class="form-control">
                </div>      
                    <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>No. Factura</th>
                            <th>Serie</th>
                            <th>Fecha Factura</th>
                            <th>ID Cliente</th>
                            <th>ID Empleado</th>
                            <th>Fecha Ingreso</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_venta">
                        <% 
                        Ventas venta_1 = new Ventas();  
                        DefaultTableModel tabla_1 = venta_1.leerVentas(); 

                        for (int t = 0; t < tabla_1.getRowCount(); t++) {
                            out.println("<tr data-id='" + tabla_1.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tabla_1.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tabla_1.getValueAt(t, 6) + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                    <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>    
        
        


<!-- Modal para Buscar Empleado -->
<div class="modal fade" id="modal_buscar_empleado" role="dialog">
    <div class="modal-dialog modal-custom">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Empleado</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOMBRES</th>
                            <th>APELLIDOS</th>
                            <th>DIRECCI�N</th>
                            <th>TELEFONO</th>
                            <th>DPI</th>
                            <th>FECHA NACIMIENTO</th>
                            <th>PUESTO</th>
                            <th>FECHA INICIO LABORES</th>
                            <th>FECHA INGRESO</th>
                            <th>G�NERO</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_emp">
                        <% 
                        Empleados_adm emp = new Empleados_adm();  
                        DefaultTableModel tablaEmpleados_1 = emp.leerEmpleados(); 
                        
                        for (int t = 0; t < tablaEmpleados_1.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaEmpleados_1.getValueAt(t, 0) + "' data-id_puesto='" + tablaEmpleados_1.getValueAt(t, 7) + "'>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 7) + "</td>");  // Puesto
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 8) + "</td>");
                            out.println("<td>" + tablaEmpleados_1.getValueAt(t, 9) + "</td>");  // Fecha Ingreso
                            out.println("<td>" + (tablaEmpleados_1.getValueAt(t, 10).equals("0") ? "Masculino" : "Femenino") + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>


<!-- Modal para Buscar Cliente -->
<div class="modal fade" id="modal_buscar_cliente" role="dialog">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-body">
                <h5>Lista de Clientes</h5>
                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>NOMBRES</th>
                            <th>APELLIDOS</th>
                            <th>NIT</th>
                            <th>GENERO</th>
                            <th>TELEFONO</th>
                            <th>CORREO ELECTRONICO</th>
                            <th>FECHA INGRESO</th>
                        </tr>
                    </thead>
                    <tbody id="tbl_cliente">
                        <% 
                        Clientes_adm cliente = new Clientes_adm();  
                        DefaultTableModel tablaClientes = cliente.leerClientes(); 
                        
                        for (int t = 0; t < tablaClientes.getRowCount(); t++) {
                            out.println("<tr data-id='" + tablaClientes.getValueAt(t, 0) + "'>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 0) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 1) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 2) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 3) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 4) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 5) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 6) + "</td>");
                            out.println("<td>" + tablaClientes.getValueAt(t, 7) + "</td>");
                            out.println("</tr>");
                        }
                        %>
                    </tbody>
                </table>
                <button type="button" class="btn btn-secondary" id="closeModal">Cerrar</button>
            </div>
        </div>
    </div>
</div>

       
        
        
        
        
        
        
<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<script type="text/javascript">
    // Funci�n para limpiar el formulario antes de abrir el modal para nueva venta
    function limpiar() {
        $("#txt_idVenta").val(0);
        $("#txt_noFactura").val('');
        $("#txt_serie").val('');
        $("#txt_fecha_factura").val('');
        $("#txt_fechafactura").val(''); // Limpiar el campo de fecha oculto
        $("#txt_idCliente").val('');
        $("#txt_idEmpleado").val('');

        // Habilitar el campo de fecha
        $('#txt_fecha_factura').prop('disabled', false);
    }

    // Al hacer clic en una fila de la tabla
    $('#tbl_ventas').on('click', 'tr', function(evt) {
        var target = $(this);
        var idVenta = target.find("td").eq(0).text();
        var noFactura = target.find("td").eq(1).text();
        var serie = target.find("td").eq(2).text();
        var fechaFactura = target.find("td").eq(3).text(); // Capturar la fecha de la tabla en formato texto
        var idCliente = target.find("td").eq(4).text();
        var idEmpleado = target.find("td").eq(5).text();

        // Asignar los valores capturados al formulario
        $("#txt_idVenta").val(idVenta);
        $("#txt_noFactura").val(noFactura);
        $("#txt_serie").val(serie);

        // Asignar la fecha capturada al campo de texto y deshabilitarlo
        $("#txt_fecha_factura").val(fechaFactura);
        $("#txt_fechafactura").prop('readonly', true);

        // Deshabilitar el campo de fecha tipo date (si no quieres que se edite)
        $('#txt_fecha_factura').val(fechaFactura).prop('disabled', true);

        $("#txt_idCliente").val(idCliente);
        $("#txt_idEmpleado").val(idEmpleado);

        // Mostrar el modal
        $('#modal_producto').modal('show');
    });
    
    
    $("#buscar_venta").on("keyup", function() {
        var value = $(this).val().toLowerCase().trim(); // Remueve espacios en blanco
        $("#tbl_venta tr").filter(function() {
            var id = $(this).find("td").eq(0).text().toLowerCase();
            // Verifica si el valor de b�squeda est� presente en el ID o nombre
            $(this).toggle(id.includes(value));
        });
    });
    
    
        
        
        
    $(document).ready(function() {
        $("#btn_buscar_producto").click(function() {
            var modalSeleccionado = $("#buscar_modal").val();
            var value = $("#buscar_id").val().toLowerCase(); // Obtener el valor del campo de b�squeda

            // Verifica el valor seleccionado y abre el modal correspondiente
            if (modalSeleccionado === "modal_buscarVenta") {
                // Filtrar productos por el ID ingresado
                $("#tbl_venta tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase(); // ID del producto en la tabla
                    $(this).toggle(id === value); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de productos
                $('#modal_buscar_venta').modal('show');

            } else if (modalSeleccionado === "modal_buscarEmpleado") {
                // Filtrar ventas por el ID ingresado
                $("#tbl_emp tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase();  // ID de la venta en la tabla
                    $(this).toggle(id === value);  // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de ventas
                $('#modal_buscar_empleado').modal('show');
                
            } else if (modalSeleccionado === "modal_buscarCliente") {
                // Filtrar ventas por el ID ingresado
                $("#tbl_cliente tr").filter(function() {
                    var id = $(this).find("td").eq(0).text().toLowerCase();  // ID de la venta en la tabla
                    $(this).toggle(id === value); // Mostrar solo las filas que coincidan
                });
                // Mostrar el modal de ventas
                $('#modal_buscar_cliente').modal('show');
            } else {
                alert("Por favor, selecciona un tipo de b�squeda.");
            }
        });
    });
    document.getElementById('closeModal').addEventListener('click', function() {
            var modal = document.querySelector('.modal');
            var bootstrapModal = bootstrap.Modal.getInstance(modal); // obt�n la instancia del modal
            bootstrapModal.hide(); // oculta el modal
        });
    </script>
</script>

<%@ include file="pie_administrador.jsp" %>
