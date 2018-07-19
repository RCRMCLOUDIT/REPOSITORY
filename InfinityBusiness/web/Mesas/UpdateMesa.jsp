<%-- 
    Document   : UpdateMesa
    Created on : 11-13-2017, 07:06:37 PM
    Author     : Moises Romero
--%>

<%@page import="model.DaoMesas"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int IdMesa = Integer.parseInt(request.getParameter("idMesa"));
    DaoMesas datos = new DaoMesas();
    datos.FindMesa(IdMesa);
    String Nombre = datos.Nombre;
    String Estado = datos.Estado;
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
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var IdMesa = $('#form-UpdateIdMesa').val();
                    var Nombre = $('#form-UpdateNombre').val();
                    //var Estado = $('#form-AddNombre').val();
                    var Accion = "Update";
                    $.ajax({
                        type: 'POST',
                        data: {IdMesa: IdMesa, Nombre: Nombre, Accion: Accion},
                        url: '../ServletMesas',
                        success: function (response) {
                            //utilzar response
                         location.href ="/InfinityBusiness/Mesas/ListadoMesas.jsp";
                        }
                    });
                });
            });
        </script>
        <title>Datos Mesa</title>
    </head>
    <body class="bg-info">
        <form id="UpdateMesa" role='form' action='../ServletMesas' method='POST'>
            <div class="row">
                <span class="col-sm-3"></span>
                <span class="col-sm-4">
                    <legend>
                        <h1>Datos de Mesa</h1>
                    </legend>
                </span>
                <span class="col-sm-3"></span>
            </div>

            <div class="row form-group">
                <div class="col-sm-2"> </div>
                <div class="col-sm-1">
                    <strong>
                        <label class="control-label">Nombre:</label>
                    </strong>
                </div>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="form-UpdateNombre" required="true" value="<%=Nombre%>">
                    <input type="text" class="form-control" id="form-UpdateIdMesa" value="<%=IdMesa%>" hidden="true">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-sm-2"> </div>
                <div class="col-sm-1">
                    <strong>
                        <label class="control-label">Estado:</label>
                    </strong>
                </div>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="form-UpdateEstado" required="true"  readonly="true" value="<%=Estado%>">
                </div>
            </div>
            <br>
            <div class="row form-group">
                <div class="col-sm-3"> </div>
                <div class="col-sm-offset-3 col-sm-3">
                    <button type='button' onclick='history.go(-1); return false;' class='btn btn-primary'><< Volver</button>
                    <button type="button" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                </div>
            </div>
        </form>
    </body>
</html>
