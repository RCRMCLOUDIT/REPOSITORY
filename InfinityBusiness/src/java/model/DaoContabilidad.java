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
public class DaoContabilidad extends ConexionDB {

    private Connection conn = null;
    private PreparedStatement pst = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static boolean existe = false;

    //VARIABLES PARA EL TIPO DE CUENTA
    public static String Tipo, Nombre, Clase;
    public static int IdTipCta, CodTipCta;

    // VARIABLES DEL CATALAGO CONTABLE
    public static int IdCatalago, IdTipoCuenta, IdNivel;
    public static String NumeroCta, NombreCta, NumCtaXNivel, DescripcionCta;

    //VARIABLES PARA ARMAR EL NUMERO DE CUENTA  
    public static String Nivel1, Nivel2, Nivel3, Nivel4, Nivel5, NewNumCta;

    public DaoContabilidad() {
        super();
    }

    public void AddCuentaContable(String NumeroCta, String NombreCta, int IdTipoCuenta, int IdNivel, String NumeroCtaXNivel, String DescripcionCta) {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `catalogocuenta` (`NumeroCta`, `Nombre`, `IdTipoCuenta`, `IdNivel`, `NumCtaXNivel`, `Descripcion`, `Activo`) VALUES(?,?,?,?,?,?,?)");
            pst.setString(1, NumeroCta);
            pst.setString(2, NombreCta);
            pst.setInt(3, IdTipoCuenta);
            pst.setInt(4, IdNivel);
            pst.setString(5, NumeroCtaXNivel);
            pst.setString(6, DescripcionCta);
            pst.setString(7, "SI");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean BuscarCtaContable(int IdCod) {
        existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("Select `IdCatalogo`, `NumeroCta`, `Nombre`, `IdTipoCuenta`, `IdNivel`, `NumCtaXNivel`, `Descripcion`, `Activo`, `FechaAlta`, `FechaBaja` FROM `catalogocuenta` WHERE `IdCatalogo`='" + IdCod + "' ");
            if (rs.next()) {
                existe = true;
                IdCatalago = rs.getInt("IdCatalogo");
                NumeroCta = rs.getString("NumeroCta");
                NombreCta = rs.getString("Nombre");
                IdTipoCuenta = rs.getInt("IdTipoCuenta");
                IdNivel = rs.getInt("IdNivel");
                NumCtaXNivel = rs.getString("NumCtaXNivel");
                DescripcionCta = rs.getString("Descripcion");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean ObtenerNumCtaXNivel(int IdNivel, String nivel1, String nivel2, String nivel3, String nivel4, String nivel5) {
        existe = false;
        Nivel1 = "";
        Nivel2 = "";
        Nivel3 = "";
        Nivel4 = "";
        Nivel5 = "";
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            if (IdNivel == 1) {
                rs = st.executeQuery("SELECT NumCtaXNivel FROM `catalogocuenta` WHERE NumCtaXNivel BETWEEN '" + nivel1 + "-000-000-000-000' AND '" + nivel1 + "-999-000-000-000' ORDER BY IdCatalogo DESC LIMIT 1;");
            }
            if (IdNivel == 2) {
                rs = st.executeQuery("SELECT NumCtaXNivel FROM `catalogocuenta` WHERE NumCtaXNivel BETWEEN '" + nivel1 + "-" + nivel2 + "-000-000-000' AND '" + nivel1 + "-" + nivel2 + "-999-000-000' ORDER BY IdCatalogo DESC LIMIT 1;");
            }
            if (IdNivel == 3) {
                rs = st.executeQuery("SELECT NumCtaXNivel FROM `catalogocuenta` WHERE NumCtaXNivel BETWEEN '" + nivel1 + "-" + nivel2 + "-" + nivel3 + "-000-000' AND '" + nivel1 + "-" + nivel2 + "-" + nivel3 + "-999-000' ORDER BY IdCatalogo DESC LIMIT 1;");
            }
            if (IdNivel == 4) {
                rs = st.executeQuery("SELECT NumCtaXNivel FROM `catalogocuenta` WHERE NumCtaXNivel BETWEEN '" + nivel1 + "-" + nivel2 + "-" + nivel3 + "-" + nivel4 + "-" + nivel5 + "' AND '" + nivel1 + "-" + nivel2 + "-" + nivel3 + "-" + nivel4 + "-999' ORDER BY IdCatalogo DESC LIMIT 1;");
            }
            if (rs.next()) {
                existe = true;
                NewNumCta = rs.getString("NumCtaXNivel");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public void AddTipoCuenta(int CodTipoCta, String Tipo, String Nombre) throws SQLException {
        existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            pst = conn.Conectar().prepareStatement("INSERT INTO `tipocuenta` (CodigoTipoCuenta, Tipo, Nombre, Clase) VALUES(?,?,?,?)");
            pst.setInt(1, CodTipoCta);
            pst.setString(2, Tipo);
            pst.setString(3, Nombre);
            pst.setString(4, "");
            pst.executeUpdate();
            conn.Cerrar();
            existe = true;
        } catch (SQLException e) {
            e.getMessage();
        }
    }

    public boolean Buscar(int IdCod) {
        existe = false;
        CodTipCta = 0;
        Tipo = "";
        Nombre = "";
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT `IdTipoCuenta`, `CodigoTipoCuenta`, `Tipo`, `Nombre`, `Clase` FROM `tipocuenta` WHERE `IdTipoCuenta`='" + IdCod + "' ");
            if (rs.next()) {
                existe = true;
                CodTipCta = rs.getInt("CodigoTipoCuenta");
                Tipo = rs.getString("Tipo");
                Nombre = rs.getString("Nombre");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

}
