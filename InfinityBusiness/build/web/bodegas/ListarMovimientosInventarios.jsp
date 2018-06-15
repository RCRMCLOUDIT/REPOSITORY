<%-- 
    Document   : ListarMovimientosInventarios
    Created on : 07-24-2017, 11:10:05 AM
    Author     : Moises Romero
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
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
        <title>Movimiento de Inventario</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Movimientos Invetario</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaMarca">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-body" >
                            <table class="table" id="tblInventario">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <td style="color: #FFFFFF; text-align: center;">Id</td>
                                        <td style="color: #FFFFFF; text-align: center;">Tipo</td>
                                        <td style="color: #FFFFFF; text-align: center;">Producto</td>
                                        <td style="color: #FFFFFF; text-align: center;">Cantidad</td>
                                        <td style="color: #FFFFFF; text-align: center;">Stock Inicial</td>
                                        <td style="color: #FFFFFF; text-align: center;">Stock Final</td>
                                        <td style="color: #FFFFFF; text-align: center;">Fecha</td>
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
                                            String consulta = "SELECT movimientoinventario.IdMovimiento, tipomovimiento.Nombre,  producto.Nombre, movimientoinventario.Cantidad, movimientoinventario.StockInicial, movimientoinventario.StockFinal, movimientoinventario.FechaMov FROM `movimientoinventario`  INNER JOIN tipomovimiento ON movimientoinventario.IdTipoMov=tipomovimiento.IdTipoMov INNER JOIN producto ON movimientoinventario.IdProducto=producto.IdProducto ORDER BY movimientoinventario.IdMovimiento DESC";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 60px' name='form-id' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Mesa' name='form-Nombre' value='" + rs.getString(2) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Producto' name='form-Descrip' value='" + rs.getString(3) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Producto' name='form-Activo' value='" + rs.getString(4) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Producto' name='form-Activo' value='" + rs.getString(5) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Producto' name='form-Activo' value='" + rs.getString(6) + "'>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Producto' name='form-Activo' value='" + rs.getString(7) + "'>"
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
    </body>
</html>
