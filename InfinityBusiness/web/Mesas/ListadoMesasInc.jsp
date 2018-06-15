<%-- 
    Document   : ListadoMesasInc
    Created on : 11-08-2017, 03:10:27 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
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
        <title>Mesas Inactivas</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaTipoCuentas">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <Center>
                                <h3 class="panel-title">Listado de Mesas Inactivas</h3>
                            </center>
                        </div>
                        <div class="dropdown">
                            <button class="btn btn-primary dropdown-toggle" type="button" data-toggle="dropdown">Mostrar...
                                <span class="caret"></span></button>
                            <ul class="dropdown-menu">
                                <li><a href="ListadoMesas.jsp">Todos</a></li>
                                <li><a href="ListadoMesasAct.jsp">Activos</a></li>
                                <li><a href="ListadoMesasInc.jsp">Inactivos</a></li>
                            </ul>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        </div>
                        <div class="panel-body" >
                            <table class="table" id="tblMesas">
                                <thead>
                                    <tr class="bg-info">
                                        <th style="text-align: center;">Id</th>
                                        <th style="text-align: center;">Nombre</th>                      
                                        <th style="text-align: center;">Estado</th>
                                        <th style="text-align: center;">Acciones</th>
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
                                            String consulta = "SELECT * FROM `mesa` WHERE Activo='No'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {
                                                if (rs.getString(3).equals("Libre")) {
                                                    out.println("<TR class='bg-success''>");

                                                    out.println("<TD style='display:none;'>"
                                                            + "<div class='myform-bottom'>"
                                                            + "<form id='FormMarca' role='form' action='../ServletMesas'"
                                                            + "method='POST' class='form-control'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: 60px' id='idMesa' name='form-idMesa' readonly value='" + rs.getInt(1) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Estado' name='form-Estado' readonly value='" + rs.getString(3) + "'>"
                                                            + "</div>"
                                                            + "</form>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<a class='btn btn-primary' href='UpdateMesa.jsp?idMesa=" + rs.getInt(1) + "'>Editar</a>"
                                                            + "</TD>");

                                                    out.println("</TR>");
                                                }

                                                if (rs.getString(3).equals("Ocupado")) {
                                                    out.println("<TR class='bg-danger''>");

                                                    out.println("<TD style='display:none;'>"
                                                            + "<div class='myform-bottom'>"
                                                            + "<form id='FormMarca' role='form' action='../ServletMesas'"
                                                            + "method='POST' class='form-control'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: 60px' id='idMesa' name='form-idMesa' readonly value='" + rs.getInt(1) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Estado' name='form-Estado' readonly value='" + rs.getString(3) + "'>"
                                                            + "</div>"
                                                            + "</form>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<a class='btn btn-primary' href='UpdateMesa.jsp?idMesa=" + rs.getInt(1) + "'>Editar</a>"
                                                            + "</TD>");

                                                    out.println("</TR>");
                                                }

                                                if (rs.getString(3).equals("Reservado")) {
                                                    out.println("<TR class='bg-warning''>");

                                                    out.println("<TD style='display:none;'>"
                                                            + "<div class='myform-bottom'>"
                                                            + "<form id='FormMarca' role='form' action='../ServletMesas'"
                                                            + "method='POST' class='form-control'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: 60px' id='idMesa' name='form-idMesa' readonly value='" + rs.getInt(1) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                            + "</div>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<div>"
                                                            + "<input type='text' class='form-control' style='width: auto' id='Estado' name='form-Estado' readonly value='" + rs.getString(3) + "'>"
                                                            + "</div>"
                                                            + "</form>"
                                                            + "</TD>");

                                                    out.println("<TD>"
                                                            + "<a class='btn btn-primary' href='UpdateMesa.jsp?idMesa=" + rs.getInt(1) + "'>Editar</a>"
                                                            + "</TD>");

                                                    out.println("</TR>");
                                                }

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
        </div>
    </section>
</body>
</html>
