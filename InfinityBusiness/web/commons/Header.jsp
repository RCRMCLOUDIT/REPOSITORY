<%-- 
    Document   : Header
    Created on : 07-29-2016, 10:18:49 AM
    Author     : Moises Romero
--%>
<%@page import="model.DaoLogin"%>
<%@page import="model.DaoEmpresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String usuario = (String) DaoLogin.User;
    String NombreEmpresa = (String) DaoEmpresa.Nombre;
    int IdUsuario = DaoLogin.IdUsuario;
    if (usuario.equals("")) {
        response.sendRedirect("../Login.jsp");
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
    </head>
    <center>
        <div class="table-responsive bg-warning" style="align-content: center; align-items: center; overflow: auto;"> 
            <TABLE border="0" width="600" cellpadding="0" cellspacing="1">
                <TR>
                    <TD  width="20%" rowspan="3"><img src="../images/HOSTEL.jpg" alt="" style="alignment-adjust: auto;"/></TD>
                    <TD width="60%" align="center"><h1>Infinity Business</h1></TD>
                    <TD width="20%" rowspan="3"><img src="../images/LOGOIB.png" alt="" style="alignment-adjust: auto;"/></TD>
                </TR>
                <TR>
                    <TD align="center" width="60%">
                        <%
                            if (NombreEmpresa == null) {
                        %>
                        <h3>Coloca El Nombre de Tu Empresa</h3>
                        <%
                        } else {
                        %>
                        <h3><%=NombreEmpresa%></h3>
                        <%}%>
                    </TD>
                    <TD width="20%" class="label" align="right"></TD>
                    <TD width="20%" class="label" align="right"></TD>
                </TR>
                <TR></TR>
                <TR>
                <nav class="navbar navbar-dark bg-warning">
                    <div class="collapse navbar-toggleable-md" id="navbarResponsive">
                        <ul class="nav navbar-nav">
                            <!-- ===================================== CIERRE SESION ============================================ -->
                            <li class="nav-item dropdown  nav-item active">
                                <a class="nav-link dropdown-toggle" href="#" id="responsiveNavbarDropdown" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"><i class="fa fa-windows" aria-hidden="true"></i> Bienvenido! <%=usuario%></a>
                                <div class="dropdown-menu" aria-labelledby="responsiveNavbarDropdown">
                                    <a class="dropdown-item" href="../Login.jsp"><i class="btn btn-danger btn-sm fa fa-window-close-o"> </i> Cerrar Sesión</a>
                                    <a class="dropdown-item" href="../empleados/EditarPassword.jsp?idUser=<%=IdUsuario%>"><i class="btn btn-primary btn-sm fa fa-address-book"></i> Cambiar Contraseña</a>
                                </div>
                            </li>
                        </ul>
                    </div>
                </nav>
                </TR>
            </TABLE>
        </div>        
    </center>
</html>
