package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpresa;
import model.DaoLogin;

/**
 *
 * @author Moises Romero
 */
public class ServletLogin extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Nombre = request.getParameter("form-username");
        String Clave = request.getParameter("form-password");
        DaoLogin datos = new DaoLogin();
        DaoEmpresa config = new DaoEmpresa();
        if (datos.validar(Nombre, Clave)) {
            config.BuscarEmpresa();
            request.getRequestDispatcher("Principal.jsp").forward(request, response);
//            String Tipo = config.TipoNegocio;
//            if (Tipo.equals("")) {
//                request.getRequestDispatcher("Principal.jsp").forward(request, response);
//            }
//            if (Tipo.equals("Restaurante")) {
//                request.getRequestDispatcher("Principal.jsp").forward(request, response);
//            }
//            if (Tipo.equals("Hotel")) {
//                request.getRequestDispatcher("PrincipalHotel.jsp").forward(request, response);
//            }
//            if (Tipo.equals("Ambos")) {
//                request.getRequestDispatcher("PrincipalAmbos.jsp").forward(request, response);
//            }

        } else {
            request.getRequestDispatcher("Login.jsp").forward(request, response);
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
