<%-- 
    Document   : EditarMarca
    Created on : 05-10-2018, 03:41:40 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="controller.ServletMarca"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String IdMarca = request.getParameter("idMarca");
    String Nombre = request.getParameter("Nombre");
    String Descripcion = request.getParameter("Descripcion");
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
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Editando|Marca</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Editando Marca</h1>               
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos de la Marca</a></li>
            </ul>
            <div id="tab-1"><%-- DIV DE DATOS DE MARCA --%>
                <%-- FORMULARIO PARA MANDAR ACTUALIZAR LOS DATOS --%>
                <form id="UpdateMarca" role='form' action='../ServletMarca' method='POST'>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Marca</strong></span>
                        <input id="form-Nombre" name="form-Nombre" type="text" class="form-control col-sm-4" style="text-align: center" value="<%=Nombre%>">
                        <input type="text" class="form-control" id="form-IdMarca" name="form-IdMarca" value="<%=IdMarca%>" hidden="true">
                        <input type="text" class="form-control" id="Accion" name="Accion" value="Update" hidden="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Descripcion</strong></span>
                        <input autocomplete="off" id="form-Descripcion" name="form-Descripcion" type="text" class="form-control col-sm-4" style="text-align: center" value="<%=Descripcion%>">
                    </div>
                    <BR>
                    <div class="row form-group">
                        <div class="col-sm-3"> </div>
                        <div class="col-sm-offset-3 col-sm-3">
                            <button type='button' onclick='history.go(-1);
                                    return false;' class='btn btn-primary'><< Volver</button>
                            <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                        </div>
                    </div>
                </form><%-- FIN FORMULARIO PARA MANDAR ACTUALIZAR LOS DATOS DEL USUARIO --%>
            </div><%--FIN DIV DE DATOS DEL USUARIO --%>
        </div><%--FIN DIV GRUPO DE TABS--%>
    </body>
</html>