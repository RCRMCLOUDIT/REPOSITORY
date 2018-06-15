<%-- 
    Document   : AjusteInven
    Created on : 07-28-2017, 02:45:17 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
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

        <title>Ajustes</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaSalidasInv">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-heading">
                            <h3 class="panel-title">Ajustes de Inventario</h3>
                        </div>
                            <table class="table" id="tblAjustes">
                        <div class="panel-body" >
                                <thead>
                                    <tr>
                                        <td>Id</td>
                                        <td>Producto</td>
                                        <td>Cantidad</td>
                                        <td>Stock Inicial</td>
                                        <td>Stock Final</td>                                        
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
                                            String consulta = "SELECT  movimientoinventario.IdMovimiento, producto.Nombre, movimientoinventario.Cantidad, movimientoinventario.StockInicial, movimientoinventario.StockFinal, movimientoinventario.FechaMov FROM `movimientoinventario` INNER JOIN tipomovimiento on movimientoinventario.IdTipoMov=tipomovimiento.IdTipoMov INNER JOIN producto ON movimientoinventario.IdProducto=producto.IdProducto WHERE tipomovimiento.IdTipoMov = 3 ORDER BY movimientoinventario.IdMovimiento DESC";
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
                                                        + "<form id='FormCategoria' role='form' action='../ServletCategoriaProd'"
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
                                                        + "<input type='text' class='form-control' style='width: auto' name='form-id' readonly value='" + rs.getString(6) + "'>"
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
        <%--VENTANA MODAL PARA AGREGAR UN NUEVO AJUSTE DE INVENTARIO --%>
    <center>
        <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar </button>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar Ajuste</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormMarca" role="form" action="ServletMarca" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Nombre">Nombre</label>
                                <input type="text" class="form-control" id="Nombre" placeholder="Nombre...">   
                            </div>
                            <div class="form-control">
                                <label for="Descripcion">Descripcion</label>
                                <input type="text" class="form-control" id="Descripcion" placeholder="Simbolo...">   
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" >Agregar</button>
                    </div>
                </div>
            </div>
        </div>
    </center> 
</body>
</html>
