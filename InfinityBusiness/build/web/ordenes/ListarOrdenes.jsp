<%-- 
    Document   : ListarOrdenes
    Created on : 07-23-2017, 10:20:40 PM
    Author     : Moises Romero
--%>

<%@page import="model.ClaseOrdenes"%>
<%@page import="java.util.ArrayList"%>
<%@page import="model.DaoOrdenes"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletEstadoDetPedido"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
        <script type="text/javascript" src="../js/bootstrap.js"></script>

        <link rel="stylesheet" href="../assets/css/bootstrap.css">
        <link rel="stylesheet" href="../assets/css/responsive.bootstrap.min.css">
        <script src="../assets/js/lib/menu.js"></script>
        <script src="../assets/js/lib/dataTables.responsive.min.js"></script>
        <script src="../assets/js/lib/responsive.bootstrap.min.js"></script>
        <script src="../assets/js/lib/bootstrap.js"></script>     

        <title>Lista de Ordenes Pendientes</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>    
    <body>
        <table class="table bg-primary">
            <%  //MANDO A LLAMAR EL ARREGLO DE LA CLASE *DAOMESA
                ArrayList<ClaseOrdenes> lista = DaoOrdenes.obtenerOrdenes();
                int salto = 0; // VARIABLE PARA CONROLAR EL CORTE DE LINEA
                for (int i = 0; i < lista.size(); i++) {// FOR PARA OBTENER LAS MESAS
                    ClaseOrdenes c = lista.get(i);
                    if (c.getEstado().equals("Preparando")) { // SI LA ORDEN ESTA EN ESTADO PREPARANDO LA MUESTROF
            %>
            <td>
                <div class="panel-group">
                    <div class="panel panel-default">
                        <div class="panel-body">
                            <form id="FormDespachaOrden" role="form" action="../ServletEstadoDetPedido" method="POST" class="form-control">
                                <div class='caption'>
                                    <Center>
                                        <h3><%=c.getNombre()%></h3>
                                    </Center>
                                </div>
                                <div class="form-control">
                                    <strong>
                                        <input type='text' style="text-transform: uppercase" class='form-control bg-warning' id='Cant' name='Cant' value='Cantidad: <%=c.getCantidad()%>' placeholder='Cantidad...'>                                          
                                    </strong>
                                </div>
                                <div class="form-control">
                                    <strong>
                                    <input type='text' class='form-control bg-info' id='IdMesa' name='IdMesa' value='<%=c.getMesa()%>' placeholder='Mesa...'>
                                    </strong>
                                    <input type='text' class='form-control' id='IdDetalle' name='IdDetalle' value='<%=c.getIdDetalle()%>' hidden="true"> 
                                </div>
                                <button type='submit' class='btn btn-success col-xs-12'>Despachado <img src="../images/Listo.ico"></button>
                            </form>
                        </div>
                    </div>
                </div>
                </div>
            </td>
            <%} else {
                    salto = salto - 1;
                }%>
            <%
                salto++;
                if (salto == 4) {
            %>
            <tr>
                <%
                            salto = 0;
                        }
                    }
                %>
        </table>
    </body>
</html>
