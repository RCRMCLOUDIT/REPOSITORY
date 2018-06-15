<%-- 
    Document   : ReservaHabitacion
    Created on : 12-12-2017, 12:06:37 PM
    Author     : Ing. Moises Romero Mojica
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
 
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
            $(document).ready(function () {
                $('#btnVerficar').click(function () {
                    var IdTipoHab = $('#form-TipoHab').val();
                    var FechaIN = $('#FechaIN').val();
                    var FechaOUT = $('#FechaOUT').val();
                    var Accion = "CheckHabDispo";
                    if ($('#form-TipoHab').val() === "") {
                        alert("Seleccionar Tipo Habitacion");
                        $('#form-TipoHab').focus();
                    } else if ($('#FechaIN').val() === "") {
                        alert("Seleccionar Fecha Llegada");
                        $('#FechaIN').focus();
                    } else if ($('#FechaOUT').val() === "") {
                        alert("Seleccionar Fecha Salida");
                        $('#FechaOUT').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {IdTipoHab: IdTipoHab, FechaIN: FechaIN, FechaOUT: FechaOUT, Accion: Accion},
                            url: '../ServletReservas',
                            success: function (response) {
                                //utilzar response

                            }
                        });
                    }
                });
            });
        </script>
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Reserva Habitacion</title>
    </head>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Realizando Reserva Habitacion</h1>                
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Reserva</a></li>
                <li><a href="#tab-2">Datos Habitacion</a></li>
            </ul>
            <%-- FORMULARIO PARA MANDAR A GUARDAR LOS DATOS DE LA RESERVA --%>
            <form id="AddReservaHab" role='form' action='../ServletReservas' method='POST'>
                <div id="tab-1"><%-- DIV PARA EL CONTROL DE DATOS DE LAS ESPECIFICACIONES DE LA HABITACION --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Llegada</strong></span>                        
                        <input type="text" class="form-control col-sm-2" name="FechaIN" id="FechaIN" readonly="true" required="true" size="50" style="text-align: center">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Salida</strong></span>                        
                        <input type="text" class="form-control col-sm-2" name="FechaOUT" id="FechaOUT" readonly="true" required="true" size="50" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Tipo Habitacion</strong></span>
                        <select class="form-control col-sm-6" id="form-TipoHab" name="form-TipoHab" style="text-align: center">
                            <%  // declarando y creando objetos globales 
                                // construyendo forma dinamica 
                                // mandando el sql a la base de datos 
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT IdTipoHab, Nombre, MaxPersonas FROM `tipohab` WHERE Activo='SI'";
                                    ResultSet rs = null;
                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    while (rs.next()) {
                                        out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + " | Maximo Personas: " + rs.getInt(3) + "</option>");
                                    }; // fin while 
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
                            %>
                        </select>
                        <button class="btn btn-primary" id="btnVerficar" name="btnVerificar" type="button" hidden="true">Verificar Disponibilidad</button>
                    </div>
                </div><%--FIN DIV PARA EL CONTROL DE DATOS DE LAS ESPECIFICACIONES DE LA HABITACION --%>
                <div id="tab-2"><%-- DIV PARA EL CONTROL DEL DATOS DEL CLIENTE QUE ESTA RESERVANDO --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Cliente:</strong></span>
                        <input id="form-NombreReserva" name="form-NombreReserva" type="text" class="form-control col-sm-6" placeholder="Ingresa el Nombre Cliente..." required="true" style="text-align: center">
                        <%--PARAMETRO PARA LA ACCION A EJECUTAR EN EL SERVLET--%>
                        <input type="text" class="form-control" id="form-Accion" name="form-Accion" value="AddResvHab" readonly="true" hidden="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Adultos</strong></span>
                        <input id="form-Adultos" name="form-Adultos" type="number" class="form-control col-sm-6" required="true" value="0" min="0" max="10" style="text-align: center">
                    </div>   
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Niños</strong></span>
                        <input id="form-Ninos" name="form-Ninos" type="number" class="form-control col-sm-6" required="true" value="0" min="0" max="10" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Comentarios</strong></span>
                        <input type="text" class="form-control col-sm-6" name="Cometarios" id="Cometarios" maxlength="100" placeholder="Si desea solicitar algo extra....." style="text-align: center">
                    </div>
                </div><%-- FIN DIV PARA EL CONTROL DE DATOS DEL CLIENTE QUE ESTA RESERVANDO --%>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type='button' onclick='history.go(-1);
                                return false;' class='btn btn-primary'><< Volver</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                    </div>
                </div>
            </form> <%--FIN FORMULARIO PARA EL ENVIO DE DATOS A LA RESERVA--%>
        </div><%--FIN DIV GRUPO DE TABS--%>

        <script type="text/javascript">
            $('#FechaIN').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                minDate: 0,
                autoclose: true
            });
        </script>
        <script type="text/javascript">
            $('#FechaOUT').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                minDate: 0,
                yearRange: "2018:2050",
                autoclose: true
            });
        </script>
    </body>
</html>
