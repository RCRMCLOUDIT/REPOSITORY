<%-- 
    Document   : TestProducto
    Created on : 03-26-2018, 09:55:19 AM
    Author     : Ing. Moises Romero Mojica
--%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="beans.ConexionDB"%>
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
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Producto Nuevo</title>
    </head>
    <body style="background-color: #4682B4;">
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Nuevo Producto</h1>                
            </center>
        </div>
        <div id="grupoTablas">
            <ul  style="background-color: #4682B4;">
                <li><a href="#tab-1">Datos Producto</a></li>
                <li><a href="#tab-2">Identificacion</a></li>
                <li><a href="#tab-3">Clasificacion</a></li>
                <li><a href="#tab-4">Costo Compra & Precios</a></li>
                <li><a href="#tab-5">Descuento & Iva</a></li>                
                <li><a href="#tab-6">Multimedia</a></li>
            </ul>
            <form id="FormProducto" name="FormProducto" role="form" action="ServletProductoAdd" method="POST" class="form-control">
                <div id="tab-1">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="Nombre" id="Nombre" required="true" size="50" autocomplete="off" placeholder="Ingrese el nombre del Producto...">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Descripcion</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="Descripcion" id="Descripcion" size="50" placeholder="Ingrese una breve Descripcion...">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Tipo Producto</strong></span>
                        <select class="form-control col-sm-4" id="TipoProducto" name="TipoProducto" style="text-align: center">
                            <% // declarando y creando objetos globales 
                                // construyendo forma dinamica 
                                // mandando el sql a la base de datos 
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT IdTipoProd, Nombre, Activo FROM `tipoproducto` WHERE Activo='SI'";
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
                </div>
                <div id="tab-2">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo Catalago#</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodCatalogo" id="CodCatalogo" required="true" size="50" placeholder="Ingrese Codigo Catalogo...">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo EAN</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoEAN" id="CodigoEAN" size="50" placeholder="Ingrese Codigo EAN...">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo SKU</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoSKU" id="CodigoSKU" size="50" placeholder="Ingrese Codigo SKU...">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo UPC</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoUPC" id="CodigoUPC" size="50" placeholder="Ingrese Codigo UPC...">
                    </div>
                </div>
                <div id="tab-3">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-3"><strong>Marca</strong></span>
                        <select class="form-control col-sm-3" id="Marca" name="Marca" style="text-align: center">
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
                    <div class="input-group">
                        <span class="input-group-addon col-sm-3"><strong>Categoria & Tipo Categoria</strong></span>
                        <select class="form-control col-sm-3" id="Categoria" name="Categoria" style="text-align: center">
                            <% // declarando y creando objetos globales 
                                // construyendo forma dinamica 
                                // mandando el sql a la base de datos 
                                try {
                                    ConexionDB conn = new ConexionDB();
                                    conn.Conectar();
                                    String consulta = "SELECT categoriaproducto.IdCategoria, categoriaproducto.Nombre, tipocategoria.Nombre FROM `categoriaproducto` INNER JOIN tipocategoria on categoriaproducto.IdTipoCat=tipocategoria.IdTipoCat";
                                    ResultSet rs = null;
                                    PreparedStatement pst = null;
                                    pst = conn.conexion.prepareStatement(consulta);
                                    rs = pst.executeQuery();
                                    while (rs.next()) {
                                        out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + " | " + rs.getString(3) + " </option>");
                                    }; // fin while 
                                } //fin try no usar ; al final de dos o mas catchs 
                                catch (SQLException e) {
                                };
                                //}; 
                            %>
                        </select>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-3"><strong>Unidad Medida</strong></span>
                        <select class="form-control col-sm-3" id="UnidadMedida" name="UnidadMedida" style="text-align: center">
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
                </div>
                <div id="tab-4">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Costo Compra</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="CostoCompra" name="CostoCompra" min="0" required="true" placeholder="Costo Compra..." style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 1</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio1" name="Precio1" min="0" required="true" placeholder="Precio Venta..." style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 2</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio2" name="Precio2" min="0" placeholder="Precio Venta..." style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 3</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio3" name="Precio3" min="0" placeholder="Precio Venta..." style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 4</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio4" name="Precio4" min="0" placeholder="Precio Venta..." style="text-align: center">
                    </div>                    
                </div>
                <div id="tab-5">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Descuento</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="Descuento" name="Descuento" min="0" placeholder="Ingresar % Descuento..." style="text-align: center">
                        <span class="input-group-addon col-sm-1"><strong>%</strong></span>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Iva</strong></span>
                        <label class="form-control radio-inline col-sm-3" style="text-align: center;">
                            <input type="radio" required="true" name="optradio" value="No">No
                            <input type="radio" required="true" name="optradio" value="Si">Si
                        </label>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Stock Minimo</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="StockMin" name="StockMin" min="0" placeholder="Ingresar Stock Minimo..." required="true" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Stock Maximo</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="StockMax" name="StockMax" min="0" placeholder="Ingresar Stock Maximo..." required="true" style="text-align: center">
                    </div>
                </div>
                <div id="tab-6">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Foto</strong></span>                        
                        <input type="file" class="form-control col-sm-4" id="Foto" name="Foto" style="text-align: center">
                    </div> 
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
        </div>
    </body>
</html>
