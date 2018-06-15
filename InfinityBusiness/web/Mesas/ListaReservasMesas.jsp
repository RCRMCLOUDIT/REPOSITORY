<%-- 
    Document   : ListadoReserva
    Created on : 04-16-2018, 01:26:00 PM
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
        <title>Listado de Reservas</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Mesas Reservadas</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaReservas">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div id="BuscarCliente">
                            <form id="FormBuscarCliente" role="form" action="BuscarReserva.jsp">
                                <div class="input-group">
                                    <span class="input-group-addon">Nombre Cliente:</span>
                                    <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                                    <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                                    <a href="../reserva/ReservaMesa.jsp" class="btn btn-primary">Nueva Reserva</a>
                                </div>
                            </form>
                        </div>
                        <div class="panel-body" >
                            <table class="table table-hover" id="tblReservas">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Reserva #</th>
                                        <th style="color: #FFFFFF; text-align: center;">Nombre</th>                      
                                        <th style="color: #FFFFFF; text-align: center;">Personas #</th>
                                        <th style="color: #FFFFFF; text-align: center;">Fecha</th>
                                        <th style="color: #FFFFFF; text-align: center;">Hora</th>
                                        <th style="color: #FFFFFF; text-align: center;">Accion</th>
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
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement("SELECT IdReserva, NombreCliente, Personas, FechaReservada, HoraReservada  FROM `reservarestaurante` ORDER BY FechaReservada ASC");
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR style='text-align: center;'>");
                                                out.println("<TD style='color: #000000;'>" + rs.getInt(1) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getInt(3) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getTime(5) + "</TD>");
                                                out.println("<TD>"
                                                        + "<a href='?idReser=" + rs.getInt(1) + " ' class='btn btn-primary'>Ver Reserva</a>"
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