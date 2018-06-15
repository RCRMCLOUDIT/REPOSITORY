<%-- 
    Document   : BuscarReserva
    Created on : 12-13-2017, 09:46:07 AM
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
        <title>Busqueda de Reserva</title>
    </head>
    <% //RECUPERO LA VARIABLE DE LA BUSQEDA DEL JSP DE LISTADO
        String nombre;
        nombre = request.getParameter("filtro");
        String idHab = request.getParameter("idHab");
        String idCli = request.getParameter("idCli");
    %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaEmpleados">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Resultados de la Busqueda</h3>
                        </div>
                        <a href="checkIn.jsp?idHab=<%=idHab%>&idCli=<%=idCli%>" class="btn btn-primary">Volver</a>
                        <div class="panel-body" >
                            <table class="table" id="tblClientes">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">Nombre</th>                      
                                        <th style="color: #FFFFFF; text-align: center;">Adultos</th>
                                        <th style="color: #FFFFFF; text-align: center;">Niños</th>
                                        <th style="color: #FFFFFF; text-align: center;">Llegada</th>
                                        <th style="color: #FFFFFF; text-align: center;">Salida</th>
                                        <th style="color: #FFFFFF; text-align: center;">Accion</th>
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
                                            pst = conn.conexion.prepareStatement("SELECT IdReservHab, NombreCliente, Adultos, Niños, FechaIN, FechaOUT  FROM `reservahabitacion` WHERE NombreCliente LIKE '" + nombre + "%'");
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='IdReser' name='form-id' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='form-Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 50px' id='form-Adulto' name='form-Adulto' readonly value='" + rs.getInt(3) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 50px' id='form-Ninos' name='form-Ninos' readonly value='" + rs.getInt(4) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='form-Llegada' name='form-Llegada' readonly value='" + rs.getString(5) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='form-Salida' name='form-Salida' readonly value='" + rs.getString(6) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<a href='checkIn.jsp?idReser=" + rs.getInt(1) + "&idHab=" + idHab + "&idCli=" + idCli + " ' class='btn btn-primary'>Seleccionar</a>"
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
