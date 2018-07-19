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
public class DaoCategoria extends ConexionDB {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public int IdMarca;
    public String Nombre, Descripcion, Activo;
    public static boolean existe = false;

    public DaoCategoria() {
        super();
    }

    public void AddTipoCategoria(String Nombre, String Descripcion) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO tipocategoria (Nombre, Descripcion, Activo) VALUES(?,?,?)");
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

    public boolean UpdateTipoCategoria(int IdCategoria, String Nombre, String Descripcion) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE `tipocategoria` SET `Nombre` = '" + Nombre + "', `Descripcion` = '" + Descripcion + "' WHERE `tipocategoria`.`IdTipoCat` = " + IdCategoria + "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public void AddCategoria(int IdTipoCat, String Nombre, String Descripcion) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `categoriaproducto` (IdTipoCat, Nombre, Descripcion, Activo) VALUES(?,?,?,?)");
            pst.setInt(1, IdTipoCat);
            pst.setString(2, Nombre);
            pst.setString(3, Descripcion);
            pst.setString(4, "SI");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean UpdateCategoria(int IdCategoria, String Nombre, String Descripcion) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE `categoriaproducto` SET `Nombre` = '" + Nombre + "', `Descripcion` = '" + Descripcion + "' WHERE `categoriaproducto`.`IdCategoria` = " + IdCategoria + "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
