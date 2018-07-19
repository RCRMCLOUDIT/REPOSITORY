package model;

import beans.ConexionDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Moises Romero MIERCOLES 19 DE OCTUBRE DEL 2016
 */
public class DaoUnidadMedida {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public String Nombre, Simbolo, CodigoISO, Tipo, Activo;
    public static boolean existe = false;

    public DaoUnidadMedida() {
        super();
    }

    public boolean BuscarUnidad(int COD) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("SELECT * FROM `tipounidad` WHERE IdUnidad = '" + COD + "'");
            if (rs.next()) {
                //existe = true;
                Nombre = rs.getString("Nombre");
                Simbolo = rs.getString("Simbolo");
                CodigoISO = rs.getString("CodigoISO");
                Tipo = rs.getString("Tipo");
                Activo = rs.getString("Activo");

            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddUnidad(String Nombre, String Simbolo, String CodigoISO, String Tipo) {
        existe = false;

        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into `tipounidad` (Nombre, Simbolo, CodigoISO, Tipo, Activo) Values (?,?,?,?,?)");
            pst.setString(1, Nombre);
            pst.setString(2, Simbolo);
            pst.setString(3, CodigoISO);
            pst.setString(4, Tipo);
            pst.setString(5, "SI");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean UpdateUnidad(int Id, String Nombre, String Simbolo, String CodigoISO) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE  `tipounidad` SET `Nombre` = '" + Nombre + "', `Simbolo` = '" + Simbolo + "', `CodigoISO` = '" + CodigoISO + "'  WHERE `tipounidad`.`IdUnidad`  = '" + Id + "'");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }
}
