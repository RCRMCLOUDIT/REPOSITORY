package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoInventario;

/**
 *
 * @author Moises Romero
 */
public class ServletEntradaInvet extends HttpServlet {
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int IdProducto = Integer.valueOf(request.getParameter("IdProducto"));        
        double Cantidad = Double.valueOf(request.getParameter("Cantidad"));
        double Costo = Double.valueOf(request.getParameter("Costo"));
        
       DaoInventario datos = new DaoInventario();
       
       //PRIMERO RECUPERO LA EXISTENCIA QUE HAY
       datos.ValidaExistencias(IdProducto);
       double disponible = DaoInventario.Disponible;
       double fisica = DaoInventario.Fisicas;
       double reserva = DaoInventario.Reserva;

       //SEGUNDO RECUPERO EL COSTO PROMEDIO QUE TIENE ACTUALMENTE EL PRODUCTO
       datos.ValidaCosto(IdProducto);
       double costo = DaoInventario.CostoProm;
       
       //CALCULO EL NUEVO COSTO PROMEDIO
       
       
        
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
