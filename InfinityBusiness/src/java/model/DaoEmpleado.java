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
public class DaoEmpleado extends ConexionDB {

    private PreparedStatement pst = null;
    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;
    public static Integer IdEmpleado;

    public String NUMEMP, CEDULA, INSS, NOMBRE, APELLIDO, FECHANAC, SEXO, DIRECCION, TELEFONO, CELULAR, CORREO, FECHAALTA, FECHABAJA;
    private static String FECHAHOY;

    public DaoEmpleado() {
        super();
    }

    public boolean ObtenerIdEmpleado() {
        existe = false;
        try {
            IdEmpleado = 0;
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("Select Count(IdEmpleado) AS IdEmpleado FROM `empleado`");
            if (rs.next()) {
                existe = true;
                IdEmpleado = rs.getInt("IdEmpleado");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean AddEmpleado(String NumEmpleado, String Cedula, String Inns, String Nombre, String Apellido, String FechaNac, String Sexo, String FechaAlta) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into Empleado (NumEmpleado, Cedula, NoInss, Nombre, Apellido, FechaNac, Sexo, Activo, FechaAlta)"
                    + "VALUES(?,?,?,?,?,?,?,?,?)");
            pst.setString(1, NumEmpleado);
            pst.setString(2, Cedula);
            pst.setString(3, Inns);
            pst.setString(4, Nombre);
            pst.setString(5, Apellido);
            pst.setString(6, FechaNac);
            pst.setString(7, Sexo);
            pst.setString(8, "SI");
            pst.setString(9, FechaAlta);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddDirEmpleado(int IdEmpleado, String Tipo, String Direccion, String Departamento, String FechaAlta) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into dirempleado (IdEmpleado, Tipo, Direccion, Departamento, FechaAlta, Activo)"
                    + "VALUES(?,?,?,?,?,?)");
            pst.setInt(1, IdEmpleado);
            pst.setString(2, Tipo);
            pst.setString(3, Direccion);
            pst.setString(4, Departamento);
            pst.setString(5, FechaAlta);
            pst.setString(6, "Si");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddTelfEmpleado(int IdEmpleado, String Tipo, String Telefono, String Extension) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into telfempleado (IdEmpleado, Tipo, Telefono, Extension)"
                    + "VALUES(?,?,?,?)");
            pst.setInt(1, IdEmpleado);
            pst.setString(2, Tipo);
            pst.setString(3, Telefono);
            pst.setString(4, Extension);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddEmailEmpleado(int IdEmpleado, String Tipo, String Email) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into emailempleado (IdEmpleado, Tipo, Email)"
                    + "VALUES(?,?,?)");
            pst.setInt(1, IdEmpleado);
            pst.setString(2, Tipo);
            pst.setString(3, Email);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean UpdateEmpleado(int IdEmp, String NumEmpleado, String Cedula, String Inns, String Nombre, String Apellido, String FechaNac,
            String Sexo, String Direccion, String Telefono, String Celular, String Correo, String FechaAlta) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE `empleado` SET Cedula='" + Cedula + "', NumEmpleado='" + NumEmpleado + "',  "
                    + "NoInss='" + Inns + "', Nombre='" + Nombre + "', Apellido='" + Apellido + "', FechaNac='" + FechaNac + "', Sexo='" + Sexo + "', "
                    + "Direccion='" + Direccion + "', Telefono='" + Telefono + "', Celular='" + Celular + "', Correo='" + Correo + "' , FechaAlta='" + FechaAlta + "' "
                    + "WHERE IdEmpleado='" + IdEmp + "'");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean BuscarEmpleado(int COD) {
        existe = false;

        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT NumEmpleado, Cedula, NoInss, Nombre, Apellido, FechaNac, Sexo, FechaAlta, FechaBaja FROM Empleado WHERE IdEmpleado = '" + COD + "'");
            if (rs.next()) {
                //existe = true;
                NUMEMP = rs.getString(1);
                CEDULA = rs.getString(2);
                INSS = rs.getString(3);
                NOMBRE = rs.getString(4);
                APELLIDO = rs.getString(5);
                FECHANAC = rs.getString(6);
                SEXO = rs.getString(7);
                FECHAALTA = rs.getString(8);
                if (rs.getString(9) == null) {
                    FECHABAJA = "-";
                } else {
                    FECHABAJA = rs.getString(9);
                }

            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
