package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoProducto;

/**
 *
 * @author Moises Romero
 */
public class ServletProductoAdd extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int Unidad = Integer.valueOf(request.getParameter("UnidadMedida"));
        int TipoProducto = Integer.valueOf(request.getParameter("TipoProducto"));
        int Categoria = Integer.valueOf(request.getParameter("Categoria"));
        int Marca = Integer.valueOf(request.getParameter("Marca"));
        String CodCatalogo = request.getParameter("CodCatalogo");
        String CodigoEAN = request.getParameter("CodigoEAN");
        String CodigoSKU = request.getParameter("CodigoSKU");
        String CodigoUPC = request.getParameter("CodigoUPC");
        String NombreProducto = request.getParameter("NombreProducto");
        String Descripcion = request.getParameter("Descripcion");
        Double CostoCompra = Double.valueOf(request.getParameter("CostoCompra"));
        Double Precio1 = Double.valueOf(request.getParameter("Precio1"));
        Double Precio2 = Double.valueOf(request.getParameter("Precio2"));
        Double Precio3 = Double.valueOf(request.getParameter("Precio3"));
        Double Precio4 = Double.valueOf(request.getParameter("Precio4"));
        Double Descuento = Double.valueOf(request.getParameter("Descuento"));
        String Iva = request.getParameter("Iva");
        int StockMin = Integer.valueOf(request.getParameter("StockMin"));
        int StockMax = Integer.valueOf(request.getParameter("StockMax"));
        String Foto = request.getParameter("Foto");
        try {
            DaoProducto datos = new DaoProducto();
            datos.AddProducto(Unidad, TipoProducto, Categoria, Marca, CodCatalogo, CodigoEAN, CodigoSKU, CodigoUPC, NombreProducto, Descripcion, CostoCompra, Precio1, Precio2, Precio3, Precio4, Descuento, Iva, StockMin, StockMax, Foto);
            response.sendRedirect("producto/ListarProducto.jsp");
        } catch (Exception e) {
            e.getMessage();
        }

//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ServletProductoAdd</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ServletProductoAdd at " + request.getContextPath() + "</h1>");
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
