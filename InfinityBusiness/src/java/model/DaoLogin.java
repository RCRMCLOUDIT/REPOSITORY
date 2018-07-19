package model;

/**
 *
 * @author Moises Romero
 */
import beans.ConexionDB;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

/**
 *
 * @author Moises Romero
 */
public class DaoLogin extends ConexionDB {

    private Connection conn = null;
    private Statement st = null;
    private ResultSet rs = null;
    public static Integer IdUsuario = 0;
    public static String User = "";
    public static Boolean Bloqueado;

    public DaoLogin() {
        super();
    }

    public boolean validar(String Usuario, String Clave) {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("SELECT `IdUsuario`, `IdEmpleado`, `Usuario`, `Password`, `Activo` FROM `usuario` WHERE `Usuario`='" + Usuario + "' AND `Password`='" + Clave + "' AND `Activo`='SI'");
            if (rs.next()) {
                existe = true;
                IdUsuario = rs.getInt("IdUsuario");
                User = rs.getString("Usuario");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean BuscarUsuario(String Usuario) {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("Select IdUsuario, Usuario, Password, Activo, Bloqueado From Usuario Where Usuario = '" + Usuario + "';");
            if (rs.next()) {
                existe = true;
                IdUsuario = rs.getInt("IdUsuario");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }

    public boolean Bloquear(String Usuario, int IDUSUARIO) {
        boolean existe = false;
        try {
            conn = this.Conectar();
            st = conn.createStatement();
            rs = st.executeQuery("UPDATE Usuario set Bloqueado = 1 Where Usuario = '" + Usuario + "' AND IdUsuario= '" + IDUSUARIO + "'");
            if (rs.next()) {
                existe = true;
                IdUsuario = rs.getInt("IdUsuario");
            }
            this.Cerrar();
        } catch (Exception e) {
        }
        return existe;
    }
}
