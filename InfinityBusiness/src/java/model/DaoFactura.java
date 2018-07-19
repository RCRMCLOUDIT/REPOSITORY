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

    public void GenerarFactura(int IdCliente, String NombreCliente, int IdUsuario, int IdPedido, String Observaciones, String ComentariosCliente, String ComentariosInternos, double SubTotal, double Descuento, double IVA, double Total, String FechaFactura) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `facturacion` (IdCliente, NombreCliente, IdUsuario, IdPedido, Observaciones, ComentariosCliente, ComentariosInternos, Subtotal, Descuento, Iva, Total, FechaFactura) VALUES(?,?,?,?,?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdCliente);
            pst.setString(2, NombreCliente);
            pst.setInt(3, IdUsuario);
            pst.setInt(4, IdPedido);
            pst.setString(5, Observaciones);
            pst.setString(6, ComentariosCliente);
            pst.setString(7, ComentariosInternos);
            pst.setDouble(8, SubTotal);
            pst.setDouble(9, Descuento);
            pst.setDouble(10, IVA);
            pst.setDouble(11, Total);
            pst.setString(12, FechaFactura);
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
            rs = st.executeQuery("Select Count(IdFactura) AS IdFactura FROM `Facturacion`");
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
