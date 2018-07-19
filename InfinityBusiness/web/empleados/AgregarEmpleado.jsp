<%-- 
    Document   : AgregarEmpleado
    Created on : 05-15-2018, 01:50:40 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="java.sql.Date"%>
<%@page import="model.DaoLogin"%>
<%@page import="controller.ServletEmpleado"%>
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
        <%-- SCRIPT PARA VALIDAR ALGUNOS INPUTS QUE SOLO SEAN NUMEROS --%>
        <%-- COMO EL CASO DE TELEFONO Y CELULAR --%>
        <script>
            function valida(e) {
                tecla = (document.all) ? e.keyCode : e.which;
                //Tecla de retroceso para borrar y la tecla TAB, siempre la permite
                if (tecla == 8 || e.keysCode == keys.Tab) {
                    return true;
                }
                // Patron de entrada, en este caso solo acepta numeros
                patron = /[0-9]/;
                tecla_final = String.fromCharCode(tecla);
                return patron.test(tecla_final);
            }
        </script>
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>        
        <script>
            $(function () {
                $("#grupoTablas2").tabs();
            });
        </script>
        <title>Agregar Empleado</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Agregando Nuevo Empleado</h1>                
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <form id="AddEmpleado" role='form' action='../ServletEmpleado' method='POST'>
                <ul  style="background-color: #4682B4;">
                    <li><a href="#tab-1">Datos Generales</a></li>
                    <li><a href="#tab-2">Contacto</a></li>
                </ul>
                <div id="tab-1"><%-- DIV DE DATOS DEL EMPLEADO --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Empleado</strong></span>
                        <input type="text" class="form-control" id="Accion" name="Accion" value="Add" hidden="true">
                        <input id="form-NombreEmpleado" name="form-NombreEmpleado" type="text" class="form-control col-sm-3" style="text-align: center" required="true" placeholder="Ingrese Nombres">
                        <span class="input-group-addon col-sm-2"><strong>Apellido Empleado</strong></span>
                        <input id="form-ApellidoEmpleado" name="form-ApellidoEmpleado" type="text" class="form-control col-sm-3" style="text-align: center" required="true" placeholder="Ingrese Apellidos">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Nacimiento</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaNacimiento" id="FechaNacimiento" required="true" style="text-align: center" readonly="true">
                        <span class="input-group-addon col-sm-2"><strong>Cedula</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-Cedula" id="form-Cedula" required="true" style="text-align: center" required="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Sexo:</strong></span>
                        <select class="form-control col-sm-2" id="Sexo" name="Sexo" style="text-align: center">
                            <option>Masculino</option>
                            <option>Femenino</option>
                        </select>
                        <span class="input-group-addon col-sm-2"><strong>Numero Empleado</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-NumEmpleado" id="form-NumEmpleado" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Ingreso</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaIngreso" id="FechaIngreso" style="text-align: center" required="true"  readonly="true">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Baja</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaBaja" id="FechaBaja" style="text-align: center" readonly="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Numero INSS</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-Inss" id="form-Inss" style="text-align: center">
                    </div>
                </div><%--FIN DIV DE DATOS DEL EMPLEADO --%>
                <div id="tab-2">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Direccion</strong></span>
                        <input id="form-Direccion" name="form-Direccion" type="text" class="form-control col-sm-3" maxlength="250" style="text-align: center" required="true">
                        <span class="input-group-addon col-sm-2"><strong>Departamento</strong></span>
                        <input id="form-Departamento" name="form-Departamento" type="text" class="form-control col-sm-2" maxlength="250" style="text-align: center">
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
                        <input id="form-Telefono" name="form-Telefono" type="tel" class="form-control col-sm-3" style="text-align: center" required="true">
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
                        <input id="form-Email" name="form-Email" type="email" class="form-control col-sm-6" style="text-align: center">
                        <span class="input-group-addon col-sm-2"><strong>Tipo</strong></span>                                
                        <select class="form-control col-sm-1" id="TipoEmail" name="TipoEmail">
                            <option>Trabajo</option>
                            <option>Personal</option>
                        </select>                                
                    </div>
                </div><%--FIN DIV DE DATOS DE CONTACTO DEL EMPLEADO --%>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type='button' onclick='history.go(-1);return false;' class='btn btn-primary'><< Volver</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                    </div>
                </div>                
            </form>
        </div><%--FIN DIV DE AGRUPACION DE LOS TABS--%>
        <script type="text/javascript">
            $('#FechaNacimiento').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                //dateFormat: "yy-mm-dd",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "1900:2003",
                pickTime: true,
                autoclose: true
            });
        </script>
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
