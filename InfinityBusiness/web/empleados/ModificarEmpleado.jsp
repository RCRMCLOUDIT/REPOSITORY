<%-- 
    Document   : ModificarEmpleado
    Created on : 10-11-2016, 09:37:06 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.Date"%>
<%@page import="model.DaoEmpleado"%>
<%@page import="model.DaoLogin"%>
<%@page import="controller.ServletEmpleadoUpdate" %>
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
        <%-- LLAMADO DEL ESTILO PARA EL DATE TIME PICKER --%>
        <script type="text/javascript">
            // FUNCION PARA EL DATETIME PICKER EN JQUERY
            jQuery(function ($) {
                $.datepicker.regional['es'] = {
                    closeText: 'Cerrar',
                    prevText: '&#x3c;Ant',
                    nextText: 'Sig&#x3e;',
                    currentText: 'Hoy',
                    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio',
                        'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
                    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun',
                        'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
                    dayNames: ['Domingo', 'Lunes', 'Martes', 'Mi&eacute;rcoles', 'Jueves', 'Viernes', 'S&aacute;bado'],
                    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mi&eacute;', 'Juv', 'Vie', 'S&aacute;b'],
                    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'S&aacute;'],
                    weekHeader: 'Sm',
                    dateFormat: "yy-mm-dd",
                    //dateFormat: 'dd/mm/yy',
                    //dateFormat: 'yy/mm/dd',
                    firstDay: 1,
                    isRTL: false,
                    showMonthAfterYear: false,
                    changeYear: true,
                    changeMonth: true,
                    showAnim: 'fadeIn',
                    yearSuffix: ''};
                $.datepicker.setDefaults($.datepicker.regional['es']);
            });

            // RANGO DE FECHA PARA LA FECHA DE INGRESO
            $(document).ready(function () {
                $("#fechaingreso").datepicker({
                    yearRange: "1960:2050"
                });
            });

            // RANGO DE FECHA PARA LA FECHA DE NACIMIENTO
            $(document).ready(function () {
                $("#fechanac").datepicker({
                    yearRange: "1950:2015"
                });
            });
        </script>

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
        <title>Editar Empleado</title>
    </head>
    <body style="background-color: #1AAE88">
    <Center><h1> <strong>Editar Empleado</strong></h1></Center>
    <div id="cuerpo">
        <form id="updateempleado" method="POST" action="../ServletEmpleadoUpdate">
            <%
                int cod = Integer.parseInt(request.getParameter("idEmp"));
                DaoEmpleado datos = new DaoEmpleado();
                datos.BuscarEmpleado(cod);
                String NumEmp, Cedula, Inns, Nombre, Apellido, FechaNac, Sexo, Direccion, Telefono, Celular, Correo, FechaAlta;

                NumEmp = datos.NUMEMP;
                Cedula = datos.CEDULA;
                Inns = datos.INSS;
                Nombre = datos.NOMBRE;
                Apellido = datos.APELLIDO;
                FechaNac = datos.FECHANAC;
                Sexo = datos.SEXO;
                Direccion = datos.DIRECCION;
                Telefono = datos.TELEFONO;
                Celular = datos.CELULAR;
                Correo = datos.CORREO;
                FechaAlta = datos.FECHAALTA;
            %>
            <Center>
                <Table class="table-responsive bg-info">
                    <tr>
                        <td>
                            <strong>Numero Empleado:</strong>

                        </td>
                        <td>
                            <input type="text" name="numEmp" id="numEmp" required="true" size="15" value="<%= NumEmp%>">
                            <input type="text" name="IdEmp" id="IdEmp" value="<%= cod%>" hidden="true">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Cedula:</strong>

                        </td>
                        <td>
                            <input type="text" name="cedula" id="cedula" required="true" size="15" value="<%= Cedula%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>NoInss:</strong>

                        </td>
                        <td>
                            <input type="text" name="inss" id="inss" required="true" size="15" value="<%= Inns%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Nombre: </strong>

                        </td>
                        <td>
                            <input type="text" name="nombre" id="nombre" required="true" size="50" value="<%= Nombre%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Apellido: </strong>

                        </td>
                        <td>
                            <input type="text" name="apellido" id="apellido" required="true" size="50" value="<%= Apellido%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Fecha de Nacimiento:</strong>

                        </td>
                        <td>
                            <input type="text" name="fechanac" id="fechanac" required="true" size="12" value="<%= FechaNac%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Sexo:</strong>

                        </td> 
                        <td>
                            <select name="sexo" id="sexo" required="true">
                                <% if (Sexo.equals("M")) {%>
                                <option>Masculino</option>
                                <option>Femenino</option>
                                <%} else {%>
                                <option>Femenino</option>
                                <option>Masculino</option>
                                <%}%>
                            </select>
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            <strong>Direccion:</strong>

                        </td>
                        <td>
                            <input type="text" name="direccion" id="direccion" required="true" size="50" value="<%= Direccion%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Telefono:</strong>

                        </td>
                        <td>
                            <input type="text" name="telefono" id="telefono" required="true" size="15" onkeypress="return valida(event)" value="<%= Telefono%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Celular:</strong>

                        </td>
                        <td>
                            <input type="text" name="celular" id="celular" size="15" onkeypress="return valida(event)" value="<%= Celular%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Correo:</strong>
                        </td>
                        <td>
                            <input type="email" name="correo" id="correo" size="50" value="<%= Correo%>"><strong>Ejemplo@alguien.hotmail.com</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong> Fecha de Ingreso:</strong>
                        </td>
                        <td>
                            <input type="text" name="fechaingreso" id="fechaingreso" readonly="readonly" size="12" value="<%= FechaAlta%>"/>
                        </td>
                    </tr>
                    <tr>
                        <td>

                        </td>
                        <td>
                            <a href="ListarEmpleado.jsp" class="btn btn-primary">Volver</a>
                            <button type='submit' class='btn btn-primary' name="guardar" id="guardar">Guardar</button>
                        </td>
                    </tr>
                </Table>
            </Center>
        </form>    
    </div>
</body>
</html>
