<%-- 
    Document   : TestConexion
    Created on : 04-13-2018, 11:12:08 AM
    Author     : Ing. Moises Romero Mojica
--%>

<%@page import="java.sql.Connection"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.*"%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    Connection conn = null;

    /*CONNECCION*/
    String servidor = "192.168.0.20";
    String base = "cloud.pos";
    String userSQL = "rcromero";
    String pass = "Rcromero1082+";
    String sUrl = "";
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Test Conexion</h1>
        <div class="input-group">
            <%
                try {
                    Class.forName("com.mysql.jdbc.Driver");
                    sUrl = "jdbc:mysql://localhost:3306/cloud.pos";
                    conn = DriverManager.getConnection(sUrl, userSQL, pass);
                } catch (ClassNotFoundException ex) {
            %>
            <TR>
                <TD colspan="10" class="textRed">Error1 en la Conexion con la BD: <%=ex.getMessage()%></TD>
            </TR>	
            <%
                conn = null;
            } catch (SQLException ex) {
            %>
            <TR>
                <TD colspan="10" class="textRed">Error2 en la Conexion con la BD: <%=ex.getMessage()%> Codigo: <%=ex.getErrorCode()%> SQL STATE: <%=ex.getSQLState()%></TD>
            </TR>	
            <%
                conn = null;
            } catch (Exception ex) {
            %>
            <TR>
                <TD colspan="10" class="textRed">Error3 en la Conexion con la BD: <%=ex.getMessage()%></TD>
            </TR>	
            <%
                conn = null;
            } finally {
                if (conn != null) {
            %>        
            <span class="input-group-addon col-sm-3"><strong>Categoria & Tipo Categoria</strong></span>
            <select class="form-control col-sm-3" id="Categoria" name="Categoria" style="text-align: center">
                <% // declarando y creando objetos globales 
                        // construyendo forma dinamica 
                        // mandando el sql a la base de datos 
                        try {
                            //Class.forName("com.mysql.jdbc.Driver");
                            //String url = "jdbc:mysql://localhost:3306/cloud.pos?user=rcromero&password=Rcromero1082+";
                            //conn = DriverManager.getConnection(url);
                            String consulta = "SELECT categoriaproducto.IdCategoria, categoriaproducto.Nombre, tipocategoria.Nombre FROM `categoriaproducto` INNER JOIN tipocategoria on categoriaproducto.IdTipoCat=tipocategoria.IdTipoCat";
                            ResultSet rs = null;
                            PreparedStatement pst = null;
                            pst = conn.prepareStatement(consulta);
                            rs = pst.executeQuery();
                            while (rs.next()) {
                                out.println("<option value='" + rs.getInt(1) + "'>" + rs.getString(2) + " | " + rs.getString(3) + " </option>");
                            }; // fin while 
                        } //fin try no usar ; al final de dos o mas catchs 
                        catch (SQLException e) {
                        };
                    }
                %>
            </select>
            <%
                }  //if(conn!=null)
            %>            
        </div>
    </body>
</html>
