<%-- 
    Document   : TestPestaña
    Created on : 03-16-2018, 11:56:42 AM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoCliente"%>
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
            </ul>
            <div id="tab-1">
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
            </div>
            <div id="tab-2">
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
                    <table border="0" width="600">
                        <tbody>
                            <tr>
                        <div>
                            <div class="input-group">
                                <span class="input-group-addon col-sm-2"><strong>Nombre</strong></span>                        
                                <input type="text" class="form-control col-sm-6" name="Nombre" id="Nombre" required="true" size="50" value="<%=Nombre%>" style="text-align: center">
                                <input type="text" name="IdCli" id="IdCli" hidden="true">
                            </div>                            
                        </div>
                        </tr>
                        <tr>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Fecha Llegada</strong></span>                        
                            <input type="text" class="form-control col-sm-2" name="" id="" required="true" size="50" value="" style="text-align: center">
                            <span class="input-group-addon col-sm-2"><strong>Fecha Salida</strong></span>                        
                            <input type="text" class="form-control col-sm-2" name="" id="" required="true" size="50" value="" style="text-align: center">
                        </div>                                
                        </tr>                        
                        <div class="input-group">
                            <span class="input-group-addon col-sm-2"><strong>Adultos</strong></span>                        
                            <input type="number" class="form-control col-sm-2" name="" id="" required="true" size="50" min="0" value="0" style="text-align: center">
                            <span class="input-group-addon col-sm-2"><strong>Niños</strong></span>                        
                            <input type="number" class="form-control col-sm-2" name="" id="" required="true" size="50" min="0" value="0" style="text-align: center">
                        </div>                                
                        </tr>                        
                        </tbody>
                    </table>
                </div>
            </div>
        </div> <%-- DIV FIN GRUPO DE TABS --%>
    </body>
</html>