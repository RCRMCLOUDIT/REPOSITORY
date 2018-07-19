<%-- 
    Document   : ListaProveedor
    Created on : 05-21-2018, 03:34:19 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String NombreProveedor = request.getParameter("form-Nombre");
    String CodRuc = request.getParameter("form-CodigoRuc");
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
        <title>Lista de Proveedores</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Resultados de la Busqueda</h1>
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaProveedor">
                <table class="table table-hover" id="tblProveedores">
                    <thead style="background-color: #4682B4">
                        <tr>
                            <th style="color: #FFFFFF; text-align: center;">Id</th>
                            <th style="color: #FFFFFF; text-align: center;">Codigo RUC</th>                      
                            <th style="color: #FFFFFF; text-align: center;">Nombre</th>
                            <th style="color: #FFFFFF; text-align: center;">Activo?</th>
                            <th style="color: #FFFFFF; text-align: center;"></th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                ConexionDB conn = new ConexionDB();
                                conn.Conectar();
                                ResultSet rs = null;
                                PreparedStatement pst = null;
                                pst = conn.conexion.prepareStatement("SELECT IdProveedor, Ruc, Nombre, Activo FROM Proveedor WHERE Nombre LIKE'" + NombreProveedor + "%' OR Ruc LIKE '" + CodRuc + "'");
                                rs = pst.executeQuery();
                                while (rs.next()) {
                                    out.println("<TR style='text-align: center;'>");
                                    out.println("<TD>" + rs.getInt(1) + "</TD>");
                                    out.println("<TD>" + rs.getString(2) + "</TD>");
                                    out.println("<TD>" + rs.getString(3) + "</TD>");
                                    out.println("<TD>" + rs.getString(4) + "</TD>");
                                    out.println("<TD>"
                                            + "<a href='ActulizarProveedor.jsp?idProv=" + rs.getInt(1) + "' class='btn btn-primary'>Editar ó Ver</a>"
                                            + "</TD>");
                                    out.println("</TR>");
                                }; // fin while 
                            } //fin try no usar ; al final de dos o mas catchs 
                            catch (SQLException e) {
                            };
                        %>
                    </tbody>
                </table>
                <button type='button' onclick='location.href = "BuscaProveedor.jsp"' class='btn btn-primary'>Volver</button>
                <button type='button' onclick='location.href = "AgregaProveedor.jsp"' class='btn btn-primary'>Agregar Nuevo Proveedor</button>
            </div>
        </section>
    </body>
</html>
