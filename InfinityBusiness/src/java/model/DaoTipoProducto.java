package model;

import beans.ConexionDB;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 *
 * @author Moises Romero
 */
public class DaoTipoProducto {
    
    private Statement st = null;
    private ResultSet rs = null;
    public String TIPO, DESCRIP;

    public DaoTipoProducto() {
        super();
    }

    public boolean BuscarTipo(int COD) {
        boolean existe = false;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("SELECT * FROM TIPO_PRODUCTO WHERE ID = '" + COD + "'");
            if (rs.next()) {
                //existe = true;
                TIPO = rs.getString("TIPO_UNIDAD");
                DESCRIP = rs.getString("SIGLAS");
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean GuardadTipo(String Tipo, String Descripcion) {
        boolean existe = false;

        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("Insert Into TIPO_PRODUCTO (ID, TIPO, DESCRIPCION) Values ((Select Count(ISNULL(ID, 0)) + 1 From TIPO_PRODUCTO ), '" + Tipo + "', '" + Descripcion + "')");
            if (rs.next()) {
                existe = true;
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

    public boolean ActualizarTipo(int Cod, String Tipo, String Descripcion) {
        boolean existe = false;

        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            st = conn.conexion.createStatement();
            rs = st.executeQuery("UPDATE TIPO_PRODUCTO SET TIPO ='" + Tipo + "' , DESCRIPCION='" + Descripcion + "' WHERE ID=" + Cod + "");
            if (rs.next()) {
                existe = true;
            }
            conn.Cerrar();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return existe;
    }

}
