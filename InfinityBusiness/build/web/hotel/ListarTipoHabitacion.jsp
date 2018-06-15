<%-- 
    Document   : ListarTipoHabitacion
    Created on : 09-12-2017, 09:54:04 PM
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
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var Nombre = $('#form-AddNombre').val();
                    var Descripcion = $('#form-AddDescripcion').val();
                    var Precio = $('#form-AddPrecio').val();
                    var Accion = "Add";

                    if ($('#form-AddNombre').val() === "") {
                        alert("Revisar Nombre, Ingrese un nombre");
                        $('#form-AddNombre').focus();
                    } else if ($('#form-AddPrecio').val() === "") {
                        alert("Revisar Precio, Ingrese un Precio");
                        $('#form-AddPrecio').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {Nombre: Nombre, Descripcion: Descripcion, Precio: Precio, Accion: Accion},
                            url: '../ServletTipoHabitacion',
                            success: function (response) {
                                //utilzar response
                                $('#Agregar').modal('hide');
                                 location.reload(true);
                            }
                        });
                    }
                });
            });
        </script>
        <title>Tipo de Habitaciones</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaTipoCuentas">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Listado de Tipos de Habitaciones</h3>
                        </div>
                        <div class="panel-heading">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        </div>
                        <div class="panel-body" >
                            <table class="table" id="tblTipoCuentas">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;">Id</th>
                                        <th style="text-align: center;">Tipo de Habitacion</th>                      
                                        <th style="text-align: center;">Descripcion</th>
                                        <th style="text-align: center;">Precio</th>
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
                                            String consulta = "SELECT IdTipoHab, Nombre, Descripcion, Precio FROM `tipohab`";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormMarca' role='form' action='../ServletTipoHabitacion'"
                                                        + "method='POST' class='form-control'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='idTipoHab' name='form-idTipoHab' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Nombre' name='form-Nombre' readonly value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Descripcion' name='form-Descripcion' readonly value='" + rs.getString(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='number' class='form-control' style='width: auto' id='Precio' name='form-Precio' readonly value='" + rs.getDouble(4) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<button type='button' data-id='" + rs.getInt(1) + "' data-toggle='modal' data-target='#Update' class='btn btn-primary'>Editar</button>"
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
        </div>
    </section>

    <%--VENTANA MODAL PARA AGREGAR UN NUEVO TIPO DE HABITACION --%>
<center>
    <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4>Agregar Tipo Habitacion</h4>
                </div>
                <div class="modal-body">
                    <form id="FormAddTipoHabitacion" role="form" action="ServletTipoHabitacion" method="POST" class="form-control">
                        <div class="form-control">
                            <label for="Nombre">Nombre<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-AddNombre" name="form-AddNombre" placeholder="Nombre..." required="true">   
                        </div>                        
                        <div class="form-control">
                            <label for="Descripcion">Descripcion</label>
                            <textarea type="text" class="form-control" id="form-AddDescripcion" name="form-AddDescripcion" placeholder="Desscripcion..." rows="2"></textarea>
                        </div>
                        <div class="form-control">
                            <label for="Precio">Precio</label>
                            <input type="number" class="form-control" id="form-AddPrecio" name="form-AddPrecio" placeholder="Precio...">   
                        </div>    
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="btnCerrar" type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btnAgregar" >Agregar</button>
                </div>
            </div>
        </div>
    </div>
</center> 
<%--FIN DE VENTANA MODAL PARA AGREGAR UN NUEVO TIPO DE HABITACION --%>

</body>
</html>
