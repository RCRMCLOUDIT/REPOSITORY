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
public class DaoFactura extends ConexionDB {

    private PreparedStatement pst = null;
    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static Boolean existe;
    public static Integer IdFactura;

    public DaoFactura() {
        super();
    }

    public void GenerarFactura(int IdCliente, int IdUsuario, int IdPedido, String Observaciones, double SubTotal, double Descuento, double IVA, double Total) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `factura` (IdCliente, IdUsuario, IdPedido, Observaciones, Subtotal, Descuento, Iva, Total ) VALUES(?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdCliente);
            pst.setInt(2, IdUsuario);
            pst.setInt(3, IdPedido);
            pst.setString(4, Observaciones);
            pst.setDouble(5, SubTotal);
            pst.setDouble(6, Descuento);
            pst.setDouble(7, IVA);
            pst.setDouble(8, Total);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean ObtenerIdFactura() {
        existe = false;
        try {
            IdFactura = 0;
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("Select Count(IdFactura) AS IdFactura FROM `factura`");
            if (rs.next()) {
                existe = true;
                IdFactura = rs.getInt("IdFactura");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

}
