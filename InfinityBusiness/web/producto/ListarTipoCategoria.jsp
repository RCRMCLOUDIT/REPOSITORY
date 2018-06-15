<%-- 
    Document   : ListarTipoCategoria
    Created on : 07-13-2017, 12:42:40 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="model.DaoLogin"%>
<%@page import="model.DaoMarca"%>
<%@page import="controller.ServletTipoCategoria"%>
<%@page import="controller.ServletTipoCategoriaAdd"%>
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
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var Nombre = $('#form-Nombre').val();
                    var Descripcion = $('#form-Descrip').val();
                    $.ajax({
                        type: 'POST',
                        data: {Nombre: Nombre, Descripcion: Descripcion},
                        url: '../ServletTipoCategoriaAdd',
                        success: function (response) {
                            //utilzar response
                            $('#Agregar').modal('hide');
                            location.reload(true);
                        }
                    });
                });
            });
        </script>
        <title>Tipos de Categorias</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaTipoCategorias">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Tipos de Categorias</h3>
                        </div>
                        <div class="panel-heading">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        </div>
                        <div class="panel-body" >
                            <table class="table" id="tblTipoCategorias">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre</th>
                                        <th>Descripcion</th>
                                        <th>Activo?</th>
                                        <th>Acciones</th>
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
                                            String consulta = "SELECT IdTipoCat, Nombre, Descripcion, Activo FROM `tipocategoria`";
                                            ResultSet rs = null;

                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormMarca' role='form' action='../ServletTipoCategoria'"
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
                                                        + "<input type='text' class='form-control' style='width: auto' id='TipoCat' name='form-Nombre' value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Descripcion' name='form-Descrip' value='" + rs.getString(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='Activo' name='form-Activo' readonly value='" + rs.getString(4) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<button type='submit' class='btn btn-primary'>Editar</button>"
                                                        + "</form>"
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
        <%--VENTANA MODAL PARA AGREGAR UN NUEVO TIPO DE CATEGORIA --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar Tipo Categoria</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormMarca" role="form" action="ServletTipoCategoriaAdd" method="POST" class="form-control">
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

    <%-- VENTANA MODAL PARA EDITAR TIPO DE CATEGORIA --%>
    <%-- REVISAR PARA MAS ADELANTE OPTIMIZAR, COMO PASAR LOS DATOS DESDE LA TABLA AL MODAL
            POR EL MOMENTO ESTA DESACTIVADO, SE MODIFICA DIRECTAMENTE DESDE LA TABLA
    <center>
    <%-- <button class="btn btn-info" data-toggle="modal" data-target="#Editar">Editar</button>
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
FIN DE VENTA MODAL
    --%>
</body>
</html>