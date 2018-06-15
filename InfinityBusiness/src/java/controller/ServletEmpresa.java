package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpresa;

/**
 *
 * @author Moises Romero
 */
@WebServlet(name = "ServletEmpresa", urlPatterns = {"/ServletEmpresa"})
public class ServletEmpresa extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Nombre = request.getParameter("NombreComapany");
        String CedulaRuc = request.getParameter("RUC");
        String RazonSocial = request.getParameter("RazonSocial");
        String Correo = request.getParameter("Correo");
        String Telefono = request.getParameter("Telefono");
        String Direccion = request.getParameter("Direccion");
        String RutaLogo = request.getParameter("Logo");
        String TipoNegocio = request.getParameter("TipoNegocio");
        String PagInicio = request.getParameter("PagInicio");
        Double IVA = Double.valueOf(request.getParameter("IVA"));

        DaoEmpresa datos = new DaoEmpresa();
        try {
            datos.UpdateEmpresa(Nombre, CedulaRuc, RazonSocial, Correo, Telefono, Direccion, RutaLogo, TipoNegocio, PagInicio, IVA);
            response.sendRedirect("configuracion/ConfiguracionEmpresa.jsp");
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
