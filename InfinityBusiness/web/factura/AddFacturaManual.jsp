<%-- 
    Document   : AddFacturaManual
    Created on : 11-16-2017, 03:13:06 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String idCli = request.getParameter("idCli");
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
        <title>Factura Manual</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Factura Manual</h1>                
            </center>
        </div>
        <div id="BuscarCliente">
            <form id="FormBuscarCliente" role="form" action="BuscarCliente.jsp">
                <div class="input-group">
                    <span class="input-group-addon">Nombre Cliente:</span>
                    <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Nombre a  Buscar..." required="true">
                    <button class="btn btn-primary" id="Buscar" type="submit">Buscar</button>
                </div>
            </form>
        </div>
        <div id="DatosClienteFactura">
            <% //MANDO A EJECUTAR LA CONSULTA DE BUSQUEDA, PARA OBTENER LOS DATOS DEL CLIENTE
                String Cedula, Nombre, Apellido, Direccion, Telefono;
                if (idCli.equals("null")) {
                    Cedula = "";
                    Nombre = "";
                    Apellido = "";
                    Direccion = "";
                    Telefono = "";
                } else {
                    DaoCliente datos = new DaoCliente();
                    datos.BuscarCliente(Integer.parseInt(idCli));
                    //OBTENIENDO DATOS DE LA CONSULTA
                    Cedula = datos.DNI;
                    Nombre = datos.Nombre;
                    Apellido = datos.Apellido;
                    Direccion = datos.Direccion;
                    Telefono = datos.Telefono;
                }
            %>
            <table class="table table-responsive" id="tblCliente">
                <thead style="background-color: #4682B4;">
                    <tr> 
                        <th colspan="6" style="color: #FFFFFF; text-align: center;">Datos Cliente</th>
                        <th colspan="4" style="color: #FFFFFF; text-align: left;">Datos Factura</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td><strong>Nombre:</strong><span style="color: red">*</span></td>
                        <td>
                            <input type="text" class="form-control" name="Nombre" id="Nombre" required="true" size="30px" readonly="true" value="<%=Nombre%>">
                            <input type="text" name="IdCli" id="IdCli" hidden="true">
                        </td>
                        <td><strong>Apellido:</strong><span style="color: red">*</span></td>
                        <td><input type="text" class="form-control" name="Apellido" id="Apellido" required="true" size="30px" readonly="true" value="<%=Apellido%>"></td>
                        <td><strong>Cedula:</strong><span style="color: red">*</span></td>
                        <td><input type="text" class="form-control" name="Cedula" id="Cedula" required="true" size="16px" readonly="true" value="<%=Cedula%>"></td>
                            <%-- NUMERO Y FECHA DE LA FACTURA --%>
                        <td><strong>Factura #</strong><span style="color: red">*</span></td>
                        <td><input type="text" name="IdFactura" class="form-control" style="text-align: center" id="IdFactura" required="true" size="10px" readonly="true" value=""></td>

                    </tr>
                    <tr>
                        <td><strong>Direccion:</strong></td>
                        <td>
                            <textarea type="text" class="form-control" id="Direccion" name="Direccion" rows="2" readonly="true"><%=Direccion%></textarea>
                        </td>
                        <td><strong>Telefono:</strong><span style="color: red">*</span></td>
                        <td><input type="text" name="Telefono" class="form-control" id="Telefono" required="true" size="12px" readonly="true" value="<%=Telefono%>"></td>
                        <td></td>
                        <td></td>
                        <td><strong>Fecha Factura:</strong><span style="color: red">*</span></td>
                        <td><input type="text" class="form-control" id="FechaFactura" name="FechaFactura"></td>
                    </tr>
                    <tr>
                        <td colspan="6"></td>
                        <%-- OTROS DATOS DE LA FACTURA --%>
                        <td>
                            <strong>Tipo & Moneda</strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <select class="form-control" style="text-align: center; width: auto;" name="TipoFactura" id="TipoFactura" required="true">
                                <option>Contado</option>
                                <option>Credito</option>
                            </select>
                            <select class="form-control" style="text-align: center; width: 80px;" name="MonedaFactura" id="MonedaFactura" required="true">
                                <option>C$</option>
                                <option>U$</option>
                            </select>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div id="ItemFactura">
            <div class="col-md-12">
                <div class="pull-right">
                    <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                        <span class="glyphicon glyphicon-plus"></span> Agregar productos
                    </button>
                    <button type="submit" class="btn btn-default">
                        <span class="glyphicon glyphicon-print"></span> Imprimir
                    </button>
                </div>	
            </div>
        </div>

        <script type="text/javascript">
            $('#FechaFactura').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd MM, yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                autoclose: true
            }).datepicker("setDate", new Date());
        </script>
    </body>
    <br>
    <footer>
        <center>
            <%@include file="../commons/Footer.jsp" %>
        </center>
    </footer>
</html>
