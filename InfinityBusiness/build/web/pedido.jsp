<%-- 
    Document   : pedido
    Created on : 07-19-2017, 01:03:34 PM
    Author     : Moises Romero
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="model.Producto"%>
<%@page import="model.DaoProducto"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.sql.Blob"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletAgregaPedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Integer IdBeb, IdComid, IdPost, CantBeb, idTipoCat = 0;
    String idMesa = request.getParameter("idMesa");
    String idHab = request.getParameter("idHab");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link href="css/SideBarMenu.css" rel="stylesheet">
        <link href="//maxcdn.bootstrapcdn.com/font-awesome/4.2.0/css/font-awesome.min.css" rel="stylesheet">
        <title>Realiza Pedido</title>
    </head>
    <body>
        <div id="wrapper">
            <!-- Sidebar -->
            <div id="sidebar-wrapper">
                <ul class="sidebar-nav">
                    <li class="sidebar-brand">
                        <a href="#">Categorias de Los Productos</a>
                    </li>
                    <li>
                        <a href="pedido.jsp?idMesa=<%=idMesa%>">Ver Todo</a>
                    </li>
                    <% // declarando y creando objetos globales 
                        try {
                            ConexionDB conn = new ConexionDB();
                            conn.Conectar();
                            String consulta = "SELECT IdCategoria, IdTipoCat, Nombre, Descripcion, Activo FROM `categoriaproducto` WHERE Activo='Si'  ORDER BY `IdCategoria` ASC";
                            ResultSet rs = null;
                            PreparedStatement pst = null;
                            pst = conn.conexion.prepareStatement(consulta);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                idTipoCat = rs.getInt("IdCategoria");
                                String Nombre = rs.getString("Nombre");
                                out.println("<li><a href='PedidoFiltro.jsp?idMesa=" + idMesa + "&IdCategoria=" + idTipoCat + "'>" + Nombre + "</a></li>");
                            }; // fin while 
                        } //fin try no usar ; al final de dos o mas catchs 
                        catch (SQLException e) {
                        };
                        //}; 
                    %>
                </ul>
            </div>
            <!-- /#sidebar-wrapper -->

            <!-- Page Content -->
            <div id="page-content-wrapper">
                <div class="container-fluid">
                    <a href="#menu-toggle" id="menu-toggle"><img src="images/Menu.ico"></a>
                    <a href="PrincipalRestaurante.jsp"><img src="images/back48.png"></a>
                    <table>
                        <tbody>
                            <%
                                ArrayList<Producto> lista = DaoProducto.obtenerProductos();
                                int salto = 0;
                                for (int i = 0; i < lista.size(); i++) {
                                    Producto p = lista.get(i);
                            %>
                        <td>
                            <form id='FormPedido' role='form' action='ServletAgregaPedido' method='POST' class='form-control'>
                                <%if (idMesa == null) {%>
                                <input type='text' class='form-control' id='IdHab' name='IdHab' value='<%=idHab%>' hidden='true'>
                                <input type='text' class='form-control' id='IdMesa' name='IdMesa' value='0' hidden='true'>
                                <%}%>
                                <%if (idHab == null) {%>
                                <input type='text' class='form-control' id='IdHab' name='IdHab' value='0' hidden='true'>
                                <input type='text' class='form-control' id='IdMesa' name='IdMesa' value='<%=idMesa%>' hidden='true'>
                                <%}%>
                                <input type='text' class='form-control' id='IdProducto' name='IdProducto' value='<%=p.getIdProducto()%>' hidden='true'>
                                <button type='submit'>
                                    <img src='<%=p.getFoto()%>' width='260px' height='260px' alt='<%=p.getNombre()%>'/>
                                    <h3><%=p.getNombre()%> <%=p.getPrecio1()%> <img src="images/Add32.ico" style="align-content: center;"></h3>
                                    <input type='text' class='form-control' id='IdMesa' name='IdMesa' value='<%=idMesa%>' hidden='true'>
                                </button>
                                <center>
                                    <input type='number' class='form-control' id="Cantidad" name="Cantidad" required="true" value="1" min="1" style="text-align: center;">
                                </center>
                            </form>
                        </td>
                        <%
                            salto++;
                            if (salto == 3) {
                        %>
                        <tr>
                            <%
                                        salto = 0;
                                    }
                                }
                            %>
                            </tbody>                    
                    </table>
                </div>
            </div>
            <!-- /#page-content-wrapper -->

        </div>
        <!-- /#wrapper -->

        <!-- Bootstrap core JavaScript -->
        <script src="jquery/jquery.min.js"></script>
        <script src="popper/popper.min.js"></script>
        <script src="assets/js/lib/bootstrap.js"></script>

        <!-- Menu Toggle Script -->
        <script>
            $("#menu-toggle").click(function (e) {
                e.preventDefault();
                $("#wrapper").toggleClass("toggled");
            });
        </script>
    </body>
</html>