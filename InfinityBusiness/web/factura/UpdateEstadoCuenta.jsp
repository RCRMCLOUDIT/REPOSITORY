<%-- 
    Document   : UpdateEstadoCuenta
    Created on : 12-13-2017, 12:55:54 AM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoProducto"%>
<%@page import="model.DaoPedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int IdDetPed = Integer.parseInt(request.getParameter("idDetPed"));
    int IdMesa = Integer.parseInt(request.getParameter("idMesa"));
    String Producto = "";
    int Cantidad, IdProducto;
    //MANDO A BUSCAR LOS DATOS DEL DETALLE
    DaoPedido datos = new DaoPedido();
    datos.BuscarDetallePedido(IdDetPed);
    IdProducto = datos.IdProducto;
    Cantidad = datos.Cantidad;
    //MANDO A BUSCAR EL NOMBRE DEL PRODUCTO
    DaoProducto dato = new DaoProducto();
    dato.BuscarProducto(IdProducto);
    Producto = dato.Nombre;
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
        <title>Actualiza Datos</title>
    </head>
    <body class="bg-info">
        <form id="UpdateEstadoCuenta" role='form' action='../ServletActualizaPedido' method='POST'>
            <div class="row">
                <span class="col-sm-3"></span>
                <span class="col-sm-4">
                    <legend>
                        <h1>Detalle del Pedido</h1>
                    </legend>
                </span>
                <span class="col-sm-3"></span>
            </div>

            <div class="row form-group">
                <div class="col-sm-2"> </div>
                <div class="col-sm-1">
                    <strong>
                        <label class="control-label">Producto:</label>
                    </strong>
                </div>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="form-UpdateNombre" name="form-UpdateNombre" required="true" value="<%=Producto%>">
                    <input type="text" class="form-control" id="form-UpdateIdMesa" name="form-UpdateIdMesa" value="<%=IdMesa%>" hidden="true">
                    <input type="text" class="form-control" id="form-UpdateIdDetalle" name="form-UpdateIdDetalle" value="<%=IdDetPed%>" hidden="true">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-sm-2"> </div>
                <div class="col-sm-1">
                    <strong>
                        <label class="control-label">Cantidad Actual:</label>
                    </strong>
                </div>
                <div class="col-sm-2">
                    <input type="text" class="form-control" id="form-CantidadActual" readonly="true" value="<%=Cantidad%>">
                </div>
            </div>
            <div class="row form-group">
                <div class="col-sm-2"> </div>
                <div class="col-sm-1">
                    <strong>
                        <label class="control-label">Cambiar Cantidad A:</label>
                    </strong>
                </div>
                <div class="col-sm-2">
                    <input type="number" class="form-control" id="form-UpdateCantidad" name="form-UpdateCantidad" required="true"  placeholder="Nueva Cantidad...">
                    <input type="text" class="form-control" id="Accion" name="Accion" value="Actualiza" hidden="true">
                </div>
            </div>
            <br>
            <div class="row form-group">
                <div class="col-sm-3"> </div>
                <div class="col-sm-offset-3 col-sm-3">
                    <button type='button' onclick='history.go(-1); return false;' class='btn btn-primary'><< Volver</button>
                    <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                </div>
            </div>
        </form>
    </body>
</html>
