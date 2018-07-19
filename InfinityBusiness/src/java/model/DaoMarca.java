package model;

import beans.ConexionDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.PreparedStatement;

/**
 *
 * @author Moises Romero
 */
public class DaoMarca extends ConexionDB {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;    
    public int IdMarca;
    public String Nombre, Descripcion, Activo;


    public DaoMarca() {
        super();
    }

    public void AgregarMarca(String Nombre, String Descripcion) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO marca (Nombre, Descripcion, Activo) VALUES(?,?,?)");
            //rs = st.execute("INSERT INTO marca (Nombre, Descripcion, Activo) VALUES ('" + Nombre + "', '" + Descripcion + "', 'SI')");
            pst.setString(1, Nombre);
            pst.setString(2, Descripcion);
            pst.setString(3, "SI");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean ActualizarMarca(int IdMarca, String Nombre, String Descripcion) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE `marca` SET `Nombre` = '" + Nombre + "', `Descripcion` = '" + Descripcion + "' WHERE `marca`.`IdMarca` = " + IdMarca + "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }
}
