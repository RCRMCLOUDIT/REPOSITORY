<%-- 
    Document   : ListarMarca
    Created on : 07-10-2017, 05:15:07 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="model.DaoLogin"%>
<%@page import="model.DaoMarca"%>
<%@page import="controller.ServletMarca"%>
<%@page import="controller.ServletMarcaAdd"%>
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
                    var Nombre = $('#form-Nombre').val();
                    var Descripcion = $('#form-Descrip').val();
                    $.ajax({
                        type: 'POST',
                        data: {Nombre: Nombre, Descripcion: Descripcion},
                        url: '../ServletMarcaAdd',
                        success: function (response) {
                            //utilzar response
                            $('#Agregar').modal('hide');
                            location.reload(true);
                        }
                    });
                });
            });
        </script>
        <title>Listado de Marcas</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Marcas</h1>                
            </center>
        </div>
        <section id="lista" class="container">
            <div class="row" id="ListaMarca">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div id="BuscarCliente">
                            <form id="FormBuscarCliente" role="form" action="BuscarReserva.jsp">
                                <div class="input-group">
                                    <span class="input-group-addon">Marca:</span>
                                    <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                                    <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                                    <a href="#" class="btn btn-primary">Agregar</a>
                                </div>
                            </form>
                        </div>
                        <div class="panel-body" >
                            <table class="table table-hover" id="tblCategorias">
                                <thead style="background-color: #4682B4">
                                    <tr>
                                        <th style="color: #FFFFFF; text-align: center;">Id</th>
                                        <th style="color: #FFFFFF; text-align: center;">Nombre</th>
                                        <th style="color: #FFFFFF; text-align: center;">Descripcion</th>
                                        <th style="color: #FFFFFF; text-align: center;">Activo?</th>
                                        <th style="color: #FFFFFF; text-align: center;">Acciones</th>
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
                                            String consulta = "SELECT IdMarca, Nombre, Descripcion, Activo FROM `marca`";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<TR>");
                                                out.println("<TD style='color: #000000;'>" + rs.getInt(1) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                out.println("<TD>"
                                                        + "<a href='?=" + rs.getInt(1) + " ' class='btn btn-primary'>Editar</a>"
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
            </div>
        </section>
        <%--VENTANA MODAL PARA AGREGAR UNA NUEVA MARCA --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar una Marca</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormMarca" role="form" action="ServletMarcaAdd" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Nombre">Nombre Marca</label>
                                <input type="text" class="form-control" id="form-Nombre" name="form-Nombre" placeholder="Nombre...">   
                            </div>
                            <div class="form-control">
                                <label for="Descripcion">Descripcion</label>
                                <input type="text" class="form-control" id="form-Descrip" name="form-Descrip" placeholder="Descripcion...">   
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

    <%-- VENTANA MODAL PARA EDITAR UNA MARCA --%>
    <center>
        <%-- <button class="btn btn-info" data-toggle="modal" data-target="#Editar">Editar</button> --%>
        <div class="modal fade" id="Editar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Editando Marca</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormMarca" role="form" action="ServletMarca" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Nombre">Nombre Marca</label>
                                <input type="text" class="form-control" id="IdEdit" placeholder="Id...">
                                <input type="text" class="form-control" id="NombreEdit" placeholder="Nombre...">
                            </div>
                            <div class="form-control">
                                <label for="Descripcion">Descripcion</label>
                                <input type="text" class="form-control" id="DescripcionEdit" placeholder="Descripcion...">   
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnActualizar" >Actualizar</button>
                    </div>
                </div>
            </div>
        </div>
    </center> 
</body>
</html>
