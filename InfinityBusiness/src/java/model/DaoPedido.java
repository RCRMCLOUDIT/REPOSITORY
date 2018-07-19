package model;

import beans.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Moises Romero
 */
public class DaoPedido extends ConexionDB {

    private PreparedStatement pst = null;
    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static Integer IdProducto = 0, IdPedido = 0, IdMesa = 0, Cantidad = 0;
    public static Integer IdMesaHab = 0;
    public static String Tipo = "";
    public static double Precio = 0.00, Precio1 = 0.00, Precio2 = 0.00, Precio3 = 0.00, DescTEMP = 0.00;
    public static Boolean existe;

    public DaoPedido() {
        super();
    }

    public boolean validarId(String Producto) {
        existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdProducto, Nombre, Precio1, Precio2, Precio3 FROM producto WHERE Nombre='" + Producto + "'");
            if (rs.next()) {
                existe = true;
                IdProducto = rs.getInt("IdProducto");
                Precio1 = rs.getDouble("Precio1");
                Precio2 = rs.getDouble("Precio2");
                Precio3 = rs.getDouble("Precio3");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean validarPedido(int IdMesa) {
        existe = false;
        IdPedido = 0;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdPedido, IdMesa FROM Pedido WHERE Estado='Abierto' AND IdMesa=" + IdMesa + "");
            if (rs.next()) {
                existe = true;
                IdPedido = rs.getInt("IdPedido");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean BuscarPrecio(int IdProducto) {
        existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT Precio1, Precio2, Precio3 FROM producto WHERE IdProducto=" + IdProducto + "");
            if (rs.next()) {
                existe = true;
                Precio1 = rs.getDouble("Precio1");
                Precio2 = rs.getDouble("Precio2");
                Precio3 = rs.getDouble("Precio3");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public void AgregaPedido(int IdMesa, int IdHab, int IdFactura) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `pedido` (IdMesa, IdHab, IdFactura, Estado) VALUES(?,?,?,?)");
            pst.setInt(1, IdMesa);
            pst.setInt(2, IdHab);
            pst.setInt(3, IdFactura);
            pst.setString(4, "Abierto");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void ActualizaPedido(int IdPedido) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE pedido SET Estado='Cerrado' WHERE IdPedido=" + IdPedido + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void AgregaDetallePedido(int IdPedido, int IdProducto, int Cantidad, Double Precio, Double Descuento, Double Iva) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `detallepedido` (IdPedido, IdProducto, Cantidad, Estado, Precio, Subtotal, Descuento, Iva) VALUES(?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdPedido);
            pst.setInt(2, IdProducto);
            pst.setInt(3, Cantidad);
            pst.setString(4, "Preparando");
            pst.setDouble(5, Precio);
            pst.setDouble(6, (Cantidad * Precio));
            pst.setDouble(7, Descuento);
            pst.setDouble(8, Iva);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void ActualizaDetallePedido(int IdDetalle) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE detallepedido SET Estado='Servido' WHERE IdDetalle=" + IdDetalle + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    // FUNCION PARA BUSCAR DATOS DEL DETALLE DEL PEDIDO
    public boolean BuscarDetallePedido(int IdDetPed) {
        existe = false;
        Cantidad = 0;
        Precio = 0.00;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdDetalle, IdPedido, IdProducto, Cantidad, Precio, Subtotal FROM detallepedido WHERE IdDetalle=" + IdDetPed + "");
            if (rs.next()) {
                existe = true;
                IdProducto = rs.getInt("IdProducto");
                Cantidad = rs.getInt("Cantidad");
                Precio = rs.getDouble("Precio");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    // FUNCION PARA ACTUALIZAR EL DETALLE DEL PEDIDO MAS CANTIDADES O MENOS
    public void ActulizaDetalle(int IdDetalle, int Cantidad, Double SubTotal) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE detallepedido SET Cantidad='" + Cantidad + "', Subtotal='" + SubTotal + "' WHERE IdDetalle=" + IdDetalle + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    // FUNCION PARA CANCELAR EL DETALLE DEL PEDIDO MAS CANTIDADES O MENOS
    public void CancelarDetalle(int IdDetalle) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("DELETE FROM `detallepedido` WHERE IdDetalle=" + IdDetalle + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    // FUNCION PARA BUSCAR DATOS DEL DESCUENTO TEMPORAL
    public boolean BuscarDescuentoTEMP(int ID) {
        existe = false;
        DescTEMP = 0.00;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdMesaHab, Tipo, Descuento FROM `TempDescuento` WHERE IdMesaHab=" + ID + " ");
            if (rs.next()) {
                existe = true;
                IdMesaHab = rs.getInt("IdMesaHab");
                Tipo = rs.getString("Tipo");
                DescTEMP = rs.getDouble("Descuento");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    // FUNCION PARA AGREGAR DATOS DEL DESCUENTO TEMPORAL
    public void AddDescuentoTEMP(int IdMesa, String Tipo, Double Descuento) throws SQLException {
        existe = false;
        DescTEMP = 0.00;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO TempDescuento (IdMesaHab, Tipo, Descuento) VALUES(?,?,?)");
            pst.setInt(1, IdMesa);
            pst.setString(2, Tipo);
            pst.setDouble(3, Descuento);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    // FUNCION PARA ACTUALIZAR DATOS DEL DESCUENTO TEMPORAL
    public void UpdateDescuentoTEMP(int IdMesa, Double Descuento, String Tipo) throws SQLException {
        existe = false;
        DescTEMP = 0.00;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE TempDescuento set Descuento='" + Descuento + "' WHERE IdMesaHab=" + IdMesa + " AND Tipo=" + Tipo + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    // FUNCION PARA ACTUALIZAR DATOS DEL DESCUENTO TEMPORAL
    public void DeleteDescuentoTEMP(int IdMesa, String Tipo) throws SQLException {
        existe = false;
        DescTEMP = 0.00;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("DELETE FROM TempDescuento WHERE IdMesaHab=" + IdMesa + " AND Tipo=" + Tipo + " ");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }
}
