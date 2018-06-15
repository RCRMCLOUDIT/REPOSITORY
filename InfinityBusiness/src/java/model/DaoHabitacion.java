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
public class DaoHabitacion extends ConexionDB {

    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;
    
    public String Nombre, NumeroHab, TipoHab, MaxPersonas, Precio;

    public DaoHabitacion() {
        super();
    }

    public static ArrayList<Habitaciones> obtenerHabsAct() {
        ArrayList<Habitaciones> lista = new ArrayList<Habitaciones>();
        ConexionDB conn = new ConexionDB();
        conn.Conectar();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.Conectar().prepareCall("CALL MOSTRAR_HAB");
            rs = cs.executeQuery();
            while (rs.next()) {
                Habitaciones hab = new Habitaciones(rs.getInt("IdHab"), rs.getString("TipoHabitacion"), rs.getString("Nombre"), rs.getInt("NumeroHab"), rs.getString("Descripcion"), rs.getDouble("Precio"), rs.getString("Estado"), rs.getString("Activo"));
                lista.add(hab);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

    public void AddTipoHab(String Nombre, String Descripcion, double Precio) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `tipohab` (Nombre, Descripcion, Precio, Activo) VALUES(?,?,?,?)");
            pst.setString(1, Nombre);
            pst.setString(2, Descripcion);
            pst.setDouble(3, Precio);
            pst.setString(4, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void AddHabitacion(int IdTipoHab, String Nombre, String Descripcion, double Precio) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `habitaciones` (IdTipoHab, Nombre, Descripcion, Precio, Estado, Activo) VALUES(?,?,?,?,?,?)");
            pst.setInt(1, IdTipoHab);
            pst.setString(2, Nombre);
            pst.setString(3, Descripcion);
            pst.setDouble(4, Precio);
            pst.setString(5, "Libre");
            pst.setString(6, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean BuscarDatosHabitacion(int IdHab) {
        existe = false;

        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT habitaciones.Nombre, habitaciones.NumeroHab, tipohab.Nombre, tipohab.MaxPersonas, habitaciones.Precio\n"
                    + "FROM tipohab INNER JOIN habitaciones ON tipohab.IdTipoHab=habitaciones.IdTipoHab\n"
                    + "WHERE habitaciones.Activo='Si' AND habitaciones.IdHab='" + IdHab + "'");
            if (rs.next()) {
                //existe = true;
                Nombre = rs.getString(1);
                NumeroHab = rs.getString(2);
                TipoHab = rs.getString(3);
                MaxPersonas = rs.getString(4);
                Precio = rs.getString(5);
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
