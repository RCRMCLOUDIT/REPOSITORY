package model;

import beans.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

// *************************************>
// * @author Ing. Moises Romero Mojica**> 
// *************************************>
public class DaoProveedor {

    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;
    public String Ruc, Nombre, FormaPago, FechaAlta, FechaBaja, Email, Telefono, Movil, Direccion, CntaContable, CntaDescuento, CntInteres;
    public int IdCntaContable, IdCntaDescuento, IdCntInteres;
    public static Integer IdProveedor, IdCatalogo;

    public DaoProveedor() {
        super();
    }

    public boolean ObtenerIdProveedor(String NombreProveedor) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("Select IdProveedor FROM proveedor WHERE Nombre LIKE'" + NombreProveedor + "'");
            if (rs.next()) {
                IdProveedor = rs.getInt("IdProveedor");
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean BuscarProveedor(int IdProveedor) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("Select IdProveedor, Ruc, Nombre, FormaPago, FechaAlta, FechaBaja, Activo FROM proveedor");
            if (rs.next()) {

            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddProveedor(String Ruc, String Nombre, String FormaPago, String FechaAlta, int CntaContable, int CntaDescuento, int CntInteres) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into Proveedor(Ruc, Nombre, FormaPago, FechaAlta, FechaBaja, Activo, CtaContable, CtaDescuento, CtaInteres)"
                    + "VALUES(?,?,?,?,?,?,?,?,?)");
            pst.setString(1, Ruc);
            pst.setString(2, Nombre);
            pst.setString(3, FormaPago);
            pst.setString(4, FechaAlta);
            pst.setString(5, "00-00-000");
            pst.setString(6, "Si");
            pst.setInt(7, CntaContable);
            pst.setInt(8, CntaDescuento);
            pst.setInt(9, CntInteres);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddDirProveedor(int IdProveedor, int IdContacto, String Tipo, String Direccion, String Departamento, String FechaAlta, String Principal) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into dirproveedor (IdProveedor, IdContacto, Tipo, Direccion, Departamento, FechaAlta, Activo, Principal)"
                    + "VALUES(?,?,?,?,?,?)");
            pst.setInt(1, IdProveedor);
            pst.setInt(2, IdContacto);
            pst.setString(3, Tipo);
            pst.setString(4, Direccion);
            pst.setString(5, Departamento);
            pst.setString(6, FechaAlta);
            pst.setString(7, "Si");
            pst.setString(8, Principal);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddTelProveedor(int IdProveedor, int IdContacto, String Tipo, String Telefono, String Extension, String FechaAlta, String Principal) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into TelfProveedor (IdProveedor, IdContacto, Tipo, Telefono, Extension, FechaAlta, Activo, Principal)"
                    + "VALUES(?,?,?,?,?,?,?,?)");
            pst.setInt(1, IdProveedor);
            pst.setInt(2, IdContacto);
            pst.setString(3, Tipo);
            pst.setString(4, Telefono);
            pst.setString(5, Extension);
            pst.setString(6, FechaAlta);
            pst.setString(7, "Si");
            pst.setString(8, Principal);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean AddEmailProveedor(int IdProveedor, int IdContacto, String Tipo, String Email, String FechaAlta, String Principal) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("Insert Into EmailProveedor (IdProveedor, IdContacto, Tipo, Email, FechaAlta, Activo, Principal)"
                    + "VALUES(?,?,?,?,?,?,?)");
            pst.setInt(1, IdProveedor);
            pst.setInt(2, IdContacto);
            pst.setString(3, Tipo);
            pst.setString(4, Email);
            pst.setString(5, FechaAlta);
            pst.setString(6, "Si");
            pst.setString(7, Principal);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean BuscarIdCnta(String NombreCnta) {
        existe = false;
        IdCatalogo = 0;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("Select IdCatalogo From catalogocuenta WHERE Nombre LIKE '" + NombreCnta + "'");
            if (rs.next()) {
                IdCatalogo = rs.getInt("IdCatalogo");
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }
}
