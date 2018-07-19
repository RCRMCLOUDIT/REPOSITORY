<%-- 
    Document   : ModificarEmpleado
    Created on : 10-11-2016, 09:37:06 AM
    Author     : Moises Romero
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.Date"%>
<%@page import="model.DaoEmpleado"%>
<%@page import="model.DaoLogin"%>
<%@page import="controller.ServletEmpleado" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int IdEmp = Integer.parseInt(request.getParameter("idEmp"));
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
            //FUNCION PARA AGREGAR UNA NUEVA DIRECCION
            $(document).ready(function () {
                $('#btnAgregarDireccion').click(function () {
                    var IdEmpleado = $('#IdEmpleado').val();
                    var TipoDireccion = $('#TipoDireccion').val();
                    var Direccion = $('#form-Direccion').val();
                    var Departamento = $('#form-Departamento').val();
                    var FechaAlta = $('#FechaAlta').val();
                    var Accion = "AddDireccion";
                    if ($('#form-Direccion').val() === "") {
                        alert("Revisar Direccion, Campo Vacio");
                        $('#form-Direccion').focus();
                    } else if ($('#form-Departamento').val() === "") {
                        alert("Revisar Departamento, Campo Vacio");
                        $('#form-Departamento').focus();
                    } else {
                        $.ajax({
                            type: 'POST',
                            data: {IdEmpleado: IdEmpleado, TipoDireccion: TipoDireccion, Direccion: Direccion, Departamento: Departamento,
                                FechaAlta: FechaAlta, Accion: Accion},
                            url: '../ServletEmpleado',
                            success: function (response) {
                                //utilzar response
                                $('#AgregarDireccion').modal('hide');
                                location.reload(true);
                                location.href = "/InfinityBusiness/empleados/ModificarEmpleado.jsp?idEmp='" + IdEmp + "'#tab-2";
                            }
                        });
                    }
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
        <script type="text/javascript">
            // FUNCION PARA LISTAR TODAS LAS DIRECCIONES REGISTRADAS AL EMPLEADO, YA SEA ACTIVAS O INACTIVAS
            function ListarDirTodos() {
                //alert("Descuento Activado");
                document.getElementById('MostrarTodos').style.display = 'none';
                document.getElementById('MostrarActivos').style.display = 'inline';
                document.getElementById('DireccionTodos').style.display = 'inline';
                document.getElementById('DireccionActivo').style.display = 'none';
            }
            // FUNCION PARA LISTAR TODAS LAS DIRECCIONES REGISTRADAS AL EMPLEADO - SOLO LAS ACTIVAS
            function ListarDirActivos() {
                //alert("Descuento Activado");
                document.getElementById('MostrarTodos').style.display = 'inline';
                document.getElementById('MostrarActivos').style.display = 'none';
                document.getElementById('DireccionTodos').style.display = 'none';
                document.getElementById('DireccionActivo').style.display = 'inline';
            }
        </script>
        <title>Editar Empleado</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Editar Datos del Empleado</h1>                
            </center>
        </div>
        <div id="grupoTablas"><%-- DIV PARA AGRUPAR LOS DATOS POR TABS --%>
            <form id="UpdateDatosEmpleado" role='form' action='../ServletEmpleado' method='POST'>
                <%  int IdEmpleado = Integer.parseInt(request.getParameter("idEmp"));
                    DaoEmpleado datos = new DaoEmpleado();
                    datos.BuscarEmpleado(IdEmpleado);
                    String NumEmp, Cedula, Inns, Nombre, Apellido, FechaNac, Sexo, FechaIngreso, FechaBaja;
                    NumEmp = datos.NUMEMP;
                    Cedula = datos.CEDULA;
                    Inns = datos.INSS;
                    Nombre = datos.NOMBRE;
                    Apellido = datos.APELLIDO;
                    FechaNac = datos.FECHANAC;
                    Sexo = datos.SEXO;
                    FechaIngreso = datos.FECHAALTA;
                    FechaBaja = datos.FECHABAJA;
                %>                
                <ul  style="background-color: #4682B4;">
                    <li><a href="#tab-1">Datos Generales</a></li>
                    <li><a href="#tab-2">Contacto</a></li>
                </ul>
                <div id="tab-1"><%-- DIV DE DATOS DEL EMPLEADO --%>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Empleado</strong></span>
                        <input type="text" class="form-control" id="form-IdEmpleado" name="form-IdEmpleado" value="<%=IdEmpleado%>" hidden="true">
                        <input type="text" class="form-control" id="Accion" name="Accion" value="Update" hidden="true">
                        <input id="form-NombreEmpleado" name="form-NombreEmpleado" type="text" class="form-control col-sm-3" style="text-align: center" value="<%=Nombre%>">
                        <span class="input-group-addon col-sm-2"><strong>Apellido Empleado</strong></span>
                        <input id="form-ApellidoEmpleado" name="form-ApellidoEmpleado" type="text" class="form-control col-sm-3" style="text-align: center" value="<%=Apellido%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Nacimiento</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaNacimiento" id="FechaNacimiento" required="true" style="text-align: center" value="<%=FechaNac%>">
                        <span class="input-group-addon col-sm-2"><strong>Cedula</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-Cedula" id="form-Cedula" required="true" style="text-align: center" value="<%=Cedula%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Sexo:</strong></span>
                        <select class="form-control col-sm-2" id="Sexo" name="Sexo" style="text-align: center">
                            <% if (Sexo.equals("M")) {%>
                            <option>Masculino</option>
                            <%} else {%>
                            <option>Femenino</option>
                            <%}%>
                        </select>
                        <span class="input-group-addon col-sm-2"><strong>Numero Empleado</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-NumEmpleado" id="form-NumEmpleado" required="true" style="text-align: center" value="<%=NumEmp%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Ingreso</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaIngreso" id="FechaIngreso" style="text-align: center" required="true"  readonly="true" value="<%=FechaIngreso%>">
                        <span class="input-group-addon col-sm-2"><strong>Fecha Baja</strong></span>
                        <input type="text" class="form-control col-sm-2" name="FechaBaja" id="FechaBaja" style="text-align: center" readonly="true" value="<%=FechaBaja%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Numero INSS</strong></span>
                        <input type="text" class="form-control col-sm-2" name="form-Inss" id="form-Inss" style="text-align: center" value="<%=Inns%>">
                    </div>                    
                </div><%--FIN DIV DE DATOS DEL EMPLEADO --%>
                <div id="tab-2">
                    <div id="grupoTablas2"><%--DIV DE DATOS DE CONTACTO DEL EMPLEADO --%>
                        <ul  style="background-color: #4682B4;">
                            <li><a href="#tab-2.1">Direccion</a></li>
                            <li><a href="#tab-2.2">Telefonos</a></li>
                            <li><a href="#tab-2.3">Email</a></li>
                        </ul>
                        <div id="tab-2.1">
                            <div id="EncabezadoPagina" style="background-color: #4682B4;">
                                <center>
                                    <h3 style="color: #FFFFFF; text-align: center;">Lista de Direcciones</h3>                
                                </center>
                            </div>
                            <%--TABLA DE LISTADO PARA LAS DIRECCIONES DEL EMPLEADO--%>
                            <div id="DireccionActivo">
                                <Center><%--TABLA DE LISTADO PARA LAS DIRECCIONES EN ESTADO ACTIVO DEL EMPLEADO--%>
                                    <table class="table table-hover" id="tblDireccionEmpleados" style="width: auto;">
                                        <thead style="background-color: #4682B4">
                                            <tr>
                                                <th style="color: #FFFFFF; text-align: center;">Tipo</th>
                                                <th style="color: #FFFFFF; text-align: center;">Direccion</th>
                                                <th style="color: #FFFFFF; text-align: center;">Departamento</th>
                                                <th style="color: #FFFFFF; text-align: center;">Activo?</th>
                                                <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody style="background-color: #C7C6C6;">
                                            <%try {
                                                    ConexionDB conn = new ConexionDB();
                                                    conn.Conectar();
                                                    ResultSet rs = null;
                                                    PreparedStatement pst = null;
                                                    pst = conn.conexion.prepareStatement("SELECT Id, Tipo, Direccion, Departamento, FechaAlta, Activo FROM `dirempleado` WHERE Activo='Si'");
                                                    rs = pst.executeQuery();
                                                    while (rs.next()) {
                                                        out.println("<TR style='text-align: center;'>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(5) + "</TD>");
                                                        out.println("<TD>"
                                                                + "<a href='EditarDireccion.jsp?id=" + rs.getInt(1) + "&Tipo=" + rs.getString(2) + "&Direccion=" + rs.getString(3) + "&Departamento=" + rs.getString(4) + "&FechaAlta=" + rs.getString(5) + "' class='btn btn-primary'>Editar</a>"
                                                                + "</TD>");
                                                        out.println("</TR>");
                                                    }; // fin while 
                                                } //fin try no usar ; al final de dos o mas catchs 
                                                catch (SQLException e) {
                                                };
                                                //}; %>
                                        </tbody>
                                    </table>
                                    <button type="button" id="MostrarTodos" name="MostrarTodos" class="btn btn-primary" onclick="ListarDirTodos();">Mostrar Todos</button>
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#AgregarDireccion">Agregar Direccion</button>
                                </Center><%--FIN TABLA DE LISTADO PARA LAS DIRECCIONES EN ESTADO ACTIVO DEL EMPLEADO--%>
                            </div>
                            <div id="DireccionTodos" style="display: none;">
                                <Center><%--TABLA DE LISTADO PARA TODAS LAS DIRECCIONES ACTIVAS O INACTIVAS DEL EMPLEADO--%>
                                    <table class="table table-hover" id="tblDireccionEmpleados" style="width: auto;">
                                        <thead style="background-color: #4682B4">
                                            <tr>
                                                <th style="color: #FFFFFF; text-align: center;">Tipo</th>
                                                <th style="color: #FFFFFF; text-align: center;">Direccion</th>
                                                <th style="color: #FFFFFF; text-align: center;">Departamento</th>
                                                <th style="color: #FFFFFF; text-align: center;">Activo?</th>
                                                <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                            </tr>
                                        </thead>
                                        <tbody style="background-color: #C7C6C6;">
                                            <%
                                                try {
                                                    ConexionDB conn = new ConexionDB();
                                                    conn.Conectar();
                                                    ResultSet rs = null;
                                                    PreparedStatement pst = null;
                                                    pst = conn.conexion.prepareStatement("SELECT Id, Tipo, Direccion, Departamento, Activo FROM `dirempleado`");
                                                    rs = pst.executeQuery();
                                                    while (rs.next()) {
                                                        out.println("<TR style='text-align: center;'>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                        out.println("<TD style='color: #000000;'>" + rs.getString(5) + "</TD>");
                                                        out.println("<TD>"
                                                                + "<a href='idEmp=" + rs.getInt(1) + "' class='btn btn-primary'>Editar</a>"
                                                                + "</TD>");
                                                        out.println("</TR>");
                                                    } // fin while
                                                } catch (Exception e) {
                                                }
                                            %>
                                        </tbody>
                                    </table>
                                    <button type="button" id="MostrarActivos" name="MostrarActivos" class="btn btn-primary" onclick="ListarDirActivos();" style="display: none;">Mostrar Activos</button>
                                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#AgregarDireccion">Agregar Direccion</button>
                                </Center><%--FIN TABLA DE LISTADO PARA TODAS LAS DIRECCIONES ACTIVAS O INACTIVAS DEL EMPLEADO--%>
                            </div>
                        </div> <%--FIN DEL DIV DE TABLA DE LISTADO PARA LAS DIRECCIONES DEL EMPLEADO--%>
                        <div id="tab-2.2">
                            <%--TABLA DE LISTADO PARA LOS TELEFONOS DEL EMPLEADO--%>
                            <Center>
                                <table class="table table-hover" id="tblTelefonoEmpleado" style="width: auto;">
                                    <thead style="background-color: #4682B4">
                                        <tr>
                                            <th style="color: #FFFFFF; text-align: center;">Tipo</th>
                                            <th style="color: #FFFFFF; text-align: center;">Telefono</th>
                                            <th style="color: #FFFFFF; text-align: center;">Extension</th>                                        
                                            <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody style="background-color: #C7C6C6;">
                                        <%
                                            try {
                                                ConexionDB conn = new ConexionDB();
                                                conn.Conectar();
                                                ResultSet rs = null;
                                                PreparedStatement pst = null;
                                                pst = conn.conexion.prepareStatement("SELECT Id, Tipo, Telefono, Extension FROM `telfempleado`");
                                                rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    out.println("<TR style='text-align: center;'>");
                                                    out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                    out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                    out.println("<TD style='color: #000000;'>" + rs.getString(4) + "</TD>");
                                                    out.println("<TD>"
                                                            + "<a href='idEmp=" + rs.getInt(1) + "' class='btn btn-primary'>Editar</a>"
                                                            + "</TD>");
                                                    out.println("</TR>");
                                                }//FIN WHILE
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </Center>
                        </div>
                        <div id="tab-2.3">
                            <%--TABLA DE LISTADO PARA LOS EMAIL DEL EMPLEADO--%>
                            <Center>
                                <table class="table table-hover" id="tblEmailEmpleado" style="width: auto;">
                                    <thead style="background-color: #4682B4">
                                        <tr>
                                            <th style="color: #FFFFFF; text-align: center;">Tipo</th>
                                            <th style="color: #FFFFFF; text-align: center;">Email</th>                                    
                                            <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                                        </tr>
                                    </thead>
                                    <tbody style="background-color: #C7C6C6;">
                                        <%
                                            try {
                                                ConexionDB conn = new ConexionDB();
                                                conn.Conectar();
                                                ResultSet rs = null;
                                                PreparedStatement pst = null;
                                                pst = conn.conexion.prepareStatement("SELECT Id, Tipo, Email FROM `emailempleado`");
                                                rs = pst.executeQuery();
                                                while (rs.next()) {
                                                    out.println("<TR style='text-align: center;'>");
                                                    out.println("<TD style='color: #000000;'>" + rs.getString(2) + "</TD>");
                                                    out.println("<TD style='color: #000000;'>" + rs.getString(3) + "</TD>");
                                                    out.println("<TD>"
                                                            + "<a href='idEmp=" + rs.getInt(1) + "' class='btn btn-primary'>Editar</a>"
                                                            + "</TD>");
                                                    out.println("</TR>");
                                                }//FIN WHILE
                                            } catch (Exception e) {
                                            }
                                        %>
                                    </tbody>
                                </table>
                            </Center>
                        </div>
                    </div>
                </div><%--FIN DIV DE DATOS DE CONTACTO DEL EMPLEADO --%>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <button type='button' onclick='history.go(-1);
                                return false;' class='btn btn-primary'><< Volver</button>
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
    <Center> <%--VENTANA MODAL PARA AGREGAR UNA NUEVA DIRECCION --%>
        <div class="modal fade" id="AgregarDireccion" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header" style="background-color: #4682B4">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <center>
                            <h3 style="color: #FFFFFF; text-align: center;">Agregar Nueva Direccion</h3>                
                        </center>                        
                    </div>
                    <div class="modal-body">
                        <div class="input-group">
                            <span class="input-group-addon col-sm-3"><strong>Tipo:</strong></span>
                            <select class="form-control col-sm-3" id="TipoDireccion" name="TipoDireccion" style="text-align: center">
                                <option>Casa</option>
                                <option>Oficina</option>
                                <option>Enviar A</option>
                                <option>Facturar A</option>
                            </select>
                        </div>                
                        <div class="row col-sm-12 pull-left">
                            <span class="input-group-addon col-sm-3"><strong>Fecha Effectiva</strong></span>
                            <input type="text" class="form-control col-sm-3" id="FechaAlta" name="FechaAlta" required="true">                                                                                              
                        </div>                                                
                        <div class="input-group">
                            <span class="input-group-addon col-sm-3"><strong>Direccion</strong></span>
                            <input id="form-Direccion" name="form-Direccion" type="text" class="form-control col-sm-9" maxlength="250" style="text-align: center" required="true" placeholder="Escriba la Direccion.....">
                        </div>
                        <div class="input-group">
                            <span class="input-group-addon col-sm-3"><strong>Departamento</strong></span>
                            <input id="form-Departamento" name="form-Departamento" type="text" class="form-control col-sm-9" maxlength="250" style="text-align: center" required="true" placeholder="Escriba el Departamento donde esta ubicado....">
                            <input type="text" name="IdEmpleado" id="IdEmpleado" value="<%=IdEmpleado%>" hidden="true">
                        </div>
                    </div>
                    <Center>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                            <button type="button" class="btn btn-primary" id="btnAgregarDireccion" >Agregar</button>
                        </div>                                                    
                    </Center>
                </div>
            </div>
        </div>
        <script type="text/javascript">
            $('#FechaAlta').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                pickTime: true,
                autoclose: true
            }).datepicker("setDate", new Date());
        </script>
    </Center> <%--FIN VENTANA MODAL PARA AGREGAR UNA NUEVA DIRECCION --%>
</body>
</html>
