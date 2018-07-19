<%-- 
    Document   : ListaEmpelado
    Created on : 10-11-2016, 09:34:14 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String consulta;
    consulta = "SELECT `IdEmpleado`, NumEmpleado, CONCAT(Nombre,' ',Apellido) AS Empleado, Cedula, `NoInss` FROM `empleado` ORDER BY `Empleado` ASC";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="../assets/css/bootstrap.css"> 
        <link rel="stylesheet" href="../assets/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="../assets/css/responsive.bootstrap.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <%-- <link rel="stylesheet" href="assets/css/estilos.css"> --%>
        <link rel="stylesheet" href="../assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="../assets/chosen/chosen.min.css">
        <script src="../assets/js/lib/jquery.js"></script>
        <script src="../assets/js/lib/jquery.dataTables.js"></script>
        <script src="../assets/js/lib/dataTables.bootstrap.min.js"></script>
        <script src="../assets/js/lib/dataTables.responsive.min.js"></script>
        <script src="../assets/js/lib/responsive.bootstrap.min.js"></script>
        <script src="../assets/js/lib/jquery-ui.min.js"></script>
        <script src="../assets/chosen/chosen.jquery.min.js"></script>  
        <script src="../assets/js/chosen.js"></script>  
        <script src="../assets/js/lib/bootstrap.js"></script>  
        <script src="../assets/js/lib/menu.js"></script>  
        <script src="../assets/js/calendario.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var NumEmpleado = $('#form-AddNumEmpleado').val();
                    var Nombre = $('#form-AddNombre').val();
                    var Apellido = $('#form-AddApellido').val();
                    var Cedula = $('#form-AddCedula').val();
                    var NoInss = $('#form-AddNoInss').val();
                    var FechaNac = $('#FechaNac').val();
                    var Genero = $('#form-AddGenero').val();
                    var Direccion = $('#form-AddDireccion').val();
                    var Telefono = $('#form-AddTelefono').val();
                    var Celular = $('#form-AddCelular').val();
                    var Correo = $('#form-AddCorreo').val();
                    var FechaIngreso = $('#FechaIngreso').val();

                    if ($('#form-AddNumEmpleado').val() == "") {
                        alert("Revisar Numero Empleado, Campo Vacio");
                        $('#form-AddNumEmpleado').focus();
                    } else if ($('#form-AddNombre').val() == "") {
                        alert("Revisar Nombre Empleado, Campo Vacio");
                        $('#form-AddNombre').focus();
                    } else if ($('#form-AddCedula').val() == "") {
                        alert("Revisar Cedula Empleado, Campo Vacio");
                        $('#form-AddCedula').focus();
                    } else if ($('#FechaNac').val() == "") {
                        alert("Revisar Fecha Nacimiento Empleado, Campo Vacio");
                        $('#FechaNac').focus();
                    } else if ($('#FechaIngreso').val() == "") {
                        alert("Revisar Fecha Ingreso Empleado, Campo Vacio");
                        $('#FechaIngreso').focus();
                    } else if ($('#form-AddDireccion').val() == "") {
                        alert("Revisar Direccion Empleado, Campo Vacio");
                        $('#form-AddDireccion').focus();
                    } else if ($('#form-AddTelefono').val() == "") {
                        alert("Revisar Telefono Empleado, Campo Vacio");
                        $('#form-AddTelefono').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {NumEmpleado: NumEmpleado, Nombre: Nombre, Apellido: Apellido, Cedula: Cedula, NoInss: NoInss,
                                FechaNac: FechaNac, Genero: Genero, Direccion: Direccion,
                                Telefono: Telefono, Celular: Celular, Correo: Correo, FechaIngreso: FechaIngreso},
                            url: '../ServletEmpleado',
                            success: function (response) {
                                //utilzar response
                                $('#Agregar').modal('hide');
                                location.reload(true);
                            }
                        });
                    }
                });
            });
        </script>
        <title>Empleados</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Empleados</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaEmpleados">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <form id="FormBuscar" role="form" action="BuscarEmpleado.jsp">
                            <div class="input-group">
                                <span class="input-group-addon">Nombre:</span>
                                <input id="filtro" name="filtro" type="text" value='' class="form-control" placeholder="Ingresa Nombre a  Buscar..." required="true">
                                <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                                <a href="AgregarEmpleado.jsp" class='btn btn-primary'>Agregar Nuevo Empleado</a>
                                <%-- <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button> --%>
                            </div>
                        </form>
                        <div class="panel-body">
                            <table class="table table-hover" id="tblEmpleados">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">#Empleado</th>
                                        <th style="color: #FFFFFF; text-align: center;">Empleado</th>
                                        <th style="color: #FFFFFF; text-align: center;">Cedula</th>
                                        <th style="color: #FFFFFF; text-align: center;">N° INSS</th>                                        
                                        <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                    </tr>
                                </thead>
                                <%-- AQUI CAMBIAR EL COLOR PARA EL FONDO DE LA TABLA--%>
                                <tbody style="background-color: #C7C6C6;">
                                    <% // declarando y creando objetos globales 
                                        //Integer cod = DaoLogin.IdUsuario;
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR style='text-align: center;'>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(5) + "</TD>");
                                                out.println("<TD>"
                                                        + "<a href='ModificarEmpleado.jsp?idEmp=" + rs.getInt(1) + "' class='btn btn-primary'>Editar ó Ver</a>"
                                                        + "</TD>");
                                                out.println("</TR>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </tbody>
                            </table>                            
                        </div>                        
                    </div>
                </div>
            </div>
        </section>
        
    <center> <%--VENTANA MODAL PARA AGREGAR UN NUEVO EMPLEADO --%>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4682B4">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <center>
                            <h3 style="color: #FFFFFF; text-align: center;">Agregar Empleado</h3>                
                        </center>                        
                    </div>
                    <div class="modal-body">
                        <form id="FormAddEmpleado" role="form" action="ServletEmpleadoAdd" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="NumEmpleado">Numero Empleado <Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="form-AddNumEmpleado" name="form-AddNumEmpleado" placeholder="Numero Empleado..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="Nombre">Nombre<Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="form-AddNombre" name="form-AddNombre" placeholder="Nombre..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="Apellido">Apellido</label>
                                <input type="text" class="form-control" id="form-AddApellido" name="form-AddApellido" placeholder="Apellido...">   
                            </div>
                            <div class="form-control">
                                <label for="Cedula">Cedula <Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="form-AddCedula" name="form-AddCedula" placeholder="Cedula..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="NoInss">N° INSS</label>
                                <input type="text" class="form-control" id="form-AddNoInss" name="form-AddNoInss" placeholder="N° INSS...">   
                            </div>                            
                            <div class="form-control">
                                <label for="FechaNac">Fecha Nacimiento<Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="FechaNac" name="FechaNac">
                            </div>                              
                            <div class="form-control">
                                <label for="FechaIngreso">Fecha Ingreso<Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="FechaIngreso" name="FechaIngreso">
                            </div>                            
                            <div class="form-control">
                                <label for="Genero">Genero<Span style="color: red; ">*</span></label>
                                <select class="form-control" id="form-AddGenero" name="form-AddGenero">
                                    <option>Masculino</option>                                    
                                    <option>Femenino</option>
                                </select>
                            </div>  
                            <div class="form-control">
                                <label for="Direccion">Direccion<Span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="form-AddDireccion" name="form-AddDireccion" placeholder="Direccion..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="Telefono">Telefono<Span style="color: red; ">*</span></label>
                                <input type="number" class="form-control" id="form-AddTelefono" name="form-AddTelefono" placeholder="Telefono..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="Celular">Celular</label>
                                <input type="number" class="form-control" id="form-AddCelular" name="form-AddCelular" placeholder="Celular...">   
                            </div>                      
                            <div class="form-control">
                                <label for="Correo">Correo</label>
                                <input type="text" class="form-control" id="form-AddCorreo" name="form-AddCorreo" placeholder="Correo...">
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnAgregar" >Agregar</button>
                    </div>
                </div>
            </div>
        </div>
    </center> <%--FIN VENTANA MODAL PARA AGREGAR UN NUEVO EMPLEADO --%>
    
    <script type="text/javascript">
        $('#FechaNac').datepicker({
            //dateFormat: "dd/mm/yy",
            dateFormat: "yy-mm-dd",
            language: "es",
            changeYear: true,
            changeMonth: true,
            yearRange: "1900:2003",
            autoclose: true
        });
    </script>
    <script type="text/javascript">
        $('#FechaIngreso').datepicker({
            //dateFormat: "dd/mm/yy",
            dateFormat: "yy-mm-dd",
            language: "es",
            changeYear: true,
            changeMonth: true,
            yearRange: "1900:2018",
            autoclose: true
        });
    </script>
</body>
</html>