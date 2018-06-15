<%-- 
    Document   : CatalogoContable
    Created on : 08-23-2017, 08:12:36 PM
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
            // FUNCION PARA MOSTRAR O OCULTAR, LAS CUENTAS, EN CASO DE QUE LA NUEVA CUENTA VAYA A SER UNA SUB-CUENTA
            $(document).ready(function () {
                $('#form-AddSub').click(function () {
                    element = document.getElementById("form-Catalogo");
                    var mostrar = $('#form-AddSub').is(":checked");
                    if (mostrar === true) {
                        element.style.display = 'inline';
                        //alert("Mostrando Cuentas");
                    } else {
                        element.style.display = 'none';
                        //alert("Oculto Cuentas");
                    }
                });
            });
        </script>

        <script type="text/javascript">
            // FUNCION PARA MANDAR LOS DATOS AL SERVLET Y AGREGAR LA CUENTA AL CATALOGO CONTABLE
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var IdTipoCta = $('#form-TipoCuentaAdd').val();
                    var NumeroCta = $('#form-AddNumero').val();
                    var NombreCta = $('#form-AddNombre').val();
                    if ($('#form-AddSub').is(":checked")) {
                        var SubCta = $('#form-Catalogo').val();
                    }else{
                        var SubCta = "";
                    }
                    var Descripcion = $('#form-AddDescripcion').val();
                    if ($('#form-TipoCuentaAdd').val() === "") {
                        alert("Revisar Tipo de Cta, Campo Vacio");
                        $('#form-TipoCuentaAdd').focus();
                    } else if ($('#form-AddNumero').val() === "") {
                        alert("Revisar Numero de Cta, Campo Vacio");
                        $('#form-AddNumero').focus();
                    } else if ($('#form-AddNombre').val() === "") {
                        alert("Revisar Nombre de Cta, Campo Vacio");
                        $('#form-AddNombre').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {IdTipoCta: IdTipoCta, NumeroCta: NumeroCta, NombreCta: NombreCta, SubCta: SubCta, Descripcion: Descripcion},
                            url: '../ServletContabilidad',
                            success: function (response) {
                                //utilzar response
                                $('#Agregar').modal('hide');
                                location.reload(true);
                            }
                        });
                        //alert("IdTipoCuenta: " + IdTipoCta + " Numero " + NumeroCta + " Nombre " + NombreCta + " Sub-Cuenta Seleccionada: " + SubCta);
                    }
                });
            });
        </script>

        <title>Catalogo Contable</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <section id="lista" class="container">
            <div class="row" id="CatalogoContable">
                <div  class="col-sm-8">
                    <div class="panel-default">
                        <div class="panel-title">
                            <h3 class="panel-title">Catalogo Contable</h3>
                        </div>
                        <form id="FormCatalagoContable" role="form" action="#">
                            <div class="input-group">
                                <span class="input-group-addon">Cuenta: <Span style="color: red; ">*</span> </span>
                                <input id="filtro" name="filtro" type="text" value='' class="form-control" placeholder="Ingresa Cta a  Buscar..." required="true">
                                <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                            </div>
                            <br>
                        </form>
                        <button class="btn btn-primary" data-toggle="modal" data-target="#Agregar">Agregar</button>
                        <div class="panel-body" >
                            <table class="table" id="tblCatalogoCta">
                                <thead>
                                    <tr>
                                        <th>Id</th>
                                        <th>Numero de Cta</th>                      
                                        <th>Nombre de Cta</th>
                                        <th>Tipo de Cta</th>
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
                                            String consulta = "SELECT catalogocuenta.IdCatalogo, catalogocuenta.NumeroCta, catalogocuenta.Nombre, tipocuenta.Nombre FROM `catalogocuenta` INNER JOIN `tipocuenta` ON catalogocuenta.IdTipoCuenta = tipocuenta.IdTipoCuenta ORDER BY catalogocuenta.NumeroCta";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();

                                            while (rs.next()) {

                                                out.println("<TR>");

                                                out.println("<TD style='display:none;'>"
                                                        + "<div class='myform-bottom'>"
                                                        + "<form id='FormCatalogoContable' role='form' action='../ServletContabilidad'"
                                                        + "method='POST' class='form-control'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 60px' id='IdCatalogo' name='form-idTipo' readonly value='" + rs.getInt(1) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: 100px' id='NumeroCta' name='form-CodigoCuenta' readonly value='" + rs.getString(2) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='NombreCta' name='form-NombreCuenta' readonly value='" + rs.getString(3) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<div class='form-control'>"
                                                        + "<input type='text' class='form-control' style='width: auto' id='TipoCta' name='form-Tipo' readonly value='" + rs.getString(4) + "'>"
                                                        + "</div>"
                                                        + "</TD>");

                                                out.println("<TD>"
                                                        + "<button type='button' class='btn btn-primary'>Editar</button>"
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

        <%--VENTANA MODAL PARA AGREGAR UNA NUEVA CUENTA AL CATALOGO --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregar Cuenta Contable</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormAddTipoCuenta" role="form" action="ServletContabilidad" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="Codigo">Tipo de Cuenta<Span style="color: red; ">*</span></label>
                                <select  id="form-TipoCuentaAdd" name="form-TipoCuentaAdd">
                                    <% // declarando y creando objetos globales 
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "Select IdTipoCuenta, Tipo, Nombre From `tipocuenta`";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(3) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>  
                            <div class="form-control">
                                <label for="Codigo">Numero Cuenta<Span style="color: red; ">*</ span></label>
                                <input type="text" class="form-control" id="form-AddNumero" name="form-AddNumero" placeholder="Numero de Cuenta..." required="true">   
                            </div>
                            <div class="form-control">
                                <label for="Nombre">Nombre Cuenta<Span style="color: red; ">*</ span></label>
                                <input type="text" class="form-control" id="form-AddNombre" name="form-AddNombre" placeholder="Nombre de Cuenta..." required="true">   
                            </div>
                            <div class="checkbox-inline">
                                <label>
                                    Sub-Cuenta<input type="checkbox" id="form-AddSub" name="form-AddSub">
                                </label>
                                <select  id="form-Catalogo" name="form-Catalogo" style="display: none">
                                    <%  try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT IdCatalogo, Nombre FROM `catalogocuenta` WHERE Activo='SI'  ORDER BY `NumCtaXNivel` ASC";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>                
                            <div class="form-control">
                                <label for="Descripcion">Descripcion Cuenta</label>
                                <textarea type="text" class="form-control" id="form-AddDescripcion" name="form-AddDescripcion" placeholder="Desscripcion de Cuenta..." rows="2"></textarea>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Agregar</button>
                    </div>
                </div>
            </div>
        </div>
    </center> 
</body>
</html>
