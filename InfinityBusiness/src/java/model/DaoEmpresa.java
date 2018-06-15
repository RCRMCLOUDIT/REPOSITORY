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
public class DaoEmpresa extends ConexionDB {
    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static String Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, PagInicio;
    public static Double IVA;
    public static boolean existe = false;

    public DaoEmpresa(){
        super();
    }
    
     public boolean BuscarEmpresa() {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, PaginaInicio, IVA FROM `configuracion` WHERE `configuracion`.`IdCon` = 1");
            if (rs.next()) {
                Nombre = rs.getString("Nombre");
                CedulaRuc = rs.getString("CedulaRuc");
                RazonSocial = rs.getString("RazonSocial");
                Correo = rs.getString("Correo");
                Telefono = rs.getString("Telefono");
                Direccion = rs.getString("Direccion");
                RutaLogo = rs.getString("RutaLogo");
                TipoNegocio = rs.getString("TipoNegocio");
                PagInicio = rs.getString("PaginaInicio");
                IVA = rs.getDouble("IVA");
                existe = true;
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }
    
    public void AddEmpresa(String Nombre, String CedulaRuc,String RazonSocial, String Correo, String Telefono, String Direccion, String RutaLogo, String TipoNegocio, Double IVA) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO configuracion (Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, IVA) VALUES(?,?,?,?,?,?,?,?,?)");
            pst.setString(1, Nombre);
            pst.setString(2, CedulaRuc);
            pst.setString(3, RazonSocial);
            pst.setString(4, Correo);
            pst.setString(5, Telefono);
            pst.setString(6, Direccion);
            pst.setString(7, RutaLogo);
            pst.setString(8, TipoNegocio);
            pst.setDouble(9, IVA);
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }
    
     public boolean UpdateEmpresa(String Nombre, String CedulaRuc,String RazonSocial, String Correo, String Telefono, String Direccion, String RutaLogo, String TipoNegocio, String PaginaInicio, Double IVA) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("UPDATE `configuracion` SET `Nombre` = '" + Nombre + "', `CedulaRuc` = '" + CedulaRuc + "', `RazonSocial` = '" + RazonSocial + "', `Correo` = '" + Correo + "', `Telefono` = '" + Telefono + "', `Direccion` = '" + Direccion + "', `RutaLogo` = '" + RutaLogo + "', `TipoNegocio` = '" + TipoNegocio + "', `PaginaInicio` = '" + PaginaInicio + "', `IVA` = '" + IVA + "' WHERE `configuracion`.`IdCon` =1");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }
}
