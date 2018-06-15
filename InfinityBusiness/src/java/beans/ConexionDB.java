package beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
/**
 *
 * @author Moises Romero
 */
public class ConexionDB {

    public String driver;

//PARAMETROS PARA LA CONEXION AL SERVIDOR DE MOCHA
//    public String userSQL = "rcromero";
//    public String pass = "Rcromero1082+";
//    public String sUrl = "jdbc:mysql://localhost:3306/cloud.pos";

//PARAMETROS PARA LA CONEXION AL SERVIDOR LOCAL
    public String userSQL = "root";
    public String pass = "root";
    public String sUrl = "jdbc:mysql://localhost:3306/cloud.pos";
    public Connection conexion = null;

    public ConexionDB() {
        //Conexion a MYSQL
        try {
            Class.forName("com.mysql.jdbc.Driver");
            conexion = DriverManager.getConnection(sUrl, userSQL, pass);
        } catch (ClassNotFoundException | SQLException e) {
        }
//FIN
    }

    //Conexion a MYSQL
    public Connection Conectar() {
        if (conexion == null) {
            try {
                Class.forName("com.mysql.jdbc.Driver");
                conexion = DriverManager.getConnection(sUrl, userSQL, pass);
            } catch (ClassNotFoundException | SQLException e) {
            }
        }
        return conexion;
    }

    public Connection Cerrar() {
        conexion = null;
        return conexion;
    }

}
