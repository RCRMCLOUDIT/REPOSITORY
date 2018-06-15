<%-- 
    Document   : PruebaReporte
    Created on : 10-12-2017, 09:43:31 AM
    Author     : moise
--%>
<%@page import="java.io.File"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    File reportFile = new File("Cloud/web/factura/ReporteFactura.jasper");
    System.out.println(reportFile.getAbsolutePath());
%>