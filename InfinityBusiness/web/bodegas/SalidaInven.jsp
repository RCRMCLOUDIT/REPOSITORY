<%-- 
    Document   : SalidaInven
    Created on : 07-28-2017, 02:44:30 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controller.ServletMovimientoInventario"%>
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
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var idProd = $('#form-AddProducto').val();
                    var cantidad = $('#form-AddCantidad').val();
                    var costo = $('#form-AddCosto').val();
                    var accion = "salida";

                    if ($('#form-AddProducto').val() == "") {
                        alert("Revisar Seleccione un Producto, Campo Vacio");
                        $('#form-AddProducto').focus();
                    } else if ($('#form-AddCantidad').val() == "") {
                        alert("Revisar Cantidad, Campo Vacio");
                        $('#form-AddCantidad').focus();
                    } else if ($('#form-AddCantidad').val() == "0") {
                        alert("Revisar Cantidad, Ingrese Cantidad mayor que 0");
                        $('#form-AddCantidad').focus();
                    } else if ($('#form-AddCosto').val() == "") {
                        alert("Revisar Costo, Campo Vacio");
                        $('#form-AddCosto').focus();
                    } else if ($('#form-AddCosto').val() == "0") {
                        alert("Revisar Costo, El costo no puede ser 0");
                        $('#form-AddCosto').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {IdProducto: idProd, Cantidad: cantidad, Costo: costo, Accion: accion},
                            url: '../ServletMovimientoInventario',
                            success: function (response) {
                                //utilzar response
                                $('#Agregar').modal('hide');
                                location.reload(true);
                            }
                        });
                    }
                });
            });
        </script>
        <title>Salidas</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaMarca">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-heading">
                            <div class="panel-title">
                                <h3 class="panel-title">Salidas de Inventario</h3>
                            </div>
                            <div class="panel-title">
                                <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar </button>                                
                            </div>
                        </div>
                        <table class="table" id="tblSalidas">
                            <div class="panel-body" >
                                <thead>
                                    <tr>
                                        <td>Id</td>
                                        <td>Producto</td>
                                        <td>Cantidad</td>
                                        <td>Stock Inicial</td>
                                        <td>Stock Final</td>  
                                        <td>Costo Venta</td>  
                                        <td>Fecha Realizado</td>
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
                                            String consulta = "SELECT  movimientoinventario.IdMovimiento, producto.Nombre, movimientoinventario.Cantidad, movimientoinventario.StockInicial, movimientoinventario.StockFinal, movimientoinventario.Costo, movimientoinventario.FechaMov FROM `movimientoinventario` INNER JOIN tipomovimiento on movimientoinventario.IdTipoMov=tipomovimiento.IdTipoMov INNER JOIN producto ON movimientoinventario.IdProducto=producto.IdProducto WHERE tipomovimiento.IdTipoMov = 2 ORDER BY movimientoinventario.IdMovimiento DESC";
                                            ResultSet rs = null;

                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            //   tabla = instruccion.executeQuery(q); 
                                            // mandando resultset a tabla html 
                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormCategoria' role='form' action='../ServletMovimientoInventario'"
                                                        + "method='POST' class='form-control'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' name='form-id' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Mesa' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='Producto' name='form-Descrip' readonly value='" + rs.getInt(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='Producto' name='form-Activo' readonly value='" + rs.getInt(4) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' name='form-id' readonly value='" + rs.getInt(5) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' name='form-id' readonly value='" + rs.getInt(6) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' name='form-id' readonly value='" + rs.getString(7) + "'>"
                                                        + "</div>"
                                                        + "</form>"
                                                        + "</TD>");

                                                out.println("</TR>");

                                            }; // fin while 

                                            //out.println("</TABLE></CENTER></DIV></HTML>");
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
    <%--VENTANA MODAL PARA AGREGAR UNA NUEVA SALIDA DE INVENTARIO --%>
<center>
    <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4>Agregando Salida</h4>
                </div>
                <div class="modal-body">
                    <form id="FormEntrada" role="form" action="ServletMovimientoInventario" method="POST" class="form-control">
                        <div class="form-control">
                            <label for="Producto">Selecciona Producto:</label>
                            <select class="form-control" id="form-AddProducto" name="form-AddProducto">
                                <% // declarando y creando objetos globales 
                                    try {
                                        ConexionDB conn = new ConexionDB();
                                        conn.Conectar();
                                        String consulta = "SELECT IdProducto, Nombre FROM `producto` WHERE Activo='SI'";
                                        ResultSet rs = null;
                                        PreparedStatement pst = null;
                                        pst = conn.conexion.prepareStatement(consulta);
                                        rs = pst.executeQuery();
                                        while (rs.next()) {
                                            out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                        }; // fin while 
                                    } //fin try no usar ; al final de dos o mas catchs 
                                    catch (SQLException e) {
                                    };
                                    //}; 
                                %>
                            </select>
                        </div>
                        <div class="form-control">
                            <label for="AddCantidad">Cantidad</label>
                            <input type="text" class="form-control" id="form-AddCantidad" placeholder="Cantidad...">   
                        </div>
                        <div class="form-control">
                            <label for="AddCosto">Costo de Salida</label>
                            <input type="text" class="form-control" id="form-AddCosto" placeholder="Costo...">   
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btnAgregar" >Agregar</button>
                </div>
            </div>
        </div>
    </div>
</center> 
</body>
</html>