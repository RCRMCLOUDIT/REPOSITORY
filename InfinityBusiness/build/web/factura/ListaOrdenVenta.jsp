<%-- 
    Document   : ListaOrdenVenta
    Created on : 05-08-2018, 11:35:34 AM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
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
        <title>Ordenes De Venta</title>
    </head>
    <% //RECUPERO LAS VARIABLE PARA LA BUSQUEDA
        String nombre;
        nombre = request.getParameter("filtro");
    %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Ordenes de Venta</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaEmpleados">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <a href="../factura/BuscarOrdenVenta.jsp?idCli=null" class="btn btn-primary">Volver Pagina Anterior</a>
                        <div class="panel-body" >
                            <table class="table" id="tblOrdenesVenta">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">Factura #</th>
                                        <th style="color: #FFFFFF; text-align: center;">Fecha Orden</th>
                                        <th style="color: #FFFFFF; text-align: center;">Cliente</th>
                                        <th style="color: #FFFFFF; text-align: center;">Total Orden</th>
                                        <th style="color: #FFFFFF; text-align: center;">Vendedor</th>
                                        <th style="color: #FFFFFF; text-align: center;">Estado</th>
                                        <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% // declarando y creando objetos globales construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement("");
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<TR>");
                                                out.println("<TD>" + rs.getInt(1) + "</TD>");
                                                out.println("<TD>"
                                                        + "<a href='#?idOrden=" + rs.getInt(1) + "' class='btn btn-primary'>Revisar Detalle</a>"
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