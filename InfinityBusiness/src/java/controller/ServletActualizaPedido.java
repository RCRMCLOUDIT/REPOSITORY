package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoPedido;

/**
 *
 * @author Moises Romero
 */
public class ServletActualizaPedido extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int Cantidad = Integer.valueOf(request.getParameter("form-UpdateCantidad"));
        int IdDetalle = Integer.valueOf(request.getParameter("form-UpdateIdDetalle"));
        int IdMesa = Integer.valueOf(request.getParameter("form-UpdateIdMesa"));
        String Accion = request.getParameter("Accion").trim();
        Double SubTotal = 0.00, Precio = 0.00;
        DaoPedido datos = new DaoPedido();

        if (Accion.equals("Actualiza")) {
            try {
                datos.BuscarDetallePedido(IdDetalle);
                Precio = datos.Precio;
                SubTotal = Cantidad * Precio;
                datos.ActulizaDetalle(IdDetalle, Cantidad, SubTotal);
                response.sendRedirect("factura/EstadoCuenta.jsp?idMesa=" + IdMesa);
                //request.getRequestDispatcher("/factura/EstadoCuenta.jsp?idMesa=" + IdMesa).forward(request, response);
            } catch (Exception e) {
            }
        }

        if (Accion.equals("Cancelar")) {
            try {
                datos.CancelarDetalle(IdDetalle);
                request.getRequestDispatcher("factura/EstadoCuenta.jsp?idMesa=" + IdMesa).forward(request, response);
            } catch (Exception e) {
            }
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
