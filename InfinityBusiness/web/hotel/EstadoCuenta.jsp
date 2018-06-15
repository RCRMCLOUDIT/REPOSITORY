<%-- 
    Document   : EstadoCuenta
    Created on : 03-15-2018, 10:38:56 AM
    Author     : Ing. Moises Romero Mojica
    ESTADO DE CUENTA PARA MODULO DEL HOTEL
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
    String idHab = request.getParameter("idHab");
    Double IVA;
    DaoEmpresa datos = new DaoEmpresa();
    datos.BuscarEmpresa();
    IVA = datos.IVA / 100;
    DaoPedido Pedido = new DaoPedido();
    Pedido.BuscarDescuentoTEMP(Integer.valueOf(idHab));
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
                var IdHab = document.getElementById('form-idMesa').value;
                var Tipo = "HAB";
                var DescuentoTEMP = document.getElementById('form-Descuento').value;
                if (DescuentoTEMP > "0.00" && DescuentoTEMP <= "100.00") {
                    //alert("Descuento a Aplicar: " + Desc);
                    $.ajax({
                        type: 'POST',
                        data: {IdHab: IdHab, Tipo: Tipo, Descuento: DescuentoTEMP},
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

    <body class="bg-info" onkeypress="return pulsar(event)">
        <section id="lista" class="container bg-info">
            <div class="panel-heading">
                <h3 class="panel-title"><strong>Estado de Cuenta Mesa# <%=idMesa%></strong></h3>
            </div>
            <div class="panel-body">
                <table class="table" id="tblCuenta">
                    <thead>
                        <tr class="bg-success">
                            <td><strong>Id</strong></td>
                            <td><strong>Articulo</strong></td>
                            <td><strong>Cantidad</strong></td>
                            <td><strong>Precio</strong></td>
                            <td><strong>Total</strong></td>
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

                                    out.println("<TR class='bg-warning'>");

                                    out.println("<TD style='display:none;'>"
                                            + "<form id='FormEstadoCuenta' role='form' action='../ServletFacturaHotel'"
                                            + "method='POST' class='form-control'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<input type='text' class='form-control' style='width: 60px' name='form-id' readonly value='" + id + "'>"
                                            + "</TD>");

                                    out.println("<TD style='display:none;'>"
                                            + "<input type='text' class='form-control' style='width: 60px' name='form-idDetallePed' value='" + rs.getInt(1) + "'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<input type='text' class='form-control' style='width: auto' id='form-Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<input type='text' class='form-control' style='width: 60px' id='Cantidad' name='form-Cantidad' readonly value='" + rs.getInt(3) + "'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<input type='text' class='form-control' style='width: 100px' id='Precio' name='form-Precio' readonly value='" + rs.getString(4) + "'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<input type='text' class='form-control' style='width: 100px' id='Sub' name='form-Sub' readonly value='" + rs.getString(5) + "'>"
                                            + "</TD>");

                                    out.println("<TD>"
                                            + "<a class='btn btn-primary' href='UpdateEstadoCuenta.jsp?idHab=" + idHab + "&idDetPed=" + rs.getInt(1) + "'>Editar</a>"
                                            + "<button type='button' class='btn btn-danger' id='btnCancelar' name='btnCancelar'>Cancelar</button>"
                                            + "</TD>");

                                    out.println("</TR>");

                                    SubTotal = SubTotal + Double.valueOf(rs.getString(4));
                                    id = id + 1;
                                }; // fin while 

                                //CAMPO PARA MOSTRAR EL SUBTOTAL
                                out.println("<TR>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 100px' readonly value='Sub-Total'>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 100px' id='form-SubTotal' name='form-SubTotal' readonly value='" + SubTotal + "'>"
                                        + "</TD>");
                                out.println("</TR>");

                                //CAMPO PARA MOSTRAR EL DESCUENTO
                                Descuento = SubTotal * DescTEMP;
                                out.println("<TR>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 100px' readonly value='Descuento'>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "<input type='number' step='any' min='0' max='100' readOnly='true' class='form-control' style='width: 100px' id='form-Descuento' name='form-Descuento' value='" + Descuento + "'>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "<input type='checkbox' id='AddDescuento' name='AddDescuento' onclick='Validar();'>"
                                        + "<button type='button' style='display: none;' class='btn btn-primary' id='btnAplicar' name='btnAplicar' onclick='Aplicar();'>Aplicar</button>"
                                        + "</TD>");

                                out.println("</TR>");

                                //CAMPO PARA MOSTRAR EL
                                //CALCULO DEL IVA
                                Impuesto = SubTotal * IVA;
                                out.println("<TR>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 100px' readonly value='IVA'>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 100px' id='form-Iva' name='form-Iva' readonly value='" + Impuesto + "'>"
                                        + "</TD>");
                                out.println("</TR>");

                                // TOTAL
                                Total = (SubTotal - Descuento) + Impuesto;
                                out.println("<TR>");

                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");
                                out.println("<TD>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control bg-success' style='width: 100px' readonly value='Total'>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control bg-success' style='width: 100px' id='form-Total' name='form-Total' readonly value='" + Total + "'>"
                                        + "</TD>");
                                out.println("</TR>");

                                out.println("<TR>");

                                //out.println("<TD>"
                                //    + "<button type='buttom' onclick='history.go(-1); return false'; class='btn btn-primary'>Volver</button>"
                                //      + "</TD>");
                                out.println("<TD>"
                                        + "<button type='submit' class='btn btn-primary'>Facturar</button>"
                                        + "</TD>");

                                out.println("<TD>"
                                        + "<input type='text' class='form-control' style='width: 60px' id='form-idHab' name='form-idHab' value='" + idHab + "' hidden='true'>"
                                        + "</TD>");

                                out.println("</TR>");

                                out.println("<TD>"
                                        + "</form>"
                                        + "</TD>");

                            } //fin try no usar ; al final de dos o mas catchs 
                            catch (SQLException e) {
                            };
                            //}; 
                        %>
                    </tbody>
                </table>                            
            </div>                        
        </section>
    </body>
</html>
