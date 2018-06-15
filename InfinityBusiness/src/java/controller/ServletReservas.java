package controller;

import java.io.IOException;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoLogin;
import model.DaoMesas;
import model.DaoReservas;

/**
 *
 * @author Ing. Moises Romero Mojica
 */
public class ServletReservas extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String accion = request.getParameter("form-Accion");

        String Nombre, Comentarios;
        int Adultos, Ninos, IdTipoHab, HabsTotales, HabsReservadas, HabsDisponibles, Personas;
        String FechaIn, FechaOut, Fecha, Hora;
        int IdUser = DaoLogin.IdUsuario;
        DaoReservas datos = new DaoReservas();

        if (accion.equals("AddResvHab")) {
            Nombre = request.getParameter("form-NombreReserva");
            Adultos = Integer.parseInt(request.getParameter("form-Adultos"));
            Ninos = Integer.parseInt(request.getParameter("form-Ninos"));
            IdTipoHab = Integer.parseInt(request.getParameter("form-TipoHab"));
            FechaIn = request.getParameter("FechaIN");
            FechaOut = request.getParameter("FechaOUT");
            Comentarios = request.getParameter("Comentarios");
            try {
                datos.AddReservaHab(IdUser, IdTipoHab, Nombre, Adultos, Ninos, FechaIn, FechaOut);
                response.sendRedirect("PrincipalRestaurante.jsp");
            } catch (SQLException ex) {

            }
        }

        if (accion.equals("CheckHabDispo")) {
            IdTipoHab = Integer.parseInt(request.getParameter("form-TipoHab"));
            FechaIn = request.getParameter("FechaIN");
            FechaOut = request.getParameter("FechaOUT");
            datos.CheckHabTotales(IdTipoHab);
            HabsTotales = datos.HabsTotales;
            datos.CheckHabReservadas(IdTipoHab, FechaIn, FechaOut);
            HabsReservadas = datos.HabsReservadas;
            HabsDisponibles = HabsTotales - HabsReservadas;
            response.sendRedirect("/reserva/ReservaHabitacion.jsp?idTipoHab=" + IdTipoHab + "&FechaIn=" + FechaIn + "&Fechaout=" + FechaOut);
        }

        if (accion.equals("AddResvMesa")) {
            Nombre = request.getParameter("form-NombreReserva");
            Personas = Integer.parseInt(request.getParameter("form-Personas"));
            Fecha = request.getParameter("Fecha");
            Hora = request.getParameter("Hora");
            Comentarios = request.getParameter("Comentarios");
            DaoMesas mesa = new DaoMesas();
            try {
                mesa.AddReservaMesa(IdUser, Nombre, Personas, Comentarios, Fecha, Hora);
                response.sendRedirect("Mesas/ListaReservasMesas.jsp");
            } catch (SQLException ex) {

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
