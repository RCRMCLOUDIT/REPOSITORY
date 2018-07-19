<%-- 
    Document   : ReporteFactura
    Created on : 10-12-2017, 04:47:17 PM
    Author     : moise
--%>
<%@page import="beans.ConexionDB"%>
<%@page import="model.DaoEmpresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="net.sf.jasperreports.engine.JasperRunManager"%>
<%@page import="java.util.*"%> 
<%@page import="java.io.*"%> 
<%@page import="java.sql.*"%> 
<html>
    <body>
        <%
            String Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, PagInicio;
            int IdFactura = Integer.valueOf(request.getParameter("idFactura"));
            DaoEmpresa datos = new DaoEmpresa();
            datos.BuscarEmpresa();
            Nombre = datos.Nombre;
            CedulaRuc = datos.CedulaRuc;
            Telefono = datos.Telefono;
            Direccion = datos.Direccion.trim();
            /*Parametros para realizar la conexion*/
            ConexionDB conn = new ConexionDB();
            //conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1/cloud.pos", "MROMERO", "MROMERO0017G");
            //conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cloud.pos", "rcromero", "Rcromero1082+");
            /*Establecemos la ruta del reporte*/
            File reportFile = new File(application.getRealPath("/factura/ReporteFactura.jasper"));
            //System.out.println("Url: " + reportFile.getPath());
            String Url = reportFile.getPath();
            /*Recogemos los parametros que enviaremos al reporte*/
            Map parameters = new HashMap();
            parameters.put("IdFactura", IdFactura);
            parameters.put("NombreEmpresa", Nombre);
            parameters.put("Direccion", Direccion);
            parameters.put("Telefono", Telefono);
            parameters.put("Ruc", CedulaRuc);
            /*Enviamos la ruta del reporte, los parámetros y la conexion(objeto Connection)*/
            //System.out.println(Url);
            byte[] bytes = JasperRunManager.runReportToPdf(Url, parameters, conn.Conectar());
            /*Indicamos que la respuesta va a ser en formato PDF*/
            response.setContentType("application/pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream ouputStream = response.getOutputStream();
            ouputStream.write(bytes, 0, bytes.length);
            /*Limpiamos y cerramos flujos de salida*/
            ouputStream.flush();
            ouputStream.close();
        %>
    </body>
</html>
