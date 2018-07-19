package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoEmpleado;

/**
 *
 * @author Moises Romero
 */
public class ServletEmpleado extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Accion = request.getParameter("Accion");

        //ACCION PARA AGREGAR UN NUEVO EMPLEADO
        if (Accion.equals("Add")) {
            String NumEmpleado = request.getParameter("form-NumEmpleado").trim();
            String Cedula = request.getParameter("form-Cedula").trim();
            String Inss = request.getParameter("form-Inss").trim();
            String Nombre = request.getParameter("form-NombreEmpleado").trim();
            String Apellido = request.getParameter("form-ApellidoEmpleado").trim();
            String FechaNacimiento = request.getParameter("FechaNacimiento").trim();
            String Sexo = request.getParameter("Sexo").trim();
            if (Sexo.equals("Masculino")) {
                Sexo = "M";
            } else {
                Sexo = "F";
            }
            String FechaIngreso = request.getParameter("FechaIngreso").trim();
            String FechaBaja = request.getParameter("FechaBaja").trim();
            String Direccion = request.getParameter("form-Direccion").trim();
            String TipoDireccion = request.getParameter("TipoDireccion").trim();
            String Departamento = request.getParameter("form-Departamento").trim();
            String Correo = request.getParameter("form-Email").trim();
            String TipoCorreo = request.getParameter("TipoEmail").trim();
            String Telefono = request.getParameter("form-Telefono").trim();
            String Extension = request.getParameter("form-Extension").trim();
            String TipoTelefono = request.getParameter("TipoTelefono").trim();
            try {
                DaoEmpleado datos = new DaoEmpleado();
                //REGISTRO LOS DATOS DEL EMPLEADO
                datos.AddEmpleado(NumEmpleado, Cedula, Inss, Nombre, Apellido, FechaNacimiento, Sexo, FechaIngreso);
                //OBTENGO EL ID DEL EMPLEADO GENERADO POR EL SISTEMA
                datos.ObtenerIdEmpleado();
                int IdEmpleado = datos.IdEmpleado;
                //MANDO A GUARDAR LOS DATOS DE DIRECCION, TELEFONO Y EMAIL DEL EMPLEADO.
                datos.AddDirEmpleado(IdEmpleado, TipoDireccion, Direccion, Departamento, FechaIngreso);
                datos.AddTelfEmpleado(IdEmpleado, TipoTelefono, Telefono, Extension);
                datos.AddEmailEmpleado(IdEmpleado, TipoCorreo, Correo);
                response.sendRedirect("/empleados/ListarEmpleado.jsp");
            } catch (Exception e) {
            }
        }
        //ACCION PARA ACTUALIZAR LOS DATOS DEL EMPLEADO.        
        if (Accion.equals("Update")) {
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
        }
        //ACCION PARA AGREGAR UNA NUEVA DIRECCION DEL EMPLEADO
        if (Accion.equals("AddDireccion")) {
            int IdEmpleado = Integer.valueOf(request.getParameter("IdEmpleado").trim());
            String Direccion = request.getParameter("Direccion").trim();
            String Departamento = request.getParameter("Departamento").trim();
            String TipoDireccion = request.getParameter("TipoDireccion").trim();
            String FechaAlta = request.getParameter("FechaAlta").trim();
            try {
                DaoEmpleado datos = new DaoEmpleado();
                datos.AddDirEmpleado(IdEmpleado, TipoDireccion, Direccion, Departamento, FechaAlta);
            } catch (Exception e) {
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
