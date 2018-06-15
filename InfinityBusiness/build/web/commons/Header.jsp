<%-- 
    Document   : Header
    Created on : 07-29-2016, 10:18:49 AM
    Author     : Moises Romero
--%>
<%@page import="model.DaoEmpresa"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String NombreEmpresa = (String) DaoEmpresa.Nombre;
    //String RutaLogo = (String) DaoEmpresa.RutaLogo;
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
            <table class="table grid">
                <tbody>
                    <tr><td colspan="2" style="">
                <center>
                    <img src="../images/HOSTEL.jpg" alt="" style="alignment-adjust: auto;"/>
                </center>
                </td>
                <td colspan="1" style="">
                <center>
                    <%if (NombreEmpresa == null) {%><h3>Coloca El Nombre de Tu Empresa</h3>
                    <%} else {%><h3><%=NombreEmpresa%></h3><%}%>   
                </center>
                </td>
                <td colspan="2">
                <center>
                    <img src="../images/LOGOIB.png" alt="" style="alignment-adjust: auto;"/>                    
                </center>
                </td> 
                </tr>                    
                </tbody>
            </table>
        </div>        
    </center>
</html>
