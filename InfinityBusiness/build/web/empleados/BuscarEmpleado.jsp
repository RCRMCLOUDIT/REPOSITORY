<%-- 
    Document   : BuscarEmpleado
    Created on : 09-27-2017, 11:34:45 AM
    Author     : moise
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%><!DOCTYPE html>
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
        <title>Resultados Busqueda</title>
    </head>
    <% //RECUPERO LA VARIABLE DE LA BUSQEDA DEL JSP DE LISTADO
        String nombre;
        nombre = request.getParameter("filtro");
    %>
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
                        <a href="ListarEmpleado.jsp" class="btn btn-primary">Volver Pagina Anterior</a>
                        <div class="panel-body" >
                            <table class="table" id="tblEmpleados">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">N° INSS</th>                      
                                        <th style="color: #FFFFFF; text-align: center;">Empleado</th>
                                        <th style="color: #FFFFFF; text-align: center;">Telefono</th>
                                        <th style="color: #FFFFFF; text-align: center;">Direccion</th>
                                        <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% // declarando y creando objetos globales 
                                        //Integer cod = DaoLogin.IdUsuario;
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {

                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement("SELECT `IdEmpleado`, `NoInss`, CONCAT(Nombre,' ',Apellido) AS Empleado, `Telefono`, `Direccion` FROM `empleado` WHERE CONCAT(Nombre,' ',Apellido) LIKE '" + nombre + "%'");
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='IdEmp' name='form-id' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='NoInss' name='form-NoInss' readonly value='" + rs.getString(2) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 300px' id='Empleado' name='form-Empleado' readonly value='" + rs.getString(3) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Telefono' name='form-Telefono' readonly value='" + rs.getString(4) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Direccion' name='form-Direccion' readonly value='" + rs.getString(5) + "'>"
                                                        + "</TD>");

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
    </body>
</html>
