<%-- 
    Document   : UpdateCliente
    Created on : 11-13-2017, 09:41:52 PM
    Author     : Ing. Moises Romero Mojica
--%>

<%@page import="model.DaoCliente"%>
<%@page import="controller.ServletCliente"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
        <title>Datos Cliente</title>
    </head>
    <body style="background-color: #1AAE88">
    <Center><h1> <strong>Editar Datos Cliente</strong></h1></Center>
    <div id="cuerpo">
        <form id="updateCliente" method="POST" action="../ServletCliente">
            <%
                int cod = Integer.parseInt(request.getParameter("idCli"));
                DaoCliente datos = new DaoCliente();
                datos.BuscarCliente(cod);
                String Ruc, DNI, Nombre, Apellido, Email, Telefono, Movil, Direccion, Sexo;
                Ruc = datos.Ruc;
                DNI = datos.DNI;
                Nombre = datos.Nombre;
                Apellido = datos.Apellido;
                Email = datos.Email;
                Sexo = datos.Sexo;
                Telefono = datos.Telefono;
                Movil = datos.Movil;
                Direccion = datos.Direccion;
            %>
            <Center>
                <Table class="table-responsive bg-info">
                    <tr>
                        <td>
                            <strong>Nombre: </strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <input type="text" name="Nombre" id="Nombre" required="true" size="50" value="<%=Nombre%>">
                            <input type="text" name="IdCli" id="IdCli" value="<%=cod%>" hidden="true">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Apellido: </strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <input type="text" name="Apellido" id="Apellido" required="true" size="50" value="<%=Apellido%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>N° RUC:</strong>
                        </td>
                        <td>
                            <input type="text" name="Ruc" id="Ruc" size="15" value="<%=Ruc%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Cedula:</strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <input type="text" name="DNI" id="DNI" size="15" required="true" value="<%=DNI%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Sexo:</strong><span style="color: red">*</span>
                        </td> 
                        <td>
                            <select name="Sexo" id="Sexo" required="true">
                                <% if (Sexo.equals("M")) {%>
                                <option>Masculino</option>
                                <option>Femenino</option>
                                <%} else {%>
                                <option>Femenino</option>
                                <option>Masculino</option>
                                <%}%>
                            </select>
                        </td> 
                    </tr>
                    <tr>
                        <td>
                            <strong>Direccion:</strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <input type="text" name="Direccion" id="Direccion" required="true" size="100" value="<%=Direccion%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Telefono:</strong><span style="color: red">*</span>
                        </td>
                        <td>
                            <input type="text" name="Telefono" id="Telefono" required="true" size="15" onkeypress="return valida(event)" value="<%= Telefono%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Movil:</strong>
                        </td>
                        <td>
                            <input type="text" name="Movil" id="Movil" size="15" onkeypress="return valida(event)" value="<%= Movil%>">
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <strong>Email:</strong>
                        </td>
                        <td>
                            <input type="email" name="Email" id="Email" size="50" value="<%=Email%>"><strong>Ejemplo@alguien.hotmail.com</strong>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <input type="text" name="Accion" id="Accion" value="Update" hidden="true">
                        </td>
                        <td>
                            <a href="ListadoClientes.jsp" class="btn btn-primary">Volver</a>
                            <button type='submit' class='btn btn-primary' name="guardar" id="guardar">Guardar</button>
                        </td>
                    </tr>
                </Table>
            </Center>
        </form>    
    </div>
</body>
</html>
