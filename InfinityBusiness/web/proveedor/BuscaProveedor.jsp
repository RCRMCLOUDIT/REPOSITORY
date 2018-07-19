<%-- 
    Document   : BuscaProveedor
    Created on : 05-21-2018, 03:08:01 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="../assets/css/bootstrap.css">
        <link rel="stylesheet" href="../assets/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="../assets/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="../assets/css/responsive.bootstrap.min.css">
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
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Busqueda Proveedor</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Busqueda Proveedor</h1>
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Proveedor</a></li>
            </ul>
            <%-- FORMULARIO PARA MANDAR A BUSCAR UN PROVEEDOR --%>
            <form id="FindProveedor" role='form' action='ListaProveedor.jsp' method='POST'>
                <div id="tab-1"><%-- DIV DE PARAMETROS PARA LA BUSQUEDA DEL PROVEEDOR --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Proveedor:</strong></span>
                        <input id="form-Nombre" name="form-Nombre" type="text" class="form-control col-sm-6" placeholder="Ingresa el Nombre Proveedor..." style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo RUC:</strong></span>
                        <input id="form-CodigoRuc" name="form-CodigoRuc" type="text" class="form-control col-sm-6" placeholder="Ingresa el Codigo Ruc..."  style="text-align: center">
                    </div>
                </div><%--FIN DIV DE PARAMETROS PARA LA BUSQUEDA DEL PROVEEDOR --%>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type="submit" class="btn btn-primary" id="btnBuscar" name="btnBuscar" >Buscar</button>
                        <button type='button' onclick='location.href = "AgregaProveedor.jsp"' class='btn btn-primary'>Ir Agregar Nuevo</button>
                    </div>
                </div>
            </form> <%--FIN FORMULARIO PARA MANDAR A BUSCAR UN PROVEEDOR--%>
        </div><%--FIN DIV GRUPO DE TABS--%>
    </body>
</html>
