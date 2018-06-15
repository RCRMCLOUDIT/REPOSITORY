<%-- 
    Document   : PrincipalHotel
    Created on : 11-28-2017, 12:57:38 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="model.DaoEmpresa"%>
<%@page import="model.DaoLogin"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String usuario = (String) DaoLogin.User;
    String NombreEmpresa = (String) DaoEmpresa.Nombre;
    int IdUsuario = DaoLogin.IdUsuario;
    if (usuario.equals("")) {
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }
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
        <link rel="stylesheet" href="assets/css/estilos.css"> 
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
        <title>Principal Hotel</title>
    </head>
    <%-- HEADER --%> 
    <center>
        <div class="table-responsive bg-warning" style="align-content: center; align-items: center; overflow: auto;"> 
            <table class="table grid">
                <tbody>
                    <tr>
                        <td colspan="2" style="">
                <center>
                    <img src="images/HOSTEL.jpg" alt="" style="alignment-adjust: auto;"/>                   
                </center>
                </td>
                <td colspan="1" style="">
                <center>
                    <%
                        if (NombreEmpresa == null) {
                    %>
                    <h3>Coloca El Nombre de Tu Empresa</h3>
                    <%
                    } else {
                    %>
                    <h3><%=NombreEmpresa%></h3>
                    <%}%>
                </center>
                </td>
                <td colspan="2">
                <center>
                    <img src="images/LOGOIB.png" alt="" style="alignment-adjust: auto;"/>
                </center>
                </td>                        
                </tr>                    
                </tbody>
            </table>
        </div>        
    </center>
    <%-- END OF HEADER --%> 

    <%-- MENU --%> 
    <nav class="navbar navbar-dark bg-warning">
        <button class="navbar-toggler hidden-lg-up" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"></button>
        <div class="collapse navbar-toggleable-md" id="navbarResponsive">
            <!-- MEJORA PARA MAS ADELANTE HABILITAR EL MODULO DE RESERVA -->
            <!-- <a class="navbar-brand" href="index"><i class="fa fa-table" aria-hidden="true"></i> Reservas</a>-->
            <ul class="nav navbar-nav">
                <a class="navbar-brand" href="PrincipalRestaurante.jsp"><img src="images/Home.ico"></a>

                <!-- =====================================MODULO ADMIN============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Configuracion.ico"></a>
                    <!--    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><i class="fa fa-product-hunt" aria-hidden="true"></i> Administracion</a>-->
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="configuracion/ConfiguracionEmpresa.jsp"><i class="btn btn-primary btn-sm"><img src="images/Ajustes.ico"></i>Datos Empresa</a>
                        <a id="sub" class="dropdown-item" href="Mesas/ListadoMesas.jsp"><i class="btn btn-primary btn-sm"><img src="images/Ajustes.ico"></i>Mesas</a>
                        <a id="sub" class="dropdown-item" href="empleados/ListarEmpleado.jsp"><i class="btn btn-primary btn-sm"><img src="images/ListaUsuarios.ico"></i> Lista Empleados</a>
                        <a id="sub" class="dropdown-item" href="empleados/Usuario.jsp"><i class="btn btn-primary btn-sm"><img src="images/Usuarios.ico"></i>Usuarios</a>
                    </div>
                </li>

                <!-- =====================================MODULO RESERVAS============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Reserva.ico"></a>
                    <!--    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><i class="fa fa-product-hunt" aria-hidden="true"></i> Administracion</a>-->
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="hotel/ListaReservaHotel.jsp"><i class="btn btn-primary btn-sm"><img src="images/Habitacion32x32.ico"></i>Habitacion</a>
                        <a id="sub" class="dropdown-item" href=""><i class="btn btn-primary btn-sm"><img src="images/Mesa32x32.ico"></i>Mesa</a>
                    </div>
                </li>

                <!-- =====================================MODULO HOTEL============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/HOTEL.gif"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="PrincipalHotel.jsp"><i class="btn btn-primary btn-sm"><img src="images/ListHabitaciones32x32.ico"></i>Listado Habitaciones</a>
                        <a id="sub" class="dropdown-item" href="hotel/ListarTipoHabitacion.jsp"><i class="btn btn-primary btn-sm"><img src="images/TipoCategorias.ico"></i>Tipo Habitación</a>
                        <a id="sub" class="dropdown-item" href="hotel/ListarHabitaciones.jsp"><i class="btn btn-primary btn-sm"><img src="images/Habitaciones.gif"></i>Habitaciones</a>
                        <a id="sub" class="dropdown-item" href="hotel/checkIn.jsp"><i class="btn btn-primary btn-sm"><img src="images/Check.ico" style="width: 32px; height: 32px;"></i>Check IN</a>
                        <a id="sub" class="dropdown-item" href="hotel/checkOut.jsp"><i class="btn btn-primary btn-sm"><img src="images/CheckOUT.gif"></i>Check OUT</a>
                    </div>
                </li>

                <!-- =====================================MODULO CATALAGO============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Catalogo.ico"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="producto/ListarMarca.jsp"><i class="btn btn-primary btn-sm"><img src="images/Marca.ico"></i> Marca</a>
                        <a id="sub" class="dropdown-item" href="producto/ListarTipoCategoria.jsp"><i class="btn btn-primary btn-sm"><img src="images/TipoCategorias.ico"></i> Tipos de Categorias</a>
                        <a id="sub" class="dropdown-item" href="producto/ListarCategoria.jsp"><i class="btn btn-primary btn-sm"><img src="images/Categorias.ico"></i> Categorias</a>
                        <a id="sub" class="dropdown-item" href="producto/ListarUnidad.jsp"><i class="btn btn-primary btn-sm"><img src="images/UnidadMedida.ico"></i> Unidades de Medidas</a>
                        <a id="sub" class="dropdown-item" href="producto/ListarProducto.jsp"><i class="btn btn-primary btn-sm"><img src="images/Producto.ico"></i> Producto</a>
                    </div>
                </li>

                <!-- =====================================MODULO BODEGA============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Bodega.ico"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="bodegas/EntradaInven.jsp"><i class="btn btn-primary btn-sm"><img src="images/Entradas.ico"></i> Entradas</a>
                        <!--<a id="sub" class="dropdown-item" href="bodegas/TransferenciaInven.jsp"><i class="btn btn-primary btn-sm"></i> Transferencia</a> -->
                        <a id="sub" class="dropdown-item" href="bodegas/SalidaInven.jsp"><i class="btn btn-primary btn-sm"><img src="images/Salidas.ico"></i> Salidas</a>
                        <a id="sub" class="dropdown-item" href="bodegas/AjusteInven.jsp"><i class="btn btn-primary btn-sm"><img src="images/Ajustes.ico"></i> Ajustes</a>
                        <a id="sub" class="dropdown-item" href="bodegas/ListarMovimientosInventarios.jsp"><i class="btn btn-primary btn-sm"><img src="images/Reporte.ico"></i> Reportes</a>
                    </div>
                </li>

                <!-- =====================================MODULO ORDENES============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Ordenes.ico"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="ordenes/ListarOrdenes.jsp"><i class="btn btn-primary btn-sm"><img src="images/ListaOrdenes.ico"></i> Lista Ordenes</a>
                    </div>
                </li>                

                <!-- =====================================MODULO FACTURACION============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Facturacion.ico"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="factura/ListadoClientes.jsp"><i class="btn btn-primary btn-sm"><img src="images/ListaClientes.ico"></i> Lista de CLiente</a>
                        <a id="sub" class="dropdown-item" href="factura/BuscarOrdenVenta.jsp?idCli=null"><i class="btn btn-primary btn-sm"><img src="images/Factura.ico"></i>Generar Orden Venta</a>
                        <a id="sub" class="dropdown-item" href="#"><i class="btn btn-primary btn-sm"><img src="images/Imprimir.ico"></i> Imprimir</a>
                        <a id="sub" class="dropdown-item" href="#"><i class="btn btn-primary btn-sm"><img src="images/Reporte.ico"></i> Reportes</a>
                    </div>
                </li>                

                <!-- =====================================MODULO CONTABILIDAD============================================ -->
                <li class="nav-item dropdown nav-item active">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="true"><img src="images/Contabilidad64.png"></a>
                    <div class="dropdown-menu" id="sub" aria-labelledby="responsiveNavbarDropdown">
                        <a id="sub" class="dropdown-item" href="contabilidad/TipoCuentas.jsp"><i class="btn btn-primary btn-sm"><img src="images/TipoCategorias.ico"></i>Tipos de Cuentas</a>
                        <a id="sub" class="dropdown-item" href="contabilidad/CatalogoContable.jsp"><i class="btn btn-primary btn-sm"><img src="images/TiposCuentaCont32.png"></i>Catalogo de Cuentas</a>
                    </div>
                </li>   
                <!-- =====================================         ============================================ -->
                <li class="nav-item dropdown  nav-item active float-xs-right">
                    <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-windows" aria-hidden="true"></i> Bienvenido! <%=usuario%></a>
                    <div class="dropdown-menu" aria-labelledby="responsiveNavbarDropdown">
                        <a class="dropdown-item" href="Login.jsp"><i class="btn btn-danger btn-sm fa fa-window-close-o"> </i> Cerrar Sesión</a>
                        <a class="dropdown-item" href="empleados/EditarPassword.jsp?idUser=<%=IdUsuario%>"><i class="btn btn-primary btn-sm fa fa-address-book"></i> Cambiar Contraseña</a>
                    </div>
                </li>

            </ul>
        </div>
    </nav>
    <%-- END OF MENU --%> 

    <%-- BODY --%>     
    <%@include file="hotel/ListadoHabitaciones.jsp" %>

    <%-- FOOTER --%>    
    <div align="center"> 
        <footer>

        </footer>
    </div>
</html>
