/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javafx.scene.control.Alert;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoInventario;
import model.DaoMesas;
import model.DaoPedido;

/**
 *
 * @author Moises Romero
 */
public class ServletAgregaPedido extends HttpServlet {

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
        int idHab = Integer.valueOf(request.getParameter("IdHab"));
        int idMesa = Integer.valueOf(request.getParameter("IdMesa"));
        int Cantidad = Integer.valueOf(request.getParameter("Cantidad"));
        int idProd = Integer.valueOf(request.getParameter("IdProducto"));
        double precio1 = 0.00;
        double precio2 = 0.00;
        double precio3 = 0.00;
        int idPedido = 0;

        if (idMesa == 0) {
            //MANDO A BUSCAR EL ID FACTURA QUE SE ABRIO PARA EL SERVICIO AL MOMENTO QUE SE HIZO EL CHECK IN
            //MANDO A REGISTRAR EL DETALLE DEL PEDIDO
            //ESTRUCTURA DE LA TABLA DETALLE PARA HOTEL
            //IdFactManual, IdProducto, Cantidad,  Precio, Subtotal, Descuento, Iva
        }

        if (idHab == 0) {
            DaoPedido datos = new DaoPedido();
            try {
                //OBTENGO EL ID DEL PEDIDO SI LA MESA TIENE UN PEDIDO ABIERTO
                datos.validarPedido(idMesa);
                idPedido = datos.IdPedido;
                if (idPedido <= 0) {
                    datos.AgregaPedido(idMesa, idHab, 0);
                    DaoMesas estado = new DaoMesas();
                    estado.CambiarEstado(idMesa, "Ocupado");
                }
                //MANDO A BUSCAR EL PRECIO DEL PRODUCTO PARA LUEGO PASARLO AL DETALLE DE PEDIDO
                datos.BuscarPrecio(idProd);
                precio1 = datos.Precio1;
                precio2 = datos.Precio2;
                precio3 = datos.Precio3;

                //VERIFICO EL ID QUE OBTUVE PARA LA CONSULTA, SI EXISTE SOLO AGREGO EL DETALLE
                datos.validarPedido(idMesa);
                idPedido = datos.IdPedido;

                if (idPedido > 0) {
                    //AGREGANDO DETALLES DEL PEDIDO
                    if (precio1 > 0.00) {
                        datos.AgregaDetallePedido(idPedido, idProd, Cantidad, precio1, 0.00, 0.00);
                    } else if (precio1 == 0.00 && precio2 > 0.00) {
                        datos.AgregaDetallePedido(idPedido, idProd, Cantidad, precio2, 0.00, 0.00);
                    } else if (precio1 == 0.00 && precio2 == 0.00 && precio3 > 0.00) {
                        datos.AgregaDetallePedido(idPedido, idProd, Cantidad, precio3, 0.00, 0.00);
                    }
                }
                //request.getRequestDispatcher("Principal.jsp").forward(request, response);
                request.getRequestDispatcher("pedido.jsp?idMesa=" + idMesa).forward(request, response);
            } catch (Exception e) {
                //System.out.println("Error: " + e.getMessage());
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
