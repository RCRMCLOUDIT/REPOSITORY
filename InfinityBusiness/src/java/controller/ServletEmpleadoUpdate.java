package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpleado;

/**
 *
 * @author Moises Romero
 */
public class ServletEmpleadoUpdate extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //RECUPERO LOS DATOS DEL JSP.
        int IdEmpleado = Integer.parseInt(request.getParameter("IdEmp"));
        String numEmpleado = request.getParameter("numEmp").trim();
        String cedula = request.getParameter("cedula").trim();
        String inss = request.getParameter("inss").trim();
        String nombre = request.getParameter("nombre").trim();
        String apellido = request.getParameter("apellido").trim();
        String fechanac = request.getParameter("fechanac").trim();
        String sexo = request.getParameter("sexo").trim();
        if (sexo.equals("Masculino")) {
            sexo = "M";
        } else {
            sexo = "F";
        }
        String direccion = request.getParameter("direccion").trim();
        String telefono = request.getParameter("telefono").trim();
        String celular = request.getParameter("celular").trim();
        String correo = request.getParameter("correo").trim();
        String FechaAlta = request.getParameter("fechaingreso").trim();
        try {
            DaoEmpleado datos = new DaoEmpleado();
            datos.UpdateEmpleado(IdEmpleado, numEmpleado, cedula, inss, nombre, apellido, fechanac, sexo, direccion, telefono, celular, correo, FechaAlta);
            response.sendRedirect("empleados/ListarEmpleado.jsp");
        } catch (Exception e) {
        }

//        try (PrintWriter out = response.getWriter()) {
//            /* TODO output your page here. You may use following sample code. */
//            out.println("<!DOCTYPE html>");
//            out.println("<html>");
//            out.println("<head>");
//            out.println("<title>Servlet ServletEmpleadoUpdate</title>");
//            out.println("</head>");
//            out.println("<body>");
//            out.println("<h1>Servlet ServletEmpleadoUpdate at " + request.getContextPath() + "</h1>");
//            out.println("<h1>" + IdEmpleado + "</h1>");
//            out.println("<h1>" + numEmpleado + "</h1>");
//            out.println("<h1>" + cedula + "</h1>");
//            out.println("<h1>" + inss + "</h1>");
//            out.println("<h1>" + nombre + "</h1>");
//            out.println("<h1>" + apellido + "</h1>");
//            out.println("<h1>" + fechanac + "</h1>");
//            out.println("<h1>" + sexo + "</h1>");
//            out.println("<h1>" + direccion + "</h1>");
//            out.println("<h1>" + telefono + "</h1>");
//            out.println("<h1>" + celular + "</h1>");
//            out.println("<h1>" + correo + "</h1>");
//            out.println("<h1>" + FechaAlta + "</h1>");
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
