<%-- 
    Document   : AgregaProveedor
    Created on : 05-21-2018, 04:02:22 PM
    Author     : Ing. Moises Romero Mojica
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletProveedor"%>
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
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <script>
            $(document).ready(function () {
                $("#CtaContable").on("keyup", function () {
                    var value = $(this).val().toLowerCase();
                    if (value === "") {
                        document.getElementById('ListaCntaContable').style.display = 'none';
                    } else {
                        document.getElementById('ListaCntaContable').style.display = 'inline';
                    }
                    $("#ListaCntaContable").filter(function () {
                        $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
                    });
                });
            });
        </script>

        <title>Registrando Nuevo Proveedor</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Registro Nuevo Proveedor</h1>
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Proveedor</a></li>
                <li><a href="#tab-2">Contacto</a></li>
                <li><a href="#tab-3">Datos Contables</a></li>
            </ul>
            <%-- FORMULARIO PARA MANDAR A REGISTRAR UN PROVEEDOR --%>
            <form id="AddProveedor" role='form' action='../ServletProveedor' method='POST'>
                <div id="tab-1"><%-- DIV DE PARAMETROS GENERALES DEL PROVEEDOR --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Proveedor:</strong></span>
                        <input type="text" class="form-control" id="Accion" name="Accion" value="Add" hidden="true">
                        <input id="form-NombreProveedor" name="form-NombreProveedor" type="text" class="form-control col-sm-6" placeholder="Ingresa el Nombre Proveedor..." style="text-align: center" required="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo RUC:</strong></span>
                        <input id="form-CodigoRuc" name="form-CodigoRuc" type="text" class="form-control col-sm-6" placeholder="Ingresa el Codigo Ruc..."  style="text-align: center" required="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Alta</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaIngreso" id="FechaIngreso" style="text-align: center" required="true" readonly="true">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Baja</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaBaja" id="FechaBaja" style="text-align: center" readonly="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Forma de Pago</strong></span>
                        <select class="form-control col-sm-2" id="FormaPago" name="FormaPago" style="text-align: center" required="true">
                            <option>Efectivo</option>
                            <option>Credito</option>
                            <option>Tarjeta</option>
                        </select>
                    </div>                    
                </div><%--FIN DIV DE PARAMETROS GENERALES DEL PROVEEDOR --%>
                <div id="tab-2"> <%-- DIV DE PARAMETROS DE CONTACTO DEL PROVEEDOR --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Direccion</strong></span>
                        <input id="form-Direccion" name="form-Direccion" type="text" class="form-control col-sm-3" maxlength="250" style="text-align: center" placeholder="Escriba la Direccion" required="true">
                        <span class="input-group-addon col-sm-2"><strong>Departamento</strong></span>
                        <input id="form-Departamento" name="form-Departamento" type="text" class="form-control col-sm-2" maxlength="250" style="text-align: center" placeholder="Escriba el Departamento">
                        <span class="input-group-addon col-sm-1"><strong>Tipo</strong></span>
                        <select class="form-control col-sm-1" id="TipoDireccion" name="TipoDireccion" required="true">
                            <option>Casa</option>
                            <option>Oficina</option>
                            <option>Enviar A</option>
                            <option>Facturar A</option>
                        </select>                      
                    </div>                            
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Telefono</strong></span>
                        <input id="form-Telefono" name="form-Telefono" type="tel" class="form-control col-sm-3" style="text-align: center" required="true" placeholder="Digite el Telefono">
                        <span class="input-group-addon col-sm-2"><strong>Extension</strong></span>
                        <input id="form-Extension" name="form-Extension" type="text" class="form-control col-sm-2" style="text-align: center">
                        <span class="input-group-addon col-sm-1"><strong>Tipo</strong></span>                                
                        <select class="form-control col-sm-1" id="TipoTelefono" name="TipoTelefono" required="true">
                            <option>Movil</option>
                            <option>Trabajo</option>
                            <option>Casa</option>
                        </select>                                
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Correo Electronico</strong></span>
                        <input id="form-Email" name="form-Email" type="email" class="form-control col-sm-7" style="text-align: center" placeholder="Escriba un Correo Electronico">
                        <span class="input-group-addon col-sm-1"><strong>Tipo</strong></span>                                
                        <select class="form-control col-sm-1" id="TipoEmail" name="TipoEmail" required="true">
                            <option>Trabajo</option>
                            <option>Personal</option>
                        </select>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-3"><strong>Establecer Como Direccion Principal</strong></span>
                        <select class="form-control col-sm-1" id="Principal" name="Principal" required="true">
                            <option>Si</option>
                            <option>No</option>
                        </select>
                    </div>
                </div><%--FIN DIV DE DATOS DE CONTACTO DEL PROVEEDOR --%>
                <div id="tab-3"> <%-- DIV DE PARAMETROS DE DATOS CONTABLES DEL PROVEEDOR --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-4"><strong>Cuenta Contable</strong></span>
                        <select id="CtaContable" name="CtaContable" class="form-control col-sm-4 chosen-select" required="true">
                            <option value=""></option>	
                            <%
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT IdCatalogo, NumeroCta, Nombre FROM `catalogocuenta` WHERE Activo='SI'";
                                    ResultSet rs = null;
                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    while (rs.next()) {
                                        //out.println("<li class='list-group-item'>" + rs.getString(2) + "-" + rs.getString(3) + "</li>");
                                        out.println("<option value='" + rs.getString(3) + "'>" + rs.getString(3) + "</option>");
                                    }; // fin while 
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
                            %>                        
                        </select>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-4"><strong>Cuenta Contable Descuento</strong></span>
                        <select id="CtaContableDescuento" name="CtaContableDescuento" class="form-control col-sm-4 chosen-select" required="true">
                            <option value=""></option>	
                            <%
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT IdCatalogo, NumeroCta, Nombre FROM `catalogocuenta` WHERE Activo='SI'";
                                    ResultSet rs = null;
                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    while (rs.next()) {
                                        //out.println("<li class='list-group-item'>" + rs.getString(2) + "-" + rs.getString(3) + "</li>");
                                        out.println("<option value='" + rs.getString(3) + "'>" + rs.getString(3) + "</option>");
                                    }; // fin while 
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
                            %>                        
                        </select>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-4"><strong>Cuenta Contable Intereses</strong></span>
                        <select id="CtaContableInteres" name="CtaContableInteres" class="form-control col-sm-4 chosen-select" required="true">
                            <option value=""></option>	
                            <%
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT IdCatalogo, NumeroCta, Nombre FROM `catalogocuenta` WHERE Activo='SI'";
                                    ResultSet rs = null;
                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    while (rs.next()) {
                                        //out.println("<li class='list-group-item'>" + rs.getString(2) + "-" + rs.getString(3) + "</li>");
                                        out.println("<option value='" + rs.getString(3) + "'>" + rs.getString(3) + "</option>");
                                    }; // fin while 
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
                            %>                        
                        </select>
                    </div>
                </div>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type='button' onclick='location.href = "BuscaProveedor.jsp"' class='btn btn-primary'><<< Volver a Busqueda</button>
                        <button type="submit" class="btn btn-primary" id="btnGuardar" name="btnGuardar" >Guardar</button>
                    </div>
                </div>
            </form> <%--FIN FORMULARIO PARA REGISTRAR UN PROVEEDOR--%>
        </div><%--FIN DIV GRUPO DE TABS--%>
        <script type="text/javascript">
            $('#FechaIngreso').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "1950:2018",
                pickTime: true,
                autoclose: true
            });
        </script>      
        <script type="text/javascript">
            $('#FechaBaja').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                pickTime: true,
                autoclose: true
            });
        </script>
    </body>
</html>
