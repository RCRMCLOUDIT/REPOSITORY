package model;

import beans.ConexionDB;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Moises Romero
 */
public class DaoOrdenes extends ConexionDB {

    private PreparedStatement pst = null;
    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;

    public DaoOrdenes() {
        super();
    }

    public static ArrayList<ClaseOrdenes> obtenerOrdenes() {
        ArrayList<ClaseOrdenes> lista = new ArrayList<ClaseOrdenes>();
        ConexionDB conn = new ConexionDB();
        conn.Conectar();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.Conectar().prepareCall("CALL MOSTRAR_COMANDAS");
            rs = cs.executeQuery();
            while (rs.next()) {
                ClaseOrdenes comanda = new ClaseOrdenes(rs.getInt("detallepedido.IdDetalle"), rs.getString("mesa.Nombre"), rs.getString("producto.Nombre"), rs.getInt("detallepedido.Cantidad"), rs.getDate("detallepedido.HoraPedido"), rs.getString("detallepedido.Estado"));
                lista.add(comanda);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

}
