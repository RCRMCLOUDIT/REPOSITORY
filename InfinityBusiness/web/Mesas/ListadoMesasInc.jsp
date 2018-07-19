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
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Lista de Mesas Inactivas</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaMesasInactivas">
                <div  class="col-sm-8">
                    <div class="panel-default">
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
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">Nombre</th>
                                        <th style="color: #FFFFFF; text-align: center;">Estado</th>
                                        <th style="color: #FFFFFF; text-align: center;"></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
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
                                                    out.println("<TR class='bg-success' style='text-align: center;'>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getInt(1) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(2) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(3) + "</TD>");
                                                    out.println("<TD>"
                                                            + "<a class='btn btn-primary' href='UpdateMesa.jsp?idMesa=" + rs.getInt(1) + "'>Editar</a>"
                                                            + "</TD>");
                                                    out.println("</TR>");
                                                }

                                                if (rs.getString(3).equals("Ocupado")) {
                                                    out.println("<TR class='bg-danger' style='text-align: center;'>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getInt(1) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(2) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(3) + "</TD>");
                                                    out.println("<TD>"
                                                            + "<a class='btn btn-primary' href='UpdateMesa.jsp?idMesa=" + rs.getInt(1) + "'>Editar</a>"
                                                            + "</TD>");
                                                    out.println("</TR>");
                                                }

                                                if (rs.getString(3).equals("Reservado")) {
                                                    out.println("<TR class='bg-warning' style='text-align: center;'>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getInt(1) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(2) + "</TD>");
                                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(3) + "</TD>");
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
