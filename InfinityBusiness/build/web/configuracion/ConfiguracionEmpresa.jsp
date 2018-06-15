<%-- 
    Document   : ConfiguracionEmpresa
    Created on : 08-28-2017, 02:38:20 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, PagInicio;
    Double IVA;
    DaoEmpresa datos = new DaoEmpresa();
    datos.BuscarEmpresa();
    Nombre = datos.Nombre;
    CedulaRuc = datos.CedulaRuc;
    RazonSocial = datos.RazonSocial;
    Correo = datos.Correo;
    Telefono = datos.Telefono;
    Direccion = datos.Direccion.trim();
    RutaLogo = datos.RutaLogo;
    TipoNegocio = datos.TipoNegocio;
    PagInicio = datos.PagInicio;
    IVA = datos.IVA;
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
            $(function () {
                $("#grupoTablas2").tabs();
            });
        </script>        
        <title>Datos de la Compañia</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body style="background-color: #4682B4;">
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Informacion de la Compañia</h1>                
            </center>
        </div>
        <div id="grupoTablas">
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Generales</a></li>
                <li><a href="#tab-2">Contactos</a></li>
                <li><a href="#tab-3">Configuraciones</a></li>
            </ul>
            <form id="FormConfigEmpresa" class="form-horizontal" role="form" method="POST" action="../ServletEmpresa" >
                <div id="tab-1">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre Empresa:</strong></span>                        
                        <input type="text" class="form-control col-sm-4" id="NombreComapany" name="NombreComapany"  required="true" size="50" autocomplete="off" value="<%=Nombre%>" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Numero RUC:</strong></span>                        
                        <input type="text" class="form-control col-sm-4" id="RUC" name="RUC"  required="true" size="50" autocomplete="off" value="<%=CedulaRuc%>" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Razon Social:</strong></span>                        
                        <input type="text" class="form-control col-sm-4" id="RazonSocial" name="RazonSocial"  required="true" size="50" autocomplete="off" value="<%=RazonSocial%>" style="text-align: center">
                    </div>                            
                </div>
                <div id="tab-2">
                    <div id="grupoTablas2">
                        <ul  style="background-color: #4682B4;">
                            <li><a href="#tab-2.1">Direccion</a></li>
                            <li><a href="#tab-2.2">Telefonos</a></li>
                            <li><a href="#tab-2.3">Email</a></li>
                        </ul>
                        <div id="tab-2.1">

                        </div>
                        <div id="tab-2.2">

                        </div>
                        <div id="tab-2.3">

                        </div>
                    </div>
                </div>     
                <div id="tab-3">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Tipo de Negocio:</strong></span>
                        <%if (TipoNegocio.equals("")) {%>
                        <select class="form-control col-sm-4" id="TipoNegocio" name="TipoNegocio" style="text-align: center">
                            <option>Seleccionar Uno....</option>
                            <option>Restaurante</option>                            
                            <option>Hotel</option>
                            <option>Ambos</option>
                        </select>
                        <%}%>
                        <%if (TipoNegocio.equals("Restaurante")) {%>
                        <select class="form-control col-sm-4" id="TipoNegocio" name="TipoNegocio" style="text-align: center">
                            <option>Restaurante</option>                            
                        </select>                        
                        <%}%>
                        <%if (TipoNegocio.equals("Hotel")) {%>
                        <select class="form-control col-sm-4" id="TipoNegocio" name="TipoNegocio" style="text-align: center">
                            <option>Hotel</option>                           
                        </select>                        
                        <%}%>   
                        <%if (TipoNegocio.equals("Ambos")) {%>
                        <select class="form-control col-sm-4" id="TipoNegocio" name="TipoNegocio" style="text-align: center">
                            <option>Ambos</option>                          
                        </select>                        
                        <%}%>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Pagina de Inicio:</strong></span>
                        <%if (PagInicio.equals("")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Seleccionar Uno....</option>
                            <option>Restaurante</option>                            
                            <option>Hotel</option>
                            <option>Dashboard</option>
                        </select>
                        <%}%>
                        <%if (PagInicio.equals("Restaurante") && TipoNegocio.equals("Ambos")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Restaurante</option>
                            <option>Hotel</option>    
                            <option>Dashboard</option>                        
                        </select>                        
                        <%}%>
                        <%if (PagInicio.equals("Restaurante") && TipoNegocio.equals("Restaurante")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Restaurante</option>
                            <option>Dashboard</option>                          
                        </select>                        
                        <%}%>   
                        <%if (PagInicio.equals("Hotel") && TipoNegocio.equals("Ambos")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Hotel</option>
                            <option>Restaurante</option>
                            <option>Dashboard</option>                         
                        </select>                        
                        <%}%>
                        <%if (PagInicio.equals("Hotel") && TipoNegocio.equals("Hotel")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Hotel</option>
                            <option>Dashboard</option>                       
                        </select>                        
                        <%}%>
                        <%if (PagInicio.equals("Dashboard") && TipoNegocio.equals("Hotel")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Dashboard</option>
                            <option>Hotel</option>                       
                        </select>                        
                        <%}%>   
                        <%if (PagInicio.equals("Dashboard") && TipoNegocio.equals("Restaurante")) {%>
                        <select class="form-control col-sm-4" id="PagInicio" name="PagInicio" style="text-align: center">
                            <option>Dashboard</option>
                            <option>Restaurante</option>                       
                        </select>                        
                        <%}%>                        
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Aplicara IVA %:</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="IVA" name="IVA"  required="true" size="50" autocomplete="off" value="<%=IVA%>" style="text-align: center" placeholder="Impuesto a Cobrar..." min="0">
                    </div>                    
                </div>
                <br>
                <div class="row form-group">
                    <div class="col-sm-3"> </div>
                    <div class="col-sm-offset-3 col-sm-3">
                        <%--  <a href="../producto/ListarProducto.jsp" class="btn btn-primary"><< Volver</a> --%>
                        <button type='button' onclick='history.go(-1);return false;' class='btn btn-primary'><< Volver</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
