<%-- 
    Document   : ListarFacturaManual
    Created on : 11-16-2017, 03:12:18 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String idCli = request.getParameter("idCli");
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
        <title>Buscar|Orden Venta</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Buscar Orden Venta</h1>
            </center>
        </div>
        <div id="BuscarCliente">
            <form id="FormBuscarCliente" role="form" action="BuscarCliente.jsp">
                <div class="input-group">
                    <span class="input-group-addon">Buscar Cliente:</span>
                    <input id="filtro" name="filtro" type="text" class="form-control col-sm-6" placeholder="Ingresa Nombre a Buscar..." required="true">
                    <input id="QuienLlama" name="QuienLlama" value="OrdenVenta" type="text" class="form-control col-sm-6" hidden="true">
                    <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                </div>
            </form>
        </div>
        <div id="DatosClienteOrden">
            <% //MANDO A EJECUTAR LA CONSULTA DE BUSQUEDA, PARA OBTENER LOS DATOS DEL CLIENTE
                String Cedula, Nombre, Apellido, Direccion, Telefono;
                if (idCli.equals("null")) {
                    Cedula = "";
                    Nombre = "";
                    Apellido = "";
                    Direccion = "";
                    Telefono = "";
                } else {
                    DaoCliente datos = new DaoCliente();
                    datos.BuscarCliente(Integer.parseInt(idCli));
                    //OBTENIENDO DATOS DE LA CONSULTA
                    Cedula = datos.DNI;
                    Nombre = datos.Nombre;
                    Apellido = datos.Apellido;
                    Direccion = datos.Direccion;
                    Telefono = datos.Telefono;
                }
            %>
            <div class="input-group">
                <span class="input-group-addon">Nombre Cliente:</span>
                <input id="form-NombreCliente" name="form-NombreCliente" type="text" class="form-control col-sm-3" style="text-align: center" value="<%=Nombre%>">
                <input type="text" name="IdCli" id="IdCli" name="IdCli" hidden="true">                
                <span class="input-group-addon">Apellido Cliente:</span>
                <input id="form-ApellidoCliente" name="form-ApellidoCliente" type="text" class="form-control col-sm-3" style="text-align: center" value="<%=Apellido%>">
            </div>
            <div class="input-group">
                <span class="input-group-addon col-sm-1">Desde:</span>
                <input type="text" class="form-control col-sm-2" id="FechaDesde" name="FechaDesde">
                <span class="input-group-addon col-sm-1">Hasta:</span>
                <input type="text" class="form-control col-sm-2" id="FechaHasta" name="FechaHasta">
            </div>
        </div>
        <br>
        <div class="row form-group">
            <div class="col-sm-3"> </div>
            <div class="col-sm-offset-3 col-sm-3">
                <a href="../factura/ListaOrdenVenta.jsp?idCli=<%=idCli%>" class="btn btn-primary">Buscar Ordenes</a>
            </div>
        </div>
        <script type="text/javascript">
            $('#FechaDesde').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd MM, yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                autoclose: true
            }).datepicker("setDate", new Date());
        </script>
        <script type="text/javascript">
            $('#FechaHasta').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd MM, yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                autoclose: true
            }).datepicker("setDate", new Date());
        </script>
    </body>
</html>
