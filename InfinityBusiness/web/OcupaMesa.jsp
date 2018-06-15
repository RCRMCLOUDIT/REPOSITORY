<%-- 
    Document   : OcupaMesa
    Created on : 07-19-2017, 12:26:22 AM
    Author     : Moises Romero
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="controller.ServletOperacionesMesa"%>
<%@page import="java.sql.SQLException"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, user-scalable=no, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0">
    </head>
    <body>
        <%
            String id = String.valueOf(request.getParameter("id"));
        %>
        <form id="CambiaEstado" method="POST" action="/Cloud/ServletOperacionesMesa">
            <input type="number" name="IdMesa" value="<%=id%>"/>
            <input type="submit" name="actualiza" id="actualiza" value="Actualiza">
        </form>    
    </body>
</html>
