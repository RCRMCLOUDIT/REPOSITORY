<%-- 
    Document   : TipoUnidad
    Created on : 10-18-2016, 11:49:21 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletUnidadMedida"%>
<%@page import="controller.ServletUnidadMedidaAdd"%>
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
                    var nombre = $('#form-Unidad').val();
                    var simbolo = $('#form-Simbolo').val();
                    var codigoIso = $('#form-codigoISO').val();
                    var tipoUnid = $('#form-TipoUnid').val();
                    $.ajax({
                        type: 'POST',
                        data: {Unidad: nombre, Simbolo: simbolo, CodigoISO: codigoIso, Tipo: tipoUnid},
                        url: '../ServletUnidadMedidaAdd',
                        success: function (response) {
                            //utilzar response
                            $('#Agregar').modal('hide');
                            location.reload(true);
                        }
                    });
                });
            });
        </script>
        <title>Unidad de Medida</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListarUnidades">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Unidades de Medidas</h3>
                        </div>
                        <div class="panel-heading">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        </div>
                        <div class="panel-body" >
                            <table class="table" id="tblUnidades">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Nombre</th>
                                        <th>Simbolo</th>
                                        <th>CodigoISO</th>
                                        <th>Tipo Unidad</th>
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
                                            String consulta = "SELECT IdUnidad, Nombre, Simbolo, CodigoISO, Tipo, Activo FROM `tipounidad`";
                                            ResultSet rs = null;

                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormMarca' role='form' action='../ServletUnidadMedida'"
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
                                                        + "<input type='text' class='form-control' style='width: auto' id='form-Nombre' name='form-Nombre' value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='Simbolo' name='form-Simbolo' value='" + rs.getString(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='CodigoISO' name='form-CodigoISO' value='" + rs.getString(4) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='Tipo' name='form-Tipo' readonly value='" + rs.getString(5) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='Activo' name='form-Activo' readonly value='" + rs.getString(6) + "'>"
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
        <%--VENTANA MODAL PARA AGREGAR UNA NUEVA UNIDAD DE MEDIDA --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar Unidad de Medida</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormUnidad" role="form" action="ServletUnidadMedidaAdd" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Nombre">Nombre</label>
                                <input type="text" class="form-control" id="form-Unidad" name="form-Unidad" placeholder="Nombre...">   
                            </div>
                            <div class="form-control">
                                <label for="Simbolo">Simbolo</label>
                                <input type="text" class="form-control" id="form-Simbolo" name="form-Simbolo" placeholder="Simbolo...">   
                            </div>
                            <div class="form-control">
                                <label for="codigoISO">CodigoISO</label>
                                <input type="text" class="form-control" id="form-codigoISO" name="form-codigoISO" placeholder="CodigoISO...">   
                            </div>                            
                            <div class="form-control">
                                <label for="producto">Selecciona Tipo Unidad:</label>
                                <select class="form-control" id="form-TipoUnid" name="form-TipoUnid">
                                    <option>Seleccione....</option>
                                    <option>Unidad</option>                                    
                                    <option>Longitud</option>
                                    <option>Volumen</option>
                                    <option>Masa</option>
                                </select>
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
</body>
</html>
