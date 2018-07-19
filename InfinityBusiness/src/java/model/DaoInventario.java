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
public class DaoInventario extends ConexionDB {

    private PreparedStatement pst = null;
    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static Boolean existe;
    public static double Disponible = 0.00, Fisicas = 0.00, Reserva = 0.00, CostoProm = 0.00;

    //ID TIPO DE MOVIMIENTOS DE INVENTARIO
    //---1 ENTRADA //---2 SALIDA //---3 AJUSTE //---4 TRASLADO
    public DaoInventario() {
        super();
    }

    public boolean ValidaExistencias(int IdProducto) {
        existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT CantDisponible, CantFisicas, CantReserva FROM inventario WHERE IdProducto='" + IdProducto + "'");
            if (rs.next()) {
                existe = true;
                Disponible = rs.getDouble("CantDisponible");
                Fisicas = rs.getDouble("CantFisicas");
                Reserva = rs.getDouble("CantReserva");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean ValidaCosto(int IdProducto) {
        existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT CostoPromedio FROM producto WHERE IdProducto='" + IdProducto + "'");
            if (rs.next()) {
                existe = true;
                CostoProm = rs.getDouble("CostoPromedio");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public void AddEntrada(int IdProducto, double Cantidad, double StockInicial, double StockFinal, double Costo) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO movimientoinventario (IdTipoMov, IdProducto, Cantidad, StockInicial, StockFinal, Costo) VALUES(?,?,?,?,?,?)");
            pst.setInt(1, 1);
            pst.setInt(2, IdProducto);
            pst.setDouble(3, Cantidad);
            pst.setDouble(4, StockInicial);
            pst.setDouble(5, StockFinal);
            pst.setDouble(6, Costo);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void AddSalida(int IdProducto, double Cantidad, double StockInicial, double StockFinal, double Costo) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO movimientoinventario (IdTipoMov, IdProducto, Cantidad, StockInicial, StockFinal, Costo) VALUES(?,?,?,?,?,?)");
            pst.setInt(1, 2);
            pst.setInt(2, IdProducto);
            pst.setDouble(3, Cantidad);
            pst.setDouble(4, StockInicial);
            pst.setDouble(5, StockFinal);
            pst.setDouble(6, Costo);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

}
