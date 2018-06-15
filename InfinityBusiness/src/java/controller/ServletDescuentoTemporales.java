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
 * @author Ing. Moises Romero Mojica
 */
public class ServletDescuentoTemporales extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int IdMesa = Integer.valueOf(request.getParameter("IdMesa"));
        String Tipo = request.getParameter("Tipo");
        Double Descuento = Double.valueOf(request.getParameter("Descuento"));
        DaoPedido datos = new DaoPedido();

        datos.BuscarDescuentoTEMP(IdMesa);
        boolean Registro = datos.existe;
        Double DescActual = datos.DescTEMP;
        if (Registro == true && DescActual<=100.00) {
            try {
                datos.UpdateDescuentoTEMP(IdMesa, Descuento, Tipo);
            } catch (Exception e) {
            }
        } else {
            try {
                datos.AddDescuentoTEMP(IdMesa, Tipo, Descuento);
            } catch (Exception e) {
            }
        }

//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ServletDescuentoTemporales</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ServletDescuentoTemporales at " + request.getContextPath() + "</h1>");
//            out.println("<h1>Servlet ServletDescuentoTemporales at " + IdMesa + "</h1>");
//            out.println("<h1>Servlet ServletDescuentoTemporales at " + Tipo + "</h1>");
//            out.println("<h1>Servlet ServletDescuentoTemporales at " + Descuento + "</h1>");
//            out.println("</body>");
//            out.println("</html>");
//        }
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
