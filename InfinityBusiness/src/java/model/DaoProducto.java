package model;

import beans.ConexionDB;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Moises Romero
 */
public class DaoProducto extends ConexionDB {

    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;

    public String Nombre, Descripcion, CodCatalogo, EAN, SKU, UPC, Foto, Iva;
    public int IdUnidad, IdCategoria, TipoProd, IdMarca, StockMin, StockMax;
    public Double CostoCompra, Precio1, Precio2, Precio3, Precio4, Descuento;

    public DaoProducto() {
        super();
    }

    public static ArrayList<Producto> obtenerProductos() {
        ArrayList<Producto> lista = new ArrayList<Producto>();
        ConexionDB conn = new ConexionDB();
        conn.Conectar();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.Conectar().prepareCall("CALL MOSTRAR_PRODUCTOS");
            rs = cs.executeQuery();
            while (rs.next()) {
                Producto producto = new Producto(rs.getInt("IdProducto"), rs.getInt("IdCategoria"), rs.getString("Nombre"), rs.getString("Descripcion"), rs.getString("Foto"), rs.getString("Activo"), rs.getDouble("Precio1"), rs.getDouble("Precio2"), rs.getDouble("Precio3"));
                lista.add(producto);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

    public static ArrayList<Producto> obtenerProductosFiltro(int IdCategoria) {
        ArrayList<Producto> lista = new ArrayList<Producto>();
        ConexionDB conn = new ConexionDB();
        conn.Conectar();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.Conectar().prepareCall("CALL MOSTRAR_PRODUCTOS_FILTRO(" + IdCategoria + ")");
            rs = cs.executeQuery();
            while (rs.next()) {
                Producto producto = new Producto(rs.getInt("IdProducto"), rs.getInt("IdCategoria"), rs.getString("Nombre"), rs.getString("Descripcion"), rs.getString("Foto"), rs.getString("Activo"), rs.getDouble("Precio1"), rs.getDouble("Precio2"), rs.getDouble("Precio3"));
                lista.add(producto);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

    public void AddProducto(int IdUnidad, int TipoProducto, int IdCategoria, int IdMarca, String CodCatalogo, String EAN, String SKU, String UPC, String Nombre, String Descripcion, Double CostoCompra, Double Precio1, Double Precio2, Double Precio3, Double Precio4, Double Descuento, String Iva, int StockMin, int StockMax, String Foto) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO producto (IdUnidad, IdTipoProd, IdCategoria, IdMarca, CodCatalogo, EAN, SKU, UPC, Nombre, Descripcion, CostoCompra, Precio1, Precio2, Precio3, Precio4, Descuento, Iva, StockMin, StockMax, Ubicacion, Activo, Foto)"
                    + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdUnidad);
            pst.setInt(2, TipoProducto);
            pst.setInt(3, IdCategoria);
            pst.setInt(4, IdMarca);
            pst.setString(5, CodCatalogo);
            pst.setString(6, EAN);
            pst.setString(7, SKU);
            pst.setString(8, UPC);
            pst.setString(9, Nombre);
            pst.setString(10, Descripcion);
            pst.setDouble(11, CostoCompra);
            pst.setDouble(12, Precio1);
            pst.setDouble(13, Precio2);
            pst.setDouble(14, Precio3);
            pst.setDouble(15, Precio4);
            pst.setDouble(16, Descuento);
            pst.setString(17, Iva);
            pst.setInt(18, StockMin);
            pst.setInt(19, StockMax);
            pst.setString(20, "Bodega");
            pst.setString(21, "SI");
            pst.setString(22, "imgproductos/" + Foto + "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void UpdateProducto(int IdProducto, String CodCatalogo, String EAN, String SKU, String UPC, String Nombre, String Descripcion, Double CostoCompra, Double Precio1, Double Precio2, Double Precio3, Double Precio4, Double Descuento, String Iva, int StockMin, int StockMax, String Foto) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE producto SET CodCatalogo='" + CodCatalogo + "',  EAN='" + EAN + "', SKU='" + SKU + "', UPC='" + UPC + "', Nombre='" + Nombre + "', Descripcion='" + Descripcion + "', CostoCompra='" + CostoCompra + "', Precio1='" + Precio1 + "', Precio2='" + Precio2 + "', Precio3='" + Precio3 + "', Precio4='" + Precio4 + "', Descuento='" + Descuento + "', Iva='"+Iva+"', StockMin='"+StockMin+"', StockMax='"+StockMax+"',  Foto='imgproductos/" + Foto + "' WHERE IdProducto ='" + IdProducto + "' ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean BuscarProducto(int IdProducto) {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdUnidad, IdTipoProd, IdCategoria, IdMarca, CodCatalogo, EAN, SKU, UPC, Nombre, Descripcion, CostoCompra, Precio1, Precio2, Precio3, Precio4, Descuento, Iva, StockMin, StockMax, Activo, Foto FROM `producto` WHERE IdProducto ='" + IdProducto + "' ");
            if (rs.next()) {
                IdUnidad = rs.getInt("IdUnidad");
                TipoProd = rs.getInt("IdTipoProd");
                IdCategoria = rs.getInt("IdCategoria");
                IdMarca = rs.getInt("IdMarca");
                if (rs.getString("CodCatalogo").equals("")) {
                    CodCatalogo = "-";
                } else {
                    CodCatalogo = rs.getString("CodCatalogo");
                }
                if (rs.getString("EAN") == null) {
                    EAN = "-";
                } else {
                    EAN = rs.getString("EAN");
                }

                if (rs.getString("SKU") == null) {
                    SKU = "-";
                } else {
                    SKU = rs.getString("SKU");
                }

                if (rs.getString("UPC") == null) {
                    UPC = "-";
                } else {
                    UPC = rs.getString("UPC");
                }
                Nombre = rs.getString("Nombre");
                Descripcion = rs.getString("Descripcion");
                CostoCompra = rs.getDouble("CostoCompra");
                Precio1 = rs.getDouble("Precio1");
                Precio2 = rs.getDouble("Precio2");
                Precio3 = rs.getDouble("Precio3");
                Precio4 = rs.getDouble("Precio4");
                Descuento = rs.getDouble("Descuento");
                Iva = rs.getString("Iva");
                StockMin = rs.getInt("StockMin");
                StockMax = rs.getInt("StockMax");
                Foto = rs.getString("Foto");
                existe = true;
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

}
