<%-- 
    Document   : UsuarioBloqueado
    Created on : 09-21-2016, 04:13:23 PM
    Author     : Moises Romero
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Date d = new Date();
    String hoy = DateFormat.getDateInstance().format(d);
    String hora = DateFormat.getTimeInstance().format(d);
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <title>Usuario Bloqueado</title>
    </head>
    <body>
    <Center>
        <TABLE border="0" width="600" cellpadding="0" cellspacing="1">
            <TR>
                <TD  width="20%" rowspan="3"><IMG src="imagenes/Logo.jpg" border="0" width="120" height="48"></TD>
                <TD width="60%" align="center" class="rptComp">Nombre Compañia</TD>
            </TR>
        </TABLE>        
    </Center>

    <Center>
        <h1>El usuario con el que intenta acceder esta bloqueado o Desactivado</h1>
        <h1>Favor contacte al Administrador</h1>
        <h2><a href="Login.jsp">Relogin</a></h2>
    </Center>
</body>
<footer>
    <center>Son las <em/> <%= hora%> </em> del día <em/> <%=hoy%></em></center>
</footer>
</html>
