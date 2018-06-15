<%-- 
    Document   : EditarPassword
    Created on : 05-07-2018, 10:37:13 AM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String NombreEmpleado = request.getParameter("Name");
    String NombreUsuario = request.getParameter("User");
    String IdUsuario = request.getParameter("idUser");
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
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <script>
            // FUNCION PARA VERIFICAR QUE LA CONTRASEÑA NUEVA SE DIGITO BIEN
            function validate_password() {
                //Cogemos los valores actuales del formulario
                var PassActual = $('#form-PassworActual').val();
                var PassNuevo = $('#form-PasswordNuevo').val();
                var ConfirmPass = $('#form-ConfirmPassword').val();
                if (PassActual === PassNuevo) {
                    alert("La nueva Contraseña es Igual a la Anterior.");
                    $('#form-PasswordNuevo').val("");
                    $('#form-ConfirmPassword').val("");
                    return false;
                } else if (PassActual === ConfirmPass) {
                    return true;
                } else {
                    alert("Las Contraseñas no coinciden.");
                    $('#form-PasswordNuevo').val("");
                    $('#form-ConfirmPassword').val("");
                    $('#form-PasswordNuevo').focus();
                    return false;
                }

            }
        </script>
        <title>Editando|Datos Usuario</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Editar Datos de Usuario</h1>                
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Usuario</a></li>
                <li><a href="#tab-2">Permisos Usuario</a></li>
            </ul>
            <div id="tab-1"><%-- DIV DE DATOS DEL USUARIO --%>
                <%-- FORMULARIO PARA MANDAR ACTUALIZAR LOS DATOS DEL USUARIO --%>
                <form id="UpdateDatosUsuario" role='form' action='../ServletUsuario' method='POST' onsubmit="return validate_password();">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Empleado</strong></span>
                        <input autocomplete="off" type="text" class="form-control" id="form-IdUsuario" name="form-IdUsuario" value="<%=IdUsuario%>" readonly="true" hidden="true">
                        <input id="form-NombreEmpleado" name="form-NombreEmpleado" type="text" class="form-control col-sm-6" style="text-align: center" value="<%=NombreEmpleado%>" readonly="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Usuario</strong></span>
                        <input autocomplete="off" id="form-NombreUsuario" name="form-NombreUsuario" type="text" class="form-control col-sm-6" style="text-align: center" value="<%=NombreUsuario%>" readonly="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Password Actual</strong></span>
                        <input required="true" autocomplete="new-password" id="form-PasswordActual" name="form-PasswordActual" type="password" class="form-control col-sm-6" style="text-align: center" placeholder="Digite Su Password Actual">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Password Nuevo</strong></span>
                        <input required="true" autocomplete="new-password" id="form-PasswordNuevo" name="form-PasswordNuevo" type="password" class="form-control col-sm-6" style="text-align: center" placeholder="Digite Su Password Nuevo">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Confirme Nuevo Password</strong></span>
                        <input required="true" autocomplete="new-password" id="form-ConfirmPassword" name="form-ConfirmPassword" type="password" class="form-control col-sm-6" style="text-align: center" placeholder="Digite para confirmar su Password Nuevo">
                    </div>
                    <BR>
                    <div class="row form-group">
                        <div class="col-sm-3"> </div>
                        <div class="col-sm-offset-3 col-sm-3">
                            <button type='button' onclick='history.go(-1);
                                    return false;' class='btn btn-primary'><< Volver</button>
                            <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                        </div>
                    </div>
                </form><%-- FIN FORMULARIO PARA MANDAR ACTUALIZAR LOS DATOS DEL USUARIO --%>
            </div><%--FIN DIV DE DATOS DEL USUARIO --%>
        </div><%--FIN DIV GRUPO DE TABS--%>
    </body>
</html>
