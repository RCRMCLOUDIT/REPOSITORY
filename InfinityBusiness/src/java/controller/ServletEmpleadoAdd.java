package controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpleado;

/**
 *
 * @author Moises Romero
 */
public class ServletEmpleadoAdd extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String numEmpleado = request.getParameter("NumEmpleado").trim();
        String cedula = request.getParameter("Cedula").trim();
        String inss = request.getParameter("NoInss").trim();
        String nombre = request.getParameter("Nombre").trim();
        String apellido = request.getParameter("Apellido").trim();
        String fechanac = request.getParameter("FechaNac").trim();
        String sexo = request.getParameter("Genero").trim();
        if (sexo.equals("Masculino")) {
            sexo = "M";
        } else {
            sexo = "F";
        }
        String direccion = request.getParameter("Direccion").trim();
        String telefono = request.getParameter("Telefono").trim();
        String celular = request.getParameter("Celular").trim();
        String correo = request.getParameter("Correo").trim();
        String fechaingreso = request.getParameter("FechaIngreso").trim();

        try {
            DaoEmpleado datos = new DaoEmpleado();
            datos.AddEmpleado(numEmpleado, cedula, inss, nombre, apellido, fechanac, sexo, direccion, telefono, celular, correo, fechaingreso);
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
