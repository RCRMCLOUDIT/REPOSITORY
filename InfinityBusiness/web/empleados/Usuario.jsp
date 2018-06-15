<%-- 
    Document   : Usuario
    Created on : 07-31-2017, 07:56:50 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="model.DaoUsuario"%>
<%@page import="controller.ServletUsuario"%>
<%@page import="controller.ServletUsuarioAdd"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
                    var IdEmpleado = $('#form-Empleado').val();
                    var Nombre = $('#form-AddUsuario').val();
                    var Clave = $('#form-AddClave').val();
                    $.ajax({
                        type: 'POST',
                        data: {IdEmpleado: IdEmpleado, Nombre: Nombre, Clave: Clave},
                        url: '../ServletUsuarioAdd',
                        success: function (response) {
                            //utilzar response
                            $('#Agregar').modal('hide');
                            location.reload(true);
                        }
                    });
                });
            });
        </script>        

        <title>Lista de Usuarios</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Usuarios </h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaUsuarios">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <form id="FormBuscar" role="form" action="">
                            <div class="input-group">
                                <span class="input-group-addon">Nombre:</span>
                                <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                                <input id="QuienLlama" name="QuienLlama" type="text" value='ListadoCliente' class="form-control col-sm-2" hidden="true">
                                <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                                <%--  <a class='btn btn-primary' href='AddCliente.jsp'>Agregar Nuevo Cliente</a> --%>
                                <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar Nuevo Usuario</button>
                            </div>
                        </form>
                        <div class="panel-body" >
                            <table class="table table-hover" id="tblUsuario">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">Empleado</th>
                                        <th style="color: #FFFFFF; text-align: center;">Nombre Usuario</th>
                                        <th style="color: #FFFFFF; text-align: center;">Activo</th>
                                        <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody style="background-color: #C7C6C6;">
                                    <% // declarando y creando objetos globales 
                                        //Integer cod = DaoLogin.IdUsuario;
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT usuario.IdUsuario, CONCAT(empleado.Nombre,' ',empleado.Apellido) AS Empleado, usuario.Usuario, usuario.Password, usuario.Activo FROM `usuario` INNER JOIN empleado on usuario.IdEmpleado=empleado.IdEmpleado ORDER BY usuario.IdUsuario ASC";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {
                                                out.println("<TR style='text-align: center;'>");
                                                out.println("<TD style='color: #000000;'>" + rs.getInt(1) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(5) + "</TD>");
                                                out.println("<TD>"
                                                        + "<a href='EditarUsuario.jsp?idUser=" + rs.getInt(1) + "&Name=" + rs.getString(2) + "&User=" + rs.getString(3) + "' class='btn btn-primary'>Editar ó Ver</a>"
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
        <%--VENTANA MODAL PARA AGREGAR UNA NUEVO USUARIO --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar Nuevo Usuario</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormMarca" role="form" action="ServletUsuarioAdd" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Empleado">Selecciona Empleado:<span style="color: red; ">*</span></label>
                                <select class="form-control" id="form-Empleado" name="form-Empleado">
                                    <option value="0">Selecciona un Empleado........</option>
                                    <% // declarando y creando objetos globales 
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT empleado.IdEmpleado, CONCAT(empleado.Nombre,' ',empleado.Apellido) AS Empleado FROM `empleado` INNER JOIN usuario ON empleado.IdEmpleado<>usuario.IdEmpleado WHERE empleado.Activo='SI'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>  
                            <div class="form-control">
                                <label for="AddUsuario">Usuario<span style="color: red; ">*</span></label>
                                <input type="text" class="form-control" id="form-AddUsuario" name="form-AddUsuario" placeholder="Nombre..." autocomplete="off">   
                            </div>
                            <div class="form-control">
                                <label for="AddClave">Contraseña<span style="color: red; ">*</span></label>
                                <input type="password" class="form-control" id="form-AddClave" name="form-AddClave" placeholder="Contraseña..." autocomplete="off">   
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
    </center> 
</body>
</html>
