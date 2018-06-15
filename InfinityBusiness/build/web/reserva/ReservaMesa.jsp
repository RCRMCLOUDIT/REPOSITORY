<%-- 
    Document   : ReservaMesa
    Created on : 02-12-2018, 06:12:56 PM
    Author     : Ing. Moises Romero Mojica
--%>

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
        <title>Reserva Mesa</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Realizando Reserva Mesa</h1>                
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Reserva</a></li>
            </ul>
            <%-- FORMULARIO PARA MANDAR A GUARDAR LOS DATOS DE LA RESERVA --%>
            <form id="AddReservaMesa" role='form' action='../ServletReservas' method='POST'>
                <div id="tab-1"><%-- DIV PARA EL CONTROL DE DATOS DE LAS RESERVA --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Cliente:</strong></span>
                        <input id="form-NombreReserva" name="form-NombreReserva" type="text" class="form-control col-sm-6" placeholder="Ingresa el Nombre Cliente..." required="true" style="text-align: center">
                        <%--PARAMETRO PARA LA ACCION A EJECUTAR EN EL SERVLET--%>
                        <input type="text" class="form-control" id="form-Accion" name="form-Accion" value="AddResvMesa" readonly="true" hidden="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Personas:</strong></span>
                        <input id="form-Personas" name="form-Personas" type="number" class="form-control col-sm-6" required="true" value="0" min="1" max="99" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha:</strong></span>                        
                        <input type="text" class="form-control col-sm-2" name="Fecha" id="Fecha" readonly="true" required="true" size="50" style="text-align: center">
                        <span class="input-group-addon col-sm-2"><strong>Hora:</strong></span>                        
                        <input type="time" class="form-control col-sm-2" name="Hora" id="Hora" required="true" size="50" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Comentarios</strong></span>
                        <input type="text" class="form-control col-sm-6" name="Cometarios" id="Cometarios" maxlength="100" placeholder="Si desea solicitar algo extra....." style="text-align: center">
                    </div>
                </div><%--FIN DIV PARA EL CONTROL DE DATOS DE LA RESERVA --%>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type='button' onclick='history.go(-1);return false;' class='btn btn-primary'><< Volver</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                    </div>
                </div>
            </form> <%--FIN FORMULARIO PARA EL ENVIO DE DATOS A LA RESERVA--%>
        </div><%--FIN DIV GRUPO DE TABS--%>
        <script type="text/javascript">
            $('#Fecha').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                minDate: 0,
                pickTime: true,
                autoclose: true
            });
        </script>
        <script type="text/javascript">
            $('#Hora').timepicker();
        </script>
    </body>
</html>
