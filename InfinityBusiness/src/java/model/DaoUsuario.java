package model;

import beans.ConexionDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Moises Romero
 */
public class DaoUsuario {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;

    public DaoUsuario() {
        super();
    }

    public boolean AddUsuario(int IdEmpleado, String Usuario, String Clave) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into `usuario` (IdEmpleado, Usuario, Password, Activo) Values (?,?,?,?)");
            pst.setInt(1, IdEmpleado);
            pst.setString(2, Usuario);
            pst.setString(3, Clave);
            pst.setString(4, "SI");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean UpdateUsuario(int IdUsuario, String Usuario, String Clave) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE  `usuario` SET `Usuario` = '" + Usuario + "', `Password` = '" + Clave + "'  WHERE `usuario`.`IdUsuario`  = '" + IdUsuario + "'");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
