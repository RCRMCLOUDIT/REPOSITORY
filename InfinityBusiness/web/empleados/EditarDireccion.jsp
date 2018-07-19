<%-- 
    Document   : EditarDireccion
    Created on : 05-17-2018, 02:19:59 PM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int Id = Integer.parseInt(request.getParameter("id"));
    String Tipo = request.getParameter("Tipo");
    String Direccion = request.getParameter("Direccion");
    String Departamento = request.getParameter("Departamento");
    String FechaAlta = request.getParameter("FechaAlta");
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
        <title>Editar Direccion</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Editando Direccion</h1>                
            </center>
        </div>
        <form id="AddEmpleado" role='form' action='../ServletEmpleado' method='POST'>
            <div class="input-group">
                <span class="input-group-addon col-sm-2"><strong>Tipo</strong></span>                                
                <select class="form-control col-sm-1" id="TipoDireccion" name="TipoDireccion" required="true">
                    <option>Casa</option>
                    <option>Oficina</option>
                    <option>Enviar A</option>
                    <option>Facturar A</option>
                </select>                                                        
            </div>
            <div class="input-group">
                <span class="input-group-addon col-sm-2"><strong>Departamento</strong></span>
                <input id="form-Departamento" name="form-Departamento" type="text" class="form-control col-sm-4" maxlength="250" style="text-align: center" value="<%=Departamento%>">
            </div>
            <div class="input-group">
                <span class="input-group-addon col-sm-2"><strong>Direccion</strong></span>
                <input id="form-Direccion" name="form-Direccion" type="text" class="form-control col-sm-6" maxlength="250" style="text-align: center" required="true" value="<%=Direccion%>">
            </div>            
            <div class="input-group">
                <span class="input-group-addon col-sm-2"><strong>Fecha Alta</strong></span>
                <input type="text" class="form-control col-sm-2" name="FechaAlta" id="FechaAlta" style="text-align: center" required="true"  readonly="true" value="<%=FechaAlta%>">
                <span class="input-group-addon col-sm-2"><strong>Fecha Baja</strong></span>
                <input type="text" class="form-control col-sm-2" name="FechaBaja" id="FechaBaja" style="text-align: center" readonly="true">
            </div>
            <br>
            <div class="row form-group">
                <div class="col-sm-3"> </div>
                <div class="col-sm-offset-3 col-sm-3">
                    <button type='button' onclick='history.go(-1);return false;' class='btn btn-primary'><< Volver</button>
                    <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                </div>
            </div>                    
        </form>
        <script type="text/javascript">
            $('#FechaAlta').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "1950:2018",
                pickTime: true,
                autoclose: true
            });
        </script>      
        <script type="text/javascript">
            $('#FechaBaja').datepicker({
                //dateFormat: "dd/mm/yy",
                dateFormat: "dd-mm-yy",
                language: "es",
                changeYear: true,
                changeMonth: true,
                yearRange: "2018:2050",
                pickTime: true,
                autoclose: true
            });
        </script>  
    </body>
</html>


