<%-- 
    Document   : ListarProducto
    Created on : 10-18-2016, 12:03:17 PM
    Author     : Moises Romero
--%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletUnidadMedida"%>
<%@page import="controller.ServletProductoAdd"%>
<%@page import="java.sql.SQLException"%>
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
        <script type="text/javascript"><%--FUNCION PARA RECOGER LOS DATOS DE LA VENTANA MODAL Y ENVIARLOS AL SERVLET.--%>
            $(document).ready(function () {
                $('#btnAgregar').click(function () {
                    var nombre = $('#form-AddProd').val();
                    var descripcion = $('#form-Descripcion').val();
                    var codigoEan = $('#form-codigoEan').val();
                    var codigoSku = $('#form-codigoSku').val();
                    var codigoUpc = $('#form-codigoUpc').val();
                    var marca = $('#form-Marca').val();
                    var tipocat = $('#form-TipoCat').val();
                    var categoria = $('#form-Categoria').val();
                    var unidad = $('#form-Unidad').val();
                    var precio1 = $('#form-Precio1').val();
                    var precio2 = $('#form-Precio2').val();
                    var precio3 = $('#form-Precio3').val();
                    var path = $('#form-Foto').val();
                    var foto = path.match(/[-_\w]+[.][\w]+$/i)[0];
                    $.ajax({
                        type: 'POST',
                        data: {Producto: nombre, Descripcion: descripcion, CodigoEAN: codigoEan,
                            CodigoSKU: codigoSku, CodigoUPC: codigoUpc, Marca: marca,
                            TipoCat: tipocat, Categoria: categoria, Unidad: unidad,
                            Precio1: precio1, Precio2: precio2, Precio3: precio3, Foto: foto},
                        url: '../ServletProductoAdd',
                        success: function (response) {
                            //utilzar response
                            $('#Agregar').modal('hide');
                            location.reload(true);
                        }
                    });
                });
            });
        </script>
        <title>Producto</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body>
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Listado de Productos</h1>                
            </center>
        </div>
        <section id="lista" class="container left">
            <form id="FormBuscar" role="form" action="#">
                <div class="input-group">
                    <span class="input-group-addon">
                        <select>
                            <option value="">Nombre</option>
                            <option value="">Descripcion</option>
                            <option value="">Cod Catalago</option>
                            <option value="">EAN</option>
                            <option value="">SKU</option>
                            <option value="">UPC</option>
                        </select>
                    </span>
                    <input id="filtro" name="filtro" type="text" value='' class="form-control col-sm-6" placeholder="Ingresa Dato a Buscar..." required="true">
                    <button class="btn btn-primary" id="Buscar" type="#">Buscar</button>
                    <a href="AgregaProducto.jsp" class="btn btn-primary">Agregar</a>
                </div>
            </form>
            <div class="panel-body left">
                <table class="table left table-hover" id="tblProducto">
                    <thead style="background-color: #4682B4">
                        <tr>
                            <th style="color: #FFFFFF; text-align: center;">Id</th>
                            <th style="color: #FFFFFF; text-align: center;">Producto</th>
                            <th style="color: #FFFFFF; text-align: center;">Descripcion</th>
                            <th style="color: #FFFFFF; text-align: center;">Cant. Disponible</th>
                            <th style="color: #FFFFFF; text-align: center;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody style="background-color: #FACC2E;">
                        <% // declarando y creando objetos globales 
                            //Integer cod = DaoLogin.IdUsuario;
                            // construyendo forma dinamica 
                            // mandando el sql a la base de datos 
                            try {

                                ConexionDB conn = new ConexionDB();
                                conn.Conectar();
                                String consulta = "SELECT producto.IdProducto, producto.Nombre, producto.Descripcion, inventario.CantDisponible  FROM `producto` INNER JOIN inventario on inventario.IdProducto=producto.IdProducto Order By producto.IdProducto";
                                ResultSet rs = null;
                                PreparedStatement pst = null;
                                pst = conn.conexion.prepareStatement(consulta);
                                rs = pst.executeQuery();
                                while (rs.next()) {
                                    out.println("<TR style='text-align: center;'>");
                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getInt(1) + "</TD>");
                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(2) + "</TD>");
                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(3) + "</TD>");
                                    out.println("<TD style='color: #FFFFFF;'>" + rs.getString(4) + "</TD>");
                                    out.println("<TD>"
                                            + "<a href='ActualizaProducto.jsp?idProd=" + rs.getInt(1) + "' class='btn btn-primary'>Editar ó Ver</a>"
                                            + "</TD>");
                                    out.println("</TR>");
                                }; // fin while // LE QUITE ESTO A LAS PROPIEDADES DEL BOTON class='btn btn-primary'
                            } //fin try no usar ; al final de dos o mas catchs 
                            catch (SQLException e) {
                            };
                            //}; 
                        %>
                    </tbody>
                </table>                            
            </div>                        

        </section>
        <%--VENTANA MODAL PARA AGREGAR UN NUEVO PRODUCTO --%>
    <center>
        <div class="modal fade" id="Agregar" tabindex="-1" role="dialog" aria-labelbody="mymodallabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                        <h4>Agregando un Producto</h4>
                    </div>
                    <div class="modal-body">
                        <form id="FormProducto" role="form" action="ServletProductoAdd" method="POST" class="form-control">
                            <div class="form-control">
                                <label for="AddProd">Nombre</label>
                                <input type="text" class="form-control" id="form-AddProd" name="form-AddProd" placeholder="Nombre...">   
                            </div>
                            <div class="form-control">
                                <label for="Descripcion">Descripcion</label>
                                <input type="text" class="form-control" id="form-Descripcion" name="form-Descripcion" placeholder="Descripcion...">   
                            </div>
                            <div class="form-control">
                                <label for="codigoEan">Codigo EAN</label>
                                <input type="text" class="form-control" id="form-codigoEan" name="form-codigoEan" placeholder="CodigoEAN...">   
                            </div>                            
                            <div class="form-control">
                                <label for="codigoSku">Codigo SKU</label>
                                <input type="text" class="form-control" id="form-codigoSku" name="form-codigoSku" placeholder="CodigoSKU...">   
                            </div>           
                            <div class="form-control">
                                <label for="codigoUpc">Codigo UPC</label>
                                <input type="text" class="form-control" id="form-codigoUpc" name="form-codigoUpc" placeholder="CodigoUPC...">   
                            </div>                                  
                            <div class="form-control">
                                <label for="Marca">Selecciona Marca:</label>
                                <select class="form-control" id="form-Marca" name="form-Marca">
                                    <% // declarando y creando objetos globales 
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT IdMarca, Nombre FROM `marca` WHERE Activo='SI'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>                            
                            <div class="form-control">
                                <label for="TipoCat">Selecciona Tipo Categoria:</label>
                                <select class="form-control" id="form-TipoCat" name="form-TipoCat">
                                    <%  try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT IdTipoCat, Nombre FROM `tipocategoria` WHERE Activo='SI'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>
                            <div class="form-control">
                                <label for="Categoria">Selecciona Categoria:</label>
                                <select class="form-control" id="form-Categoria" name="form-Categoria">
                                    <% // declarando y creando objetos globales 
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT IdCategoria, Nombre FROM `categoriaproducto` WHERE Activo='SI'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
                                    %>
                                </select>
                            </div>
                            <div class="form-control">
                                <label for="Unidad">Selecciona Unidad:</label>
                                <select class="form-control" id="form-Unidad" name="form-Unidad">
                                    <% // declarando y creando objetos globales 
                                        // construyendo forma dinamica 
                                        // mandando el sql a la base de datos 
                                        try {
                                            ConexionDB conn = new ConexionDB();
                                            conn.Conectar();
                                            String consulta = "SELECT IdUnidad, Nombre FROM `tipounidad` WHERE Activo='SI'";
                                            ResultSet rs = null;
                                            PreparedStatement pst = null;
                                            pst = conn.conexion.prepareStatement(consulta);
                                            rs = pst.executeQuery();
                                            while (rs.next()) {
                                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + "</option>");
                                            }; // fin while 
                                        } //fin try no usar ; al final de dos o mas catchs 
                                        catch (SQLException e) {
                                        };
                                        //}; 
%>
                                </select>
                            </div>
                            <div class="form-control">
                                <label for="Precio1">Precio 1:</label>
                                <input type="number" step="any" class="form-control" id="form-Precio1" name="form-Precio1" placeholder="Precio1...">   
                            </div>                
                            <div class="form-control">
                                <label for="Precio2">Precio 2:</label>
                                <input type="number" step="any" class="form-control" id="form-Precio2" name="form-Precio2" placeholder="Precio2...">   
                            </div>
                            <div class="form-control">
                                <label for="Precio3">Precio 3:</label>
                                <input type="number" step="any" class="form-control" id="form-Precio3" name="form-Precio3" placeholder="Precio3...">   
                            </div>                            
                            <div class="form-control">
                                <label for="Foto">Seleciona una Foto:</label>
                                <input type="file" class="form-control" id="form-Foto" name="form-Foto" placeholder="Foto...">
                            </div>                            
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-primary" id="btnAgregar" >Agregar</button>
                    </div>
                </div>
            </div>
        </div>
    </center> <%--FIN VENTANA MODAL PARA AGREGAR UN NUEVO PRODUCTO --%>
</body>
</html>