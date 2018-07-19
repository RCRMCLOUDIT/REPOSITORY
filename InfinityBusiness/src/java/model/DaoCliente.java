package model;

import beans.ConexionDB;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Moises Romero
 */
public class DaoCliente {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;

    public String Ruc, DNI, Nombre, Apellido, Email, Telefono, Movil, Direccion, Sexo;
    public Date FechaReg, FechaBaja;

    public DaoCliente() {
        super();
    }

    public boolean BuscarCliente(int COD) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT IFNULL(Ruc,'-'), DNI, Nombre, Apellido, IFNULL(Email,'-'), Telefono, IFNULL(Movil,'-'), IFNULL(Direccion,'-'), Sexo, FechaReg, FechaBaja FROM Cliente WHERE IdCliente = '" + COD + "'");
            if (rs.next()) {
                //existe = true;
                Ruc = rs.getString(1);
                DNI = rs.getString(2);
                Nombre = rs.getString(3);
                Apellido = rs.getString(4);
                Email = rs.getString(5);
                Telefono = rs.getString(6);
                Movil = rs.getString(7);
                Direccion = rs.getString(8);
                Sexo = rs.getString(9);
                FechaReg = rs.getDate(10);
                FechaBaja = rs.getDate(11);
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddCliente(String Ruc, String DNI, String Nombre, String Apellido, String Email, String Telefono, String Movil, String Direccion, String Sexo) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into Cliente (Ruc, DNI, Nombre, Apellido, Email, Telefono, Movil, Direccion, Sexo, Activo)"
                    + "VALUES(?,?,?,?,?,?,?,?,?,?)");
            pst.setString(1, Ruc);
            pst.setString(2, DNI);
            pst.setString(3, Nombre);
            pst.setString(4, Apellido);
            pst.setString(5, Email);
            pst.setString(6, Telefono);
            pst.setString(7, Movil);
            pst.setString(8, Direccion);
            pst.setString(9, Sexo);
            pst.setString(10, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean UpdateCliente(int IdCliente, String Ruc, String DNI, String Nombre, String Apellido, String Email, String Telefono, String Movil, String Direccion, String Sexo) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE Cliente SET Ruc='" + Ruc + "', DNI='" + DNI + "', Nombre='" + Nombre + "', Apellido='" + Apellido + "', Email='" + Email + "', Telefono='" + Telefono + "', Movil='" + Movil + "', Direccion='" + Direccion + "', Sexo='" + Sexo + "' WHERE IdCliente=" + IdCliente + "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
