<%-- 
    Document   : ListadoClientes
    Created on : 07-28-2017, 02:59:25 AM
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
        <title>Lista de Clientes</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Clientes</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaEmpleados">
                <div class="panel-default">
                    <form id="FormBuscar" role="form" action="BuscarCliente.jsp">
                        <div class="input-group">
                            <span class="input-group-addon">Nombre:</span>
                            <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                            <input id="QuienLlama" name="QuienLlama" type="text" value='ListadoCliente' class="form-control col-sm-2" hidden="true">
                            <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                            <%--  <a class='btn btn-primary' href='AddCliente.jsp'>Agregar Nuevo Cliente</a> --%>
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar Nuevo Cliente</button>
                        </div>
                    </form>
                    <div class="panel-body" >
                        <table class="table table-responsive" id="tblCliente">
                            <thead style="background-color: #4682B4">
                                <tr>
                                    <th style="color: #FFFFFF; text-align: center;">Id</th>
                                    <th style="color: #FFFFFF; text-align: center;">Nombre</th>                      
                                    <th style="color: #FFFFFF; text-align: center;">Cedula</th>
                                    <th style="color: #FFFFFF; text-align: center;">Telefono</th>
                                    <th style="color: #FFFFFF; text-align: center;">Direccion</th>
                                    <th style="color: #FFFFFF; text-align: center;">Acciones</th>
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
                                        ResultSet rs = null;
                                        PreparedStatement pst = null;
                                        pst = conn.conexion.prepareStatement("SELECT IdCliente, CONCAT(Nombre,' ',Apellido) AS Cliente, DNI, Telefono, Direccion FROM `cliente`");
                                        rs = pst.executeQuery();

                                        while (rs.next()) {
                                            out.println("<TR>");

                                            out.println("<TD>"
                                                    + "<input type='text' class='form-control' style='width: 60px' id='IdEmp' name='form-id' readonly value='" + rs.getInt(1) + "'>"
                                                    + "</TD>");

                                            out.println("<TD>"
                                                    + "<input type='text' class='form-control' style='width: 300px' id='Cliente' name='form-Cliente' readonly value='" + rs.getString(2) + "'>"
                                                    + "</TD>");

                                            out.println("<TD>"
                                                    + "<input type='text' class='form-control' style='width: 150px' id='DNI' name='form-DNI' readonly value='" + rs.getString(3) + "'>"
                                                    + "</TD>");

                                            out.println("<TD>"
                                                    + "<input type='text' class='form-control' style='width: 110px' id='Telefono' name='form-Telefono' readonly value='" + rs.getString(4) + "'>"
                                                    + "</TD>");

                                            out.println("<TD>"
                                                    + "<input type='text' class='form-control' style='width: auto' id='Direccion' name='form-Direccion' readonly value='" + rs.getString(5) + "'>"
                                                    + "</TD>");

                                            out.println("<TD>"
                                                    + "<a href='UpdateCliente.jsp?idCli=" + rs.getInt(1) + "' class='btn btn-primary'>Editar ó Ver</a>"
                                                    + "</TD>");

                                            out.println("</TR>");
                                        }; // fin while 
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
        </section>
        <%--VENTANA MODAL PARA AGREGAR UN NUEVO CLIENTE --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4682B4">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true" style="color: red;">&times;</button>
                        <center>
                            <h3 style="color: #FFFFFF; text-align: center;">Agregando Nuevo Cliente</h3>                
                        </center>
                    </div>
                    <div class="modal-body">
                        <form id="FormCliente" role="form" action="../ServletCliente" method="POST">
                            <div class="form-control">
                                <label for="AddProd">Nombre<span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="form-Nombre" name="form-Nombre" required="true" placeholder="Nombre...">   
                            </div>
                            <div class="form-control">
                                <label for="Apellido">Apellido<span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="form-Apellido" name="form-Apellido" required="true" placeholder="Apellido...">   
                            </div>                            
                            <div class="form-control">
                                <label for="RUC">Cedula<span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="form-Cedula" name="form-Cedula" required="true" placeholder="# Cedula...">   
                            </div>                            
                            <div class="form-control">
                                <label for="RUC">RUC #</label>
                                <input type="text" class="form-control" id="form-Ruc" name="form-Ruc" placeholder="# RUC...">   
                            </div>
                            <div class="form-control">
                                <label for="Genero">Selecciona Genero:<span style="color: red;">*</span></label>
                                <select class="form-control" name="form-Sexo" id="form-Sexo">
                                    <option value="1">Selecciona...</option>
                                    <option value="M">Masculino</option>
                                    <option value="F">Femenino</option>
                                </select>
                            </div>
                            <div class="form-control">
                                <label for="Direccion">Direccion<span style="color: red;">*</span></label>
                                <input type="text" class="form-control" id="form-Direccion" name="form-Direccion" required="true" placeholder="Direccion..." maxlength="100">   
                            </div>
                            <div class="form-control">
                                <label for="Telefono">Telefono<span style="color: red;">*</span></label>
                                <input type="tel" class="form-control" id="form-Telefono" name="form-Telefono" required="true" placeholder="Telefono...">   
                            </div>                            
                            <div class="form-control">
                                <label for="Telefono">Telefono</label>
                                <input type="tel" class="form-control" id="form-Telefono" name="form-Telefono" required="true" placeholder="Telefono...">   
                            </div>                            
                            <div class="form-control">
                                <label for="Movil">Movil</label>
                                <input type="tel" class="form-control" id="form-Movil" name="form-Movil" required="true" placeholder="Movil...">   
                            </div>                            
                            <div class="form-control">
                                <label for="Email">Email</label>
                                <input type="email" class="form-control" id="form-Email" name="form-Email" required="true" placeholder="Email...">   
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
    </center><%--FIN VENTANA MODAL PARA AGREGAR UN NUEVO CLIENTE --%>
</body>
</html>
