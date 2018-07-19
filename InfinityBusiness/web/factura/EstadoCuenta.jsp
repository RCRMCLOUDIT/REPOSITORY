<%-- 
    Document   : ListarFacturas
    Created on : 07-19-2017, 01:26:57 PM
    Author     : Ing. Moises Romero Mojica
    ESTADO DE CUENTA PARA MODULO DEL RESTAURANTE
--%>

<%@page import="model.DaoPedido"%>
<%@page import="model.DaoEmpresa"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page import="controller.ServletFactura"%>
<%@page import="controller.ServletDescuentoTemporales"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String idMesa = request.getParameter("idMesa");
    Double IVA;
    DaoEmpresa datos = new DaoEmpresa();
    datos.BuscarEmpresa();
    IVA = datos.IVA / 100;
    DaoPedido Pedido = new DaoPedido();
    Pedido.BuscarDescuentoTEMP(Integer.valueOf(idMesa));
    Double DescTEMP;
    DescTEMP = Pedido.DescTEMP / 100;
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
            // FUNCION PARA ACTIVAR EL CAMPO Y BOTON DESCUENTO A APLICAR
            function Validar() {
                var Check = document.getElementById('AddDescuento').checked;
                if (Check === true) {
                    //alert("Descuento Activado");
                    document.getElementById('form-Descuento').readOnly = false;
                    document.getElementById('btnAplicar').style.display = 'inline';
                    document.getElementById('form-Descuento').value = 0.00;
                } else {
                    document.getElementById('form-Descuento').readOnly = true;
                    document.getElementById('btnAplicar').style.display = 'none';
                    document.getElementById('form-Descuento').value = 0.00;
                }
            }
        </script>
        <script type="text/javascript">
            // FUNCION PARA APLICAR DESCUENTO
            function Aplicar() {
                var IdMesa = document.getElementById('form-idMesa').value;
                var Tipo = "MESA";
                var DescuentoTEMP = document.getElementById('form-Descuento').value;
                if (DescuentoTEMP > "0.00" && DescuentoTEMP <= "100.00") {
                    //alert("Descuento a Aplicar: " + Desc);
                    $.ajax({
                        type: 'POST',
                        data: {IdMesa: IdMesa, Tipo: Tipo, Descuento: DescuentoTEMP},
                        url: '../ServletDescuentoTemporales',
                        success: function (response) {
                            //alert("Funciono");
                            location.reload(true);
                        }
                    });
                } else {
                    alert("No se puede aplicar Descuento: " + Desc);
                    document.getElementById('form-Descuento').readOnly = true;
                    document.getElementById('form-Descuento').value = 0.00;
                }
            }
        </script>
        <script type="text/javascript">
            // FUNCION PARA ACTUALIZAR EL DETALLE DEL PEDIDO EN CASO QUIERA CAMBIAR LAS CANTIDADES
            $(document).ready(function () {
                $('#btnEditar').click(function () {
                    var IdDetalle = $('#form-idDetallePed').val();
                    var Cantidad = $('#form-Cantidad').val();
                    var IdMesa = $('#form-idMesa').val();
                    var Accion = "Actualiza";
                    alert("IdDetalle: " + IdDetalle);
                });
            });
        </script>
        <script type="text/javascript">
            // FUNCION PARA CANCELAR EL PEDIDO 
            $(document).ready(function () {
                $('#btnCancelar').click(function () {
                    var IdDetalle = $('#form-idDetalle').val();
                    var Accion = "Cancelar";
                    alert("IdDetalle: " + IdDetalle);
                    //$.ajax({
                    //    type: 'POST',
                    //    data: {IdDetalle: IdDetalle, Accion: Accion},
                    //    url: '../ServletActualizaPedido',
                    //    success: function (response) {
                    //    }
                    //});
                });
            });
        </script>
        <script>
            //FUNCION PARA BLOQUEAR LE TECLA ENTER Y ASI NO ENVIE EL FORMULARIO
            function pulsar(e) {
                tecla = (document.all) ? e.keyCode : e.which;
                if (tecla === 13)
                    return false;
            }
        </script>
        <title>Estado Cuenta</title>
    </head>
    <body onkeypress="return pulsar(event)">
        <section id="lista" class="container">
            <div id="EncabezadoPagina" style="background-color: #4682B4;">
                <center>
                    <h1 style="color: #FFFFFF; text-align: center;">Estado de Cuenta Mesa# <%=idMesa%></h1>                
                </center>
            </div>
            <div class="panel-body">
                <form id="FormEstadoCuenta" role="form" action="../ServletFactura" method="POST">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Cliente</strong></span>
                        <input type="text" class="form-control" id="form-IdCliente" name="form-IdCliente"readonly="true" hidden="true">
                        <input id="form-NombreCliente" name="form-NombreCliente" type="text" class="form-control col-sm-6" style="text-align: center" placeholder="Ingrese el Nombre del Cliente....">
                    </div>
                    <table class="table table-hover" id="tblCuenta">
                        <thead style="background-color: #4682B4">
                            <tr>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Id</strong></th>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Articulo</strong></th>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Cantidad</strong></th>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Precio</strong></th>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Total</strong></th>
                                <th style="color: #FFFFFF; text-align: center;"><strong>Fecha Factura:</strong><span style="color: red">*</span></th>
                                <td><input type="text" class="form-control" id="FechaFactura" name="FechaFactura" style="text-align: center;"></td>
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
                                    String consulta = "SELECT `detallepedido`.IdDetalle, `producto`.`Nombre`, SUM(`detallepedido`.`Cantidad`) AS Cantidad, `detallepedido`.`Precio`, "
                                            + "SUM(`detallepedido`.`Subtotal`) AS Subtotal FROM `producto` LEFT JOIN `detallepedido` ON `detallepedido`.`IdProducto` = `producto`.`IdProducto`  "
                                            + "LEFT JOIN `pedido` ON `detallepedido`.`IdPedido` = `pedido`.`IdPedido` WHERE `pedido`.`IdMesa` = " + idMesa + " AND "
                                            + "`pedido`.`Estado` LIKE'Abierto' GROUP BY `producto`.`Nombre` having count(*) > 0";
                                    ResultSet rs = null;

                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    //   tabla = instruccion.executeQuery(q); 
                                    // mandando resultset a tabla html 
                                    int id = 1;
                                    double SubTotal = 0.00;
                                    double Descuento = 0.00;
                                    double Impuesto = 0.00;
                                    double Total = 0.00;
                                    while (rs.next()) {
                                        out.println("<TR style='text-align: center;'>");
                                        out.println("<TD style='color: #000000;'>" + id + "</TD>");
                                        out.println("<TD style='display:none;'>" + rs.getInt(1) + "</TD>");
                                        out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                        out.println("<TD style='color: #000000;'>" + rs.getInt(3) + "</TD>");
                                        out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                        out.println("<TD style='color: #000000;'>" + rs.getString(5) + "</TD>");
                                        out.println("<TD>"
                                                + "<a class='btn btn-primary' href='UpdateEstadoCuenta.jsp?idMesa=" + idMesa + "&idDetPed=" + rs.getInt(1) + "'>Editar</a>"
                                                + "<button type='button' class='btn btn-danger' id='btnCancelar' name='btnCancelar'>Cancelar</button>"
                                                + "</TD>");
                                        out.println("</TR>");
                                        SubTotal = SubTotal + Double.valueOf(rs.getString(4));
                                        id = id + 1;
                                    }; // fin while 

                                    //CAMPO PARA MOSTRAR EL SUBTOTAL
                                    out.println("<TR>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD style='color: #000000; text-align: right;'><Strong>Sub-total =</Strong></TD>");
                                    out.println("<TD style='color: #000000;'>" + SubTotal + "</TD>");
                                    out.println("<TD></TD>");
                                    out.println("</TR>");

                                    //CAMPO PARA MOSTRAR EL DESCUENTO
                                    Descuento = SubTotal * DescTEMP;
                                    out.println("<TR>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD style='color: #000000; text-align: right;'><Strong>Descuento =</Strong></TD>");
                                    out.println("<TD style='color: #000000;'>"
                                            + "<input type='number' step='any' min='0' max='100' readOnly='true' class='form-control' style='width: 80px' id='form-Descuento' name='form-Descuento' value='" + Descuento + "'>"
                                            + "</TD>");
                                    out.println("<TD style='color: #000000;'>"
                                            + "<input type='checkbox' id='AddDescuento' name='AddDescuento' onclick='Validar();'>"
                                            + "<button type='button' style='display: none;' class='btn btn-primary' id='btnAplicar' name='btnAplicar' onclick='Aplicar();'>Aplicar</button>"
                                            + "</TD>");
                                    out.println("</TR>");

                                    //CAMPO PARA MOSTRAR EL
                                    //CALCULO DEL IVA
                                    Impuesto = SubTotal * IVA;
                                    out.println("<TR>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD style='color: #000000; text-align: right;'><Strong>IVA =</Strong></TD>");
                                    out.println("<TD style='color: #000000;'>" + Impuesto + "</TD>");
                                    out.println("<TD></TD>");
                                    out.println("</TR>");

                                    // TOTAL
                                    Total = (SubTotal - Descuento) + Impuesto;
                                    out.println("<TR>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD></TD>");
                                    out.println("<TD style='color: #000000; text-align: right;'><Strong>Total =</Strong></TD>");
                                    out.println("<TD style='color: #000000;'>" + Total + "</TD>");
                                    out.println("<TD></TD>");
                                    out.println("</TR>");
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
%>
                        </tbody>
                    </table>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Comentarios Cliente</strong></span>
                        <input id="form-ComentCliente" name="form-ComentCliente" type="text" class="form-control col-sm-6" style="text-align: center" placeholder="Algun comentario para el cliente">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Comentarios Internos</strong></span>
                        <input id="form-ComentInterno" name="form-ComentInterno" type="text" class="form-control col-sm-6" style="text-align: center" placeholder="Algun comentario para uso interno">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Observaciones</strong></span>
                        <input id="form-Observaciones" name="form-Observaciones" type="text" class="form-control col-sm-6" style="text-align: center" placeholder="Alguna Observacion">
                    </div>                        
                    <input type="text" id="form-idMesa" name="form-idMesa" value="<%=idMesa%>" hidden="true"/>
                    <br>
                    <button type="submit" class="btn btn-primary">Generar Factura</button>
                </form>
            </div>                        
        </section>
        <script type="text/javascript">
            $('#FechaFactura').datepicker({
                dateFormat: "dd/mm/yy",
                //dateFormat: "dd MM, yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                autoclose: true
            }).datepicker("setDate", new Date());
        </script>
    </body>
</html>
