<%-- 
    Document   : ActualizaProducto
    Created on : 08-23-2017, 09:11:28 PM
    Author     : Moises Romero
--%>
<%@page import="model.DaoProducto"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="beans.ConexionDB"%>
<%@page import="controller.ServletProductoUpdate"%>
<%@page import="java.sql.SQLException"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    int idProd = Integer.parseInt(request.getParameter("idProd"));
    String Nombre, Descripcion, CodCatalogo, EAN, SKU, UPC, Iva, Foto;
    int IdUnidad, IdCategoria, IdMarca, IdTipoProd, StockMin, StockMax;
    Double CostoCompra, Precio1, Precio2, Precio3, Precio4, Descuento;

    DaoProducto producto = new DaoProducto();
    producto.BuscarProducto(idProd);
    Nombre = producto.Nombre;
    Descripcion = producto.Descripcion;
    CodCatalogo = producto.CodCatalogo;
    EAN = producto.EAN;
    UPC = producto.UPC;
    SKU = producto.SKU;
    Foto = producto.Foto;
    IdUnidad = producto.IdUnidad;
    IdCategoria = producto.IdCategoria;
    IdMarca = producto.IdMarca;
    IdTipoProd = producto.TipoProd;
    CostoCompra = producto.CostoCompra;
    Precio1 = producto.Precio1;
    Precio2 = producto.Precio2;
    Precio3 = producto.Precio3;
    Precio4 = producto.Precio4;
    Descuento = producto.Descuento;
    Iva = producto.Iva;
    StockMin = producto.StockMin;
    StockMax = producto.StockMax;
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
        <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
        <script>
            $(function () {
                $("#grupoTablas").tabs();
            });
        </script>
        <title>Informacion del Producto</title>
    </head>
    <%@include file="../commons/Menu.jsp" %>
    <body style="background-color: #4682B4;">
        <div id="EncabezadoPagina" style="background-color: #4682B4;">
            <center>
                <h1 style="color: #FFFFFF; text-align: center;">Informacion del Producto</h1>                
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
            <form id="FormProducto" name="FormProducto" role="form" action="../ServletProductoUpdate" method="POST" class="form-control">
                <div id="tab-1">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Nombre</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="NombreProducto" id="NombreProducto" required="true" size="50" autocomplete="off" value="<%= Nombre%>">
                        <input type="text" name="IdProducto" id="IdProducto" value="<%= idProd%>" hidden="true">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Descripcion</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="Descripcion" id="Descripcion" size="50" value="<%=Descripcion%>">
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
                                    String consulta = "SELECT IdTipoProd, Nombre, Activo FROM `tipoproducto` WHERE Activo='SI' AND IdTipoProd='" + IdTipoProd + "'";
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
                        <input type="text" class="form-control col-sm-4" name="CodCatalogo" id="CodCatalogo" required="true" size="50" value="<%=CodCatalogo%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo EAN</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoEAN" id="CodigoEAN" size="50" value="<%=EAN%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo SKU</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoSKU" id="CodigoSKU" size="50" value="<%=SKU%>">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Codigo UPC</strong></span>                        
                        <input type="text" class="form-control col-sm-4" name="CodigoUPC" id="CodigoUPC" size="50" value="<%=UPC%>">
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
                                    String consulta = "SELECT IdMarca, Nombre FROM `marca` WHERE Activo='SI' AND IdMarca='" + IdMarca + "'";
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
                                    String consulta = "SELECT categoriaproducto.IdCategoria, categoriaproducto.Nombre, tipocategoria.Nombre FROM `categoriaproducto` INNER JOIN tipocategoria on categoriaproducto.IdTipoCat=tipocategoria.IdTipoCat WHERE categoriaproducto.Activo='Si' AND categoriaproducto.IdCategoria='" + IdCategoria + "'";
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
                                    String consulta = "SELECT IdUnidad, Nombre FROM `tipounidad` WHERE Activo='SI' AND IdUnidad='" + IdUnidad + "'";
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
                        <input type="number" step="any" class="form-control col-sm-4" id="CostoCompra" name="CostoCompra" min="0" value="<%=CostoCompra%>" required="true" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 1</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio1" name="Precio1" min="0" value="<%=Precio1%>" required="true" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 2</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio2" name="Precio2" min="0" value="<%=Precio2%>" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 3</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio3" name="Precio3" min="0" value="<%=Precio3%>" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Precio Venta 4</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-4" id="Precio4" name="Precio4" min="0" value="<%=Precio4%>" style="text-align: center">
                    </div>                    
                </div>
                <div id="tab-5">
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Descuento</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="Descuento" name="Descuento" min="0" value="<%=Descuento%>" style="text-align: center">
                        <span class="input-group-addon col-sm-1"><strong>%</strong></span>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Iva</strong></span>
                        <label class="form-control radio-inline col-sm-3" style="text-align: center;">
                            <%if (Iva.equals("No")) {%>
                            <input type="radio" required="true" name="Iva" value="No" checked="true">No
                            <input type="radio" required="true" name="Iva" value="Si">Si
                            <%} else {%>
                            <input type="radio" required="true" name="Iva" value="No">No
                            <input type="radio" required="true" name="Iva" value="Si" checked="true">Si
                            <%}%>
                        </label>
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Stock Minimo</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="StockMin" name="StockMin" min="0" value="<%=StockMin%>"  required="true" style="text-align: center">
                    </div>
                    <div class="input-group">
                        <span class="input-group-addon col-sm-2"><strong>Stock Maximo</strong></span>                        
                        <input type="number" step="any" class="form-control col-sm-3" id="StockMax" name="StockMax" min="0" value="<%=StockMax%>" required="true" style="text-align: center">
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
                        <%--  <a href="../producto/ListarProducto.jsp" class="btn btn-primary"><< Volver</a> --%>
                        <button type='button' onclick='history.go(-1);return false;' class='btn btn-primary'><< Volver</button>
                        <button type="submit" class="btn btn-primary" id="btnAgregar" name="btnAgregar" >Guardar</button>
                    </div>
                </div>
            </form>
        </div>
    </body>
</html>
