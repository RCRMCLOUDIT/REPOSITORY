package model;

import beans.ConexionDB;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Calendar;
import java.util.GregorianCalendar;

/**
 *
 * @author Moises Romero
 */
public class DaoEmpleado extends ConexionDB {

    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;

    public String NUMEMP, CEDULA, INSS, NOMBRE, APELLIDO, FECHANAC, SEXO, DIRECCION, TELEFONO, CELULAR, CORREO, FECHAALTA;
    private static String FECHAHOY;

    public DaoEmpleado() {
        super();
    }

    public boolean AddEmpleado(String NumEmpleado, String Cedula, String Inns, String Nombre, String Apellido, String FechaNac, String Sexo, String Direccion, String Telefono, String Celular, String Correo, String FechaAlta) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into Empleado (NumEmpleado, Cedula, NoInss, Nombre, Apellido, FechaNac, Sexo, Direccion, Telefono, Celular, Correo, Activo, FechaAlta)"
                    + "VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?)");
            pst.setString(1, NumEmpleado);
            pst.setString(2, Cedula);
            pst.setString(3, Inns);
            pst.setString(4, Nombre);
            pst.setString(5, Apellido);
            pst.setString(6, FechaNac);
            pst.setString(7, Sexo);
            pst.setString(8, Direccion);
            pst.setString(9, Telefono);
            pst.setString(10, Celular);
            pst.setString(11, Correo);
            pst.setString(12, "SI");
            pst.setString(13, FechaAlta);
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
            rs = st.executeQuery("SELECT * FROM Empleado WHERE IdEmpleado = '" + COD + "'");
            if (rs.next()) {
                //existe = true;
                NUMEMP = rs.getString("NumEmpleado");
                CEDULA = rs.getString("Cedula");
                INSS = rs.getString("NoInss");
                NOMBRE = rs.getString("Nombre");
                APELLIDO = rs.getString("Apellido");
                FECHANAC = rs.getString("FechaNac");
                SEXO = rs.getString("Sexo");
                DIRECCION = rs.getString("Direccion");
                TELEFONO = rs.getString("Telefono");
                CELULAR = rs.getString("Celular");
                CORREO = rs.getString("Correo");
                FECHAALTA = rs.getString("FechaAlta");
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
