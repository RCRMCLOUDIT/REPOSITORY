<%-- 
    Document   : Footer
    Created on : 07-29-2016, 10:19:06 AM
    Author     : Moises Romero
--%>
<%@page import="java.text.DateFormat"%>
<%@page import="java.util.Date"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link href="css/estilos.css" rel="stylesheet" type="text/css">
<!DOCTYPE html>
<%
    Date d = new Date();
    String hoy = DateFormat.getDateInstance().format(d);
    String hora = DateFormat.getTimeInstance().format(d);
%>
<div style="text-align: center;">
    <center>
        &copy;2018 Cloud IT Systems.Todos Los Derechos Reservados.
    </center>   
</div>


