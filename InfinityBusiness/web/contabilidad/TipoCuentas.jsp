<%-- 
    Document   : TipoCuentas
    Created on : 08-23-2017, 08:11:51 PM
    Author     : Moises Romero
--%>
<%@page import="model.DaoContabilidad"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int IdTipoCuenta = 0;
    int CodCuenta = 0;
    String Tipo = "", Nombre = "";
%>
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
            //ESTE SCRIPT ME SERVIRA PARA LIMPIAR LOS DATOS DE LAS VENTANAS MODALES.
            // BUSCAR MEJORA MAS ADELANTE, PARA NO TENER QUE REFRESCAR LA PAGINA
            $(document).ready(function (e) {
                $('#Update').on('hide.bs.modal', function (e) {
                    location.reload(true);
                });
                $('#Agregar').on('hide.bs.modal', function (e) {
                    location.reload(true);
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var Codigo = $('#form-AddCodigo').val();
                    var Clase = $('#form-AddClase').val();
                    var Nombre = $('#form-AddNombre').val();

                    if ($('#form-AddCodigo').val() === "") {
                        alert("Revisar Codigo Tipo Cta, Campo Vacio");
                        $('#form-AddCodigo').focus();
                    } else if ($('#form-AddClase').val() === "Seleccionar") {
                        alert("Revisar Clase de Tipo de Cta, Seleccione un Tipo");
                        $('#form-AddClase').focus();
                    } else if ($('#form-AddNombre').val() === "") {
                        alert("Revisar Nombre de Tipo de Cta, Campo Vacio");
                        $('#form-AddNombre').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {Codigo: Codigo, Clase: Clase, Nombre: Nombre},
                            url: '../ServletTipoCuentaAdd',
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
        <script>
            $(document).ready(function (e) {
                $(e.currentTarget).find('#form-Id').val(0);
                IdTipoCuenta = 0;
                $('#Update').on('show.bs.modal', function (e) {
                    var IdCod = $(e.relatedTarget).data().id;
                    IdTipoCuenta = $(e.relatedTarget).data().id;
                    $(e.currentTarget).find('#form-Id').val(IdCod);
                });
            });
        </script>
        <title>Tipos de Cuentas</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="ListaTipoCuentas">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Listado de Tipos de Cuentas Contables</h3>
                        </div>
                        <div class="panel-heading">
                            <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        </div>
                        <div class="panel-body" >
                            <table class="table" id="tblTipoCuentas">
                                <thead>
                                    <tr>
                                        <th style="text-align: center;">Id</th>
                                        <th style="text-align: center;">Codigo de Tipos de Cuenta</th>                      
                                        <th style="text-align: center;">Nombre de Tipos de Ctas</th>
                                        <th style="text-align: center;">Clase Tipo de Cuentas</th>
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
                                            String consulta = "SELECT IdTipoCuenta, CodigoTipoCuenta, Nombre, Tipo FROM `tipocuenta`";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormMarca' role='form' action='../ServletTipoCuentaAdd'"
                                                        + "method='POST' class='form-control'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='idTipo' name='form-idTipo' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='CodigoCuenta' name='form-CodigoCuenta' readonly value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 300px' id='NombreCuenta' name='form-NombreCuenta' readonly value='" + rs.getString(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='Tipo' name='form-Tipo' readonly value='" + rs.getString(4) + "'>"
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
    <%--VENTANA MODAL PARA AGREGAR UN NUEVO TIPO DE CUENTA --%>
<center>
    <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4>Agregar Tipo Cuenta Contable</h4>
                </div>
                <div class="modal-body">
                    <form id="FormAddTipoCuenta" role="form" action="ServletTipoCuentaAdd" method="POST" class="form-control">
                        <div class="form-control">
                            <label for="Codigo">Codigo de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-AddCodigo" name="form-AddCodigo" placeholder="Codigo de Tipo de Cta..." required="true">   
                        </div>
                        <div class="form-control">
                            <label for="Clase">Clase de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <select class="form-control" id="form-AddClase" name="form-AddClase">
                                <option>Seleccionar</option>
                                <option>Activo</option>
                                <option>Pasivo</option>
                                <option>Capital</option>
                                <option>Ingresos</option>                                    
                                <option>Gastos</option>
                            </select>
                        </div>                            
                        <div class="form-control">
                            <label for="Nombre">Nombre de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-AddNombre" name="form-AddNombre" placeholder="Nombre de Tipo de Cta..." required="true">   
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
<%--FIN DE VENTANA MODAL PARA AGREGAR UN NUEVO TIPO DE CUENTA --%>

<%--VENTANA MODAL PARA ACTUALIZAR TIPO DE CUENTA --%>
<center>
    <div class="modal fade" id="Update" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                    <h4>Actualizar Tipo Cuenta Contable</h4>
                </div>
                <div class="modal-body">
                    <form id="FormAddTipoCuenta" role="form" action="ServletTipoCuentaAdd" method="POST" class="form-control">
                        <div class="form-control" style="">
                            <label for="Codigo">Id</label>
                            <input type="text" class="form-control" id="form-Id" name="form-Id" required="true">   
                        </div>
                        <div class="form-control">
                            <label for="Nombre">Codigo de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-UpdateCodigo" name="form-UpdateCodigo">   
                        </div>
                        <div class="form-control">
                            <label for="Nombre">Clase de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-UpdateTipo" name="form-UpdateTipo">
                        </div>
                        <div class="form-control">
                            <label for="Nombre">Nombre de Tipo de Cta<Span style="color: red; ">*</ span></label>
                            <input type="text" class="form-control" id="form-UpdateNombre" name="form-UpdateNombre">   
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                    <button id="btnCerrar" name="btnCerrar" type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                    <button type="button" class="btn btn-primary" id="btnUpdate" >Guardar</button>
                </div>
            </div>
        </div>
    </div>
</center> 
<%--FIN DE VENTANA MODAL PARA ACTUALIZAR TIPO DE CUENTA --%>
</body>
</html>
