package model;

/**
 *
 * @author Moises Romero
 */
import beans.ConexionDB;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DaoMesas extends ConexionDB {

    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;
    public int IdMesa, LastId;
    public String Estado, Nombre;

    public DaoMesas() {
        super();
    }

    public static ArrayList<Mesas> obtenerMesasAct() {
        ArrayList<Mesas> lista = new ArrayList<Mesas>();
        ConexionDB conn = new ConexionDB();
        conn.Conectar();
        CallableStatement cs = null;
        ResultSet rs = null;
        try {
            cs = conn.Conectar().prepareCall("CALL MOSTRAR_MESAS");
            rs = cs.executeQuery();
            while (rs.next()) {
                Mesas mesa = new Mesas(rs.getInt("IdMesa"), rs.getString("Nombre"), rs.getString("Estado"), rs.getString("Activo"));
                lista.add(mesa);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return lista;
    }

    public void CambiarEstado(int IdMesa, String Estado) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE  `mesa` SET `Estado` = '" + Estado + "' WHERE `mesa`.`IdMesa`  = '" + IdMesa + "'");
            //rs = st.execute("INSERT INTO marca (Nombre, Descripcion, Activo) VALUES ('" + Nombre + "', '" + Descripcion + "', 'SI')");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean ListarMesas() {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT IdMesa, Nombre, Estado FROM `mesa`");
            if (rs.next()) {
                existe = true;
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean GetIdMesa() {
        LastId = 0;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT Count(IdMesa) FROM `mesa`");
            if (rs.next()) {
                LastId = rs.getInt(1);
                existe = true;
            }
        } catch (Exception e) {
            e.getMessage();

        }
        return existe;
    }

    public void AddMesa(int IdMesa, String Nombre) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `mesa` (IdMesa, Nombre, Estado, Activo) VALUES(?,?,?,?)");
            pst.setInt(1, IdMesa);
            pst.setString(2, Nombre);
            pst.setString(3, "Libre");
            pst.setString(4, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public void UpdateMesa(int IdMesa, String Nombre) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE  `mesa` SET `Nombre` = '" + Nombre + "' WHERE `mesa`.`IdMesa`  = '" + IdMesa + "'");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean FindMesa(int IdMesa) {
        Nombre = "";
        Estado = "";
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT Nombre, Estado FROM `mesa` WHERE IdMesa=" + IdMesa + " AND Activo='Si'");
            if (rs.next()) {
               Nombre = rs.getString("Nombre");
               Estado = rs.getString("Estado");
                existe = true;
            }
        } catch (Exception e) {
            e.getMessage();

        }
        return existe;
    }
    
    public void AddReservaMesa(int IdUsuario, String NombreCliente, int Personas, String Comentarios,  String FechaReservada, String HoraReservada) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `reservarestaurante` (IdUsuario, NombreCliente, Personas, Comentarios, FechaReservada, HoraReservada, Estado, Activo) VALUES(?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdUsuario);
            pst.setString(2, NombreCliente);
            pst.setInt(3, Personas);
            pst.setString(4, Comentarios);
            pst.setString(5, FechaReservada);
            pst.setString(6, HoraReservada);
            pst.setString(7, "SinConfirmar");
            pst.setString(8, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

}
