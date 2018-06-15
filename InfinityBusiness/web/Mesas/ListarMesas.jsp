<%-- 
    Document   : ListarMesas
    Created on : 07-10-2017, 03:37:59 PM
    Author     : Moises Romero
--%>
<%@page import="model.Mesas"%>
<%@page import="beans.ConexionDB"%>
<%@page import="model.DaoMesas"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="java.util.ArrayList" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
        <link rel="stylesheet" href="assets/css/bootstrap.css"> 
        <link rel="stylesheet" href="assets/css/dataTables.bootstrap.min.css">
        <link rel="stylesheet" href="assets/css/jquery.dataTables.min.css">
        <link rel="stylesheet" href="assets/css/responsive.bootstrap.min.css">
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <link rel="stylesheet" href="assets/css/font-awesome.min.css">
        <link rel="stylesheet" href="assets/chosen/chosen.min.css">

        <script src="assets/js/lib/jquery.js"></script>
        <script src="assets/js/lib/jquery.dataTables.js"></script>
        <script src="assets/js/lib/dataTables.bootstrap.min.js"></script>
        <script src="assets/js/lib/dataTables.responsive.min.js"></script>
        <script src="assets/js/lib/responsive.bootstrap.min.js"></script>
        <script src="assets/js/lib/jquery-ui.min.js"></script>
        <script src="assets/chosen/chosen.jquery.min.js"></script>  
        <script src="assets/js/chosen.js"></script>  
        <script src="assets/js/lib/bootstrap.js"></script>  
        <script src="assets/js/lib/menu.js"></script>  
        <script src="assets/js/calendario.js"></script>   
        <%-- EFECTO PARA EL MENU DE LAS MESAS CON ESTILO HOVER --%>
        <style>
            .dropbtn {
                /*background-color: #4CAF50;*/
                color: white;
                padding: 16px;
                font-size: 16px;
                border: none;
                cursor: pointer;
            }

            .dropdown {
                position: relative;
                display: inline-block;
            }

            .dropdown-content {
                display: none;
                position: absolute;
                background-color: #f9f9f9;
                min-width: 160px;
                box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                z-index: 1;
            }

            .dropdown-content a {
                color: black;
                padding: 12px 16px;
                text-decoration: none;
                display: block;
            }

            .dropdown-content a:hover {background-color: #f1f1f1}

            .dropdown:hover .dropdown-content {
                display: block;
            }

            .dropdown:hover .dropbtn {
                background-color: #3e8e41;
            }
        </style>
    </head>

    <body>
        <section class="container" style="background-color: transparent;">
            <div class="row">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-body" >
                            <table class="table" id="tblMesas">
                                <thead>
                                    <tr>
                                        <td>
                                            <button class='btn btn-success dropbtn'>Libre</button>
                                        </td>
                                        <td>
                                            <button class='btn btn-danger dropbtn'>Ocupado</button>
                                        </td>
                                        <td>
                                            <button class='btn btn-warning dropbtn'>Reservado</button>
                                        </td>
                                        <td colspan="2">
                                            <a href='Principal.jsp'>
                                                <button class='btn btn-primary dropbtn'>
                                                    Actualizar Pagina
                                                </button>
                                            </a>
                                        </td>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%  //MANDO A LLAMAR EL ARREGLO DE LA CLASE *DAOMESA
                                        ArrayList<Mesas> lista = DaoMesas.obtenerMesasAct();
                                        int salto = 0; // VARIABLE PARA CONROLAR EL CORTE DE LINEA
                                        for (int i = 0; i < lista.size(); i++) {// FOR PARA OBTENER LAS MESAS
                                            Mesas m = lista.get(i);
                                    %>
                                <td>
                                    <div class='dropdown'>
                                        <%
                                            if (m.getEstado().equals("Libre")) {// SI LA MESA ESTA LIBRE, ASIGNO COLOR VERDE
                                        %>
                                        <button style="height: auto;" class='btn btn-success dropbtn'><%=m.getNombre()%></button>
                                        <div class='dropdown-content'>
                                            <a href='pedido.jsp?idMesa=<%=m.getIdMesa()%>'>Pedido</a>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (m.getEstado().equals("Ocupado")) {// SI LA MESA ESTA OCUPADA, ASIGNO COLOR ROJO
%>
                                        <button style="height: auto;" class='btn btn-danger dropbtn'><%=m.getNombre()%></button>
                                        <div class='dropdown-content'>
                                            <a href='pedido.jsp?idMesa=<%=m.getIdMesa()%>'>Pedido</a>
                                            <a target="_blank" href='factura/EstadoCuenta.jsp?idMesa=<%=m.getIdMesa()%>'>Estado Cuenta</a>
                                        </div>
                                        <%
                                            }
                                        %>
                                        <%
                                            if (m.getEstado().equals("Reservado")) {// SI LA MESA ESTA RESERVADA, ASIGNO COLOR AMARILLO
%>
                                        <button style="height: auto;" class='btn btn-warning dropbtn'><%=m.getNombre()%></button>
                                        <div class='dropdown-content'>
                                            <a href='pedido.jsp?idMesa=<%=m.getIdMesa()%>'>Pedido</a>
                                        </div>
                                        <%
                                            }
                                        %>                                        

                                    </div>
                                </td>
                                <%
                                    salto++;
                                    if (salto == 5) {
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
                </div>
            </div>
        </section>

    </body>
</html>
