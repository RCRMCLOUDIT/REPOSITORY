package model;

import beans.ConexionDB;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Ing. Moises Romero Mojica
 */
public class DaoReservas {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;
    public String NombreCliente, Estado, Activo;
    public int IdReservHab, IdUsuario, IdTipoHab, Adultos, Niños, HabsReservadas, HabsTotales, HabsDisponibles;
    public Date FechaIN, FechaOUT;

    public DaoReservas() {
        super();
    }

    public void AddReservaHab(int IdUser, int IdTipoHab, String Nombre, int Adulto, int Nino, String FechaIN, String FechaOUT) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO reservahabitacion (IdUsuario, IdTipoHab, NombreCliente, Adultos, Niños, FechaIN, FechaOUT, Estado, Activo) VALUES(?,?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdUser);
            pst.setInt(2, IdUser);
            pst.setString(3, Nombre);
            pst.setInt(4, Adulto);
            pst.setInt(5, Nino);
            pst.setString(6, FechaIN);
            pst.setString(7, FechaOUT);
            pst.setString(8, "SinConfirmar");
            pst.setString(9, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean BuscarReserva(int IdReservaHab) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT IdReservHab, IdUsuario, IdTipoHab, NombreCliente, Adultos, Niños, FechaIN, FechaOUT, Estado, Activo FROM `reservahabitacion` WHERE IdReservHab='" + IdReservaHab + "' AND Activo='Si'");
            if (rs.next()) {
                //existe = true;
                IdReservHab = rs.getInt(1);
                IdUsuario = rs.getInt(2);
                IdTipoHab = rs.getInt(3);
                NombreCliente = rs.getString(4);
                Adultos = rs.getInt(5);
                Niños = rs.getInt(6);
                FechaIN = rs.getDate(7);
                FechaOUT = rs.getDate(8);
                Estado = rs.getString(9);
                Activo = rs.getString(10);
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean CheckHabTotales(int IdTipoHab) {
        existe = false;
        HabsTotales = 0;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT COUNT(*) AS CantHab FROM habitaciones WHERE IdTipoHab ='" + IdTipoHab + "' AND Activo='Si' ");
            if (rs.next()) {
                //existe = true;
                HabsTotales = rs.getInt(1);
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean CheckHabReservadas(int IdTipoHab, String FechaIN, String FechaOUT) {
        existe = false;
        HabsReservadas = 0;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT COUNT(*) AS CantReser  FROM `reservahabitacion` WHERE `IdTipoHab` ='" + IdTipoHab + "' AND `FechaIN` >= '" + FechaIN + "' AND `FechaOUT` <= '" + FechaOUT + "'");
            if (rs.next()) {
                //existe = true;
                HabsReservadas = rs.getInt(1);
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
