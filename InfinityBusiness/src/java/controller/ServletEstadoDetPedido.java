/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoInventario;
import model.DaoPedido;
import static model.DaoPedido.Cantidad;
import static model.DaoPedido.IdProducto;

/**
 *
 * @author Moises Romero
 */
public class ServletEstadoDetPedido extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        int Id = Integer.valueOf(request.getParameter("IdDetalle"));

        DaoPedido datos = new DaoPedido();
        datos.BuscarDetallePedido(Id);
        int IdProducto = datos.IdProducto;
        int Cantidad = datos.Cantidad;
        double Precio = datos.Precio;
        DaoInventario DAO = new DaoInventario();
        DAO.ValidaExistencias(IdProducto);
        double StockInicial = 0.00, StockFinal = 0.00;
        try {
            datos.ActualizaDetallePedido(Id);
            StockInicial = DaoInventario.Disponible;
            StockFinal = StockInicial - Cantidad;
            DAO.AddSalida(IdProducto, Cantidad, StockInicial, StockFinal, Precio);
            response.sendRedirect("ordenes/ListarOrdenes.jsp");
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        }

//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ServletEstadoDetPedido</title>");            
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Recibo el ID DETALLE: " + Id + "</h1>");
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
