<%-- 
    Document   : checkIn
    Created on : 09-12-2017, 10:13:23 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoHabitacion"%>
<%@page import="java.sql.Date"%>
<%@page import="model.DaoReservas"%>
<%@page import="model.DaoCliente"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String idHab = request.getParameter("idHab");
    String idCli = request.getParameter("idCli");
    String idReser = request.getParameter("idReser");
%>
<html lang="es">
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
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Check IN</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body style="background-color: #4682B4;">
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Realizando Check IN</h1>                
            </center>
        </div>
        <div id="grupoTablas">
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Cliente</a></li>
                <li><a href="#tab-2">Datos Reserva</a></li>
                <li><a href="#tab-3">Datos Habitacion</a></li>
            </ul>
            <%-- DIV PARA EL CONTROL DE DATOS DEL CLIENTE --%>
            <div id="tab-1">
                <%-- FORMULARIO PARA MANDAR A BUSCAR LOS DATOS DEL CLIENTE --%>
                <form id="FormBuscarCliente" role="form" action="BuscarCliente.jsp">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Cliente: </strong></span>
                        <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                        <input id="idHab" name="idHab" value="<%=idHab%>" hidden="true">
                        <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                    </div>
                </form>
                <div>
                    <%
                        //MANDO A EJECUTAR LA CONSULTA DE BUSQUEDA, PARA OBTENER LOS DATOS DEL CLIENTE
                        String Cedula, Nombre, Apellido, Direccion, Telefono;
                        if (idCli.equals("null")) {
                            Cedula = "";
                            Nombre = "";
                            Apellido = "";
                        } else {
                            DaoCliente datos = new DaoCliente();
                            datos.BuscarCliente(Integer.parseInt(idCli));
                            //OBTENIENDO DATOS DE LA CONSULTA
                            Cedula = datos.DNI;
                            Nombre = datos.Nombre;
                            Apellido = datos.Apellido;
                        }
                    %>
                    <%-- TABLA PARA MOSTRAR LOS DATOS DEL CLIENTE QUE SE ENCONTRARON--%>
                    <table border="0" width="600">
                        <tbody>
                            <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Nombre</strong></span>                        
                            <input type="text" class="form-control col-sm-4" name="Nombre" id="Nombre" required="true" size="50" value="<%=Nombre%>">
                            <input type="text" name="IdCli" id="IdCli" hidden="true">
                        </div>
                        </tr>
                        <tr>
                        </tr>
                        <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Apellido</strong></span>                        
                            <input type="text" class="form-control col-sm-4" name="Apellido" id="Apellido" required="true" size="50" value="<%=Apellido%>">
                        </div>
                        </tr>
                        <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Cedula</strong></span>                        
                            <input type="text" class="form-control col-sm-4" name="Cedula" id="Cedula" required="true" size="50" value="<%=Cedula%>">
                        </div>
                        </tr>
                        </tbody>
                    </table>
                </div>  
            </div><%-- FIN DEL DIV DE DATOS DEL CLIENTE --%>
            <div id="tab-2"><%-- DIV PARA BUSCAR LOS DATOS DE LA RESERVA --%>
                <form id="FormBuscarReserva" role="form" action="BuscarReserva.jsp">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Reserva:</strong></span>
                        <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa el Nombre que Reservo..." required="true" style="text-align: center">
                        <input id="idHab" name="idHab" value="<%=idHab%>" hidden="true">
                        <input id="idCli" name="idCli" value="<%=idCli%>" hidden="true">
                        <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                    </div>
                </form>
                <div>
                    <%
                        //MANDO A EJECUTAR LA CONSULTA DE BUSQUEDA, PARA OBTENER LOS DATOS DE LA RESERVA
                        String NombreCliente, Estado;
                        Date FechaIN, FechaOUT;
                        int Adultos, Niños, IdTipoHab;
                        if (idReser.equals("null")) {
                            NombreCliente = "";
                            FechaIN = null;
                            FechaOUT = null;
                            Estado = "";
                            Adultos = 0;
                            Niños = 0;
                            IdTipoHab = 0;
                        } else {
                            DaoReservas reserva = new DaoReservas();
                            reserva.BuscarReserva(Integer.parseInt(idReser));
                            //OBTENIENDO DATOS DE LA CONSULTA
                            NombreCliente = reserva.NombreCliente;
                            FechaIN = reserva.FechaIN;
                            FechaOUT = reserva.FechaOUT;
                            Estado = reserva.Estado;
                            Adultos = reserva.Adultos;
                            Niños = reserva.Niños;
                            IdTipoHab = reserva.IdTipoHab;
                        }
                    %>
                    <table border="0" width="600"><%-- TABLA PARA MOSTRAR LOS DATOS DE LA RESERVA QUE SE BUSCO --%>
                        <tbody>
                            <tr>
                        <div>
                            <div class="input-group">
                                <span class="input-group-addon col-sm-2"><strong>Nombre</strong></span>                        
                                <input type="text" class="form-control col-sm-6" name="NombreCliente" id="Nombre" required="true" size="50" value="<%=NombreCliente%>" style="text-align: center">
                                <input type="text" name="IdCli" id="IdCli" hidden="true">
                            </div>                            
                        </div>
                        </tr>
                        <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Fecha Llegada</strong></span>                        
                            <input type="text" class="form-control col-sm-2" name="FechaIN" id="FechaIN" required="true" size="50" value="<%=FechaIN%>" style="text-align: center">
                            <span class="input-group-addon col-sm-2"><strong>Fecha Salida</strong></span>                        
                            <input type="text" class="form-control col-sm-2" name="FechaOUT" id="FechaOUT" required="true" size="50" value="<%=FechaOUT%>" style="text-align: center">
                        </div>                                
                        </tr>                        
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Adultos</strong></span>                        
                            <input type="number" class="form-control col-sm-2" name="" id="" required="true" size="50" min="0" value="<%=Adultos%>" style="text-align: center">
                            <span class="input-group-addon col-sm-2"><strong>Niños</strong></span>                        
                            <input type="number" class="form-control col-sm-2" name="" id="" required="true" size="50" min="0" value="<%=Niños%>" style="text-align: center">
                        </div>                                
                        </tr>                        
                        <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Comentarios</strong></span>
                            <input type="text" class="form-control col-sm-6" name="Cometarios" id="Cometarios" maxlength="100">
                        </div>
                        </tr>
                        </tbody>
                    </table><%-- FIN TABLA PARA MOSTRAR LOS DATOS DE LA RESERVA QUE SE BUSCO --%>
                </div>
            </div><%-- FIN DIV DATOS RESERVA --%>
            <div id="tab-3"><%--DIV DATOS PARA AÑADIR EXTRAS A LA HABITACION O MAS HABITACIONES --%>
                <%
                    //MANDO A EJECUTAR LA CONSULTA DE BUSQUEDA, PARA OBTENER LOS DATOS DE LA RESERVA
                    DaoHabitacion Hab = new DaoHabitacion();
                    Hab.BuscarDatosHabitacion(Integer.parseInt(idHab));
                    //OBTENIENDO DATOS DE LA CONSULTA
                    String NombreHab, NumeroHab, TipoHab, MaxPersonas, Precio;
                    NombreHab = Hab.Nombre;
                    NumeroHab = Hab.NumeroHab;
                    TipoHab = Hab.TipoHab;
                    MaxPersonas = Hab.MaxPersonas;
                    Precio = Hab.Precio;
                %>
                <div class="input-group">
                    <span class="input-group-addon col-sm-2"><strong>Habitacion</strong></span>                        
                    <input type="text" class="form-control col-sm-6" name="Habitacion" id="Habitacion" required="true" size="50" value="<%=NombreHab%>" style="text-align: center">
                </div>
                <div class="input-group">
                    <span class="input-group-addon col-sm-2"><strong>Tipo Habitacion</strong></span>                        
                    <input type="text" class="form-control col-sm-6" name="TipoHab" id="TipoHab" required="true" size="50" value="<%=TipoHab%>" style="text-align: center">
                </div>
                <div class="input-group">
                    <span class="input-group-addon col-sm-2"><strong>Maximo Huespedes</strong></span>                        
                    <input type="text" class="form-control col-sm-2" name="MaxPersonas" id="MaxPersonas" required="true" size="50" value="<%=MaxPersonas%>" style="text-align: center">
                    <span class="input-group-addon col-sm-2"><strong>Precio</strong></span>                        
                    <input type="text" class="form-control col-sm-2" name="Precio" id="Precio" required="true" size="50" value="<%=Precio%>" style="text-align: center">
                </div>
            </div><%--FIN DIV DATOS PARA AÑADIR EXTRAS A LA HABITACION O MAS HABITACIONES --%>
        </div> <%-- DIV FIN GRUPO DE TABS --%>
        <script type="text/javascript">
            $('#FechaIN').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                minDate: 0,
                autoclose: true
            });
        </script>
        <script type="text/javascript">
            $('#FechaOUT').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                minDate: 0,
                yearRange: "2018:2050",
                autoclose: true
            });
        </script>
    </body>
</html>
