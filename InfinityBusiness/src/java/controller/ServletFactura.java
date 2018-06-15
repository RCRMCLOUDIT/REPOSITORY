package controller;

import beans.ConexionDB;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpresa;
import model.DaoFactura;
import model.DaoLogin;
import model.DaoMesas;
import model.DaoPedido;

/**
 *
 * @author Moises Romero
 */
public class ServletFactura extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int idMesa = Integer.valueOf(request.getParameter("form-idMesa"));
        String Observaciones = "-";
        int IdUsuario = DaoLogin.IdUsuario;
        DaoPedido datos = new DaoPedido();
        DaoEmpresa empresa = new DaoEmpresa();
        datos.validarPedido(idMesa);
        int idPedido = datos.IdPedido;
        double SubTotal = 0.00;
        double Descuento = Double.valueOf(request.getParameter("form-Descuento"));
        empresa.BuscarEmpresa();
        double IVA = empresa.IVA / 100;
        double Total = 0.00;
        try {
            ConexionDB conn = new ConexionDB();
            conn.Conectar();
            String consulta = "SELECT `producto`.`Nombre`, SUM(`detallepedido`.`Cantidad`) AS Cantidad, `detallepedido`.`Precio`, "
                    + "SUM(`detallepedido`.`Subtotal`) AS Subtotal FROM `producto` LEFT JOIN `detallepedido` ON `detallepedido`.`IdProducto` = `producto`.`IdProducto`  "
                    + "LEFT JOIN `pedido` ON `detallepedido`.`IdPedido` = `pedido`.`IdPedido` WHERE `pedido`.`IdMesa` = " + idMesa + " AND "
                    + "`pedido`.`Estado` LIKE'Abierto' GROUP BY `producto`.`Nombre` having count(*) > 0";
            ResultSet rs = null;
            PreparedStatement pst = null;
            pst = conn.conexion.prepareStatement(consulta);
            rs = pst.executeQuery();
            while (rs.next()) {
                SubTotal = SubTotal + Double.valueOf(rs.getString(4));
            }
            IVA = SubTotal * (IVA);
            Total = (SubTotal - Descuento) + IVA;
        } catch (Exception e) {

        }

        try {
            datos.DeleteDescuentoTEMP(idMesa, "MESA");
            DaoFactura factura = new DaoFactura();
            factura.GenerarFactura(1, IdUsuario, idPedido, Observaciones, SubTotal, Descuento, IVA, Total);
            factura.ObtenerIdFactura();
            int IdFactura = factura.IdFactura;

            DaoMesas estado = new DaoMesas();
            estado.CambiarEstado(idMesa, "Libre");

            DaoPedido cerrar = new DaoPedido();
            cerrar.ActualizaPedido(idPedido);

            //MANDAR A LLAMAR EL REPORTDE FACTURA
            response.sendRedirect("factura/ReporteFactura.jsp?idFactura=" + IdFactura + "");

            //request.getRequestDispatcher("Principal.jsp").forward(request, response);
            //response.sendRedirect("Principal.jsp");
//<a target="_blank" href="http://www.lineadecodigo.com">Abrir Linea de Codigo en una nueva ventana</a>
//            Reportes re = new Reportes();
//            re.reporteFacturaTMU(IdFactura);
        } catch (Exception e) {

        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
