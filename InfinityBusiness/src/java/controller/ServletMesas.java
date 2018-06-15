package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoMesas;

/**
 *
 * @author Moises Romero
 */
@WebServlet(name = "ServletMesas", urlPatterns = {"/ServletMesas"})
public class ServletMesas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Nombre = request.getParameter("Nombre");
        String Accion = request.getParameter("Accion");
        DaoMesas datos = new DaoMesas();
        if (Accion.equals("Add")) {
            try {
                datos.GetIdMesa();
                int IdMesa = datos.LastId + 1;
                datos.AddMesa(IdMesa, Nombre);
            } catch (Exception e) {
                e.getMessage();
            }

        }

        if (Accion.equals("Update")) {
            try {
                int IdMesa = Integer.valueOf(request.getParameter("IdMesa"));
                datos.UpdateMesa(IdMesa, Nombre);
            } catch (Exception e) {
                e.getMessage();
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
