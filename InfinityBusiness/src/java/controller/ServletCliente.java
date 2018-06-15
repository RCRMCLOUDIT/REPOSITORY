package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoCliente;

/**
 *
 * @author Moises Romero
 */
public class ServletCliente extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String Accion = request.getParameter("Accion");
        DaoCliente datos = new DaoCliente();

        if (Accion.equals("Add")) {
            String Ruc = request.getParameter("Ruc");
            String DNI = request.getParameter("DNI");
            String Nombre = request.getParameter("Nombre");
            String Apellido = request.getParameter("Apellido");
            String Email = request.getParameter("Email");
            String Telefono = request.getParameter("Telefono");
            String Movil = request.getParameter("Movil");
            String Direccion = request.getParameter("Direccion");
            String Sexo;
            if (request.getParameter("Sexo").equals("Masculino")) {
                Sexo = "M";
            } else {
                Sexo = "F";
            }
            datos.AddCliente(Ruc, DNI, Nombre, Apellido, Email, Telefono, Movil, Direccion, Sexo);
        }

        if (Accion.equals("Update")) {
            int IdCliente = Integer.valueOf(request.getParameter("IdCli"));
            String Ruc = request.getParameter("Ruc");
            String DNI = request.getParameter("DNI");
            String Nombre = request.getParameter("Nombre");
            String Apellido = request.getParameter("Apellido");
            String Email = request.getParameter("Email");
            String Telefono = request.getParameter("Telefono");
            String Movil = request.getParameter("Movil");
            String Direccion = request.getParameter("Direccion");
            String Sexo;
            if (request.getParameter("Sexo").equals("Masculino")) {
                Sexo = "M";
            } else {
                Sexo = "F";
            }
            datos.UpdateCliente(IdCliente, Ruc, DNI, Nombre, Apellido, Email, Telefono, Movil, Direccion, Sexo);
        }

        response.sendRedirect("factura/ListadoClientes.jsp");

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
