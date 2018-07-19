package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoContabilidad;

/**
 *
 * @author Moises Romero
 */
public class ServletContabilidad extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        //RECUPEROS LOS DATOS DEL JSP - CATALOGO CONTABLE
        String NumeroCta = request.getParameter("NumeroCta");
        String NombreCta = request.getParameter("NombreCta");
        int IdTipoCta = Integer.valueOf(request.getParameter("IdTipoCta"));
        String Descripcion = request.getParameter("Descripcion");
        int SubCta;
        int IdNivel;
        if (request.getParameter("SubCta").equals("")) {
            SubCta = 0;
        } else {
            SubCta = Integer.valueOf(request.getParameter("SubCta"));
        }
        String NumCtaXNivel = "";
        String NewNumCtaXNivel = "";

        // PARA CUENTAS DE NIVEL 1 QUE EQUIVALEN A LAS CUENTAS DE MAYOR..
        // MANDAO A BUSCAR EL PREFIJO QUE SE CONFIGURO EN LA TABLA
        // TIPO DE CUENTA
        DaoContabilidad datos = new DaoContabilidad();
        datos.Buscar(IdTipoCta);
        int CodTipoCta = datos.CodTipCta;
        if (CodTipoCta < 100) {
            NumCtaXNivel = "0" + String.valueOf(CodTipoCta) + "-000-000-000-000";
        }
        if (CodTipoCta >= 100) {
            NumCtaXNivel = String.valueOf(CodTipoCta) + "-000-000-000-000";
        }

        //CUENTA NIVEL - 1 = XXX , //CUENTA NIVEL - 2 = XXX-XXX //CUENTA NIVEL - 3 = XXX-XXX-XXX //........
        //COMO NO HAY SUBCUENTA, ES DE NIVEL 1 MANDO A GUARDAR DE UN SOLO LOS DATOS, 
        if (SubCta == 0) {
            IdNivel = 1;
            datos.AddCuentaContable(NumeroCta, NombreCta, IdTipoCta, IdNivel, NumCtaXNivel, Descripcion);
        }
        if (SubCta > 0) {
            datos.BuscarCtaContable(SubCta);
            IdNivel = datos.IdNivel; // OBTENGO EN NIVEL DE LA CUENTA PADRE
            NumCtaXNivel = datos.NumCtaXNivel; //OBTENGO EL NUMERO CUENTA DE LA CUENTA PADRE.
            // CASO DE QUE LA CUENTA SEA NIVEL 2
            if (IdNivel == 1) {
                //OBTENGO EL NUMERO DE CUENTA PADRE Y LO SEPARO DE LOS GUIONES 
                //PARA MANDAR A BUSCAR SI HAY MAS SUB-CUENTAS Y PODER ASIGNAR UN NUMERO CONSECUTIVO
                // A LA NUEVA SUB-CUENTA
                String[] nivel = NumCtaXNivel.split("-");
                String nivel1 = nivel[0];
                String nivel2 = nivel[1];
                String nivel3 = nivel[2];
                String nivel4 = nivel[3];
                String nivel5 = nivel[4];

                //OBTENGO EL ULTIMO NUMERO DE LA SUB-CUENTA A ASIGNAR POR NIVEL
                datos.ObtenerNumCtaXNivel(IdNivel, nivel1, nivel2, nivel3, nivel4, nivel5);
                NewNumCtaXNivel = datos.NewNumCta;
                //VUELVO A SEPARAR PARA ASI SUMARLE UNO Y TENER CONSECUTIVO EN LAS SUBCUENTAS
                String[] part = NewNumCtaXNivel.split("-");
                String part1 = part[0];
                String part2 = part[1];// COMO SERA DE NIVEL 2 ESTA SUB-CUENTA AQUI SUMAMOS 1
                String part3 = part[2];
                String part4 = part[3];
                String part5 = part[4];
                int NewNum = Integer.valueOf(part2) + 1;

                //UNIMOS TODAS LAS PARTES PARA ASIGNAR EL NUMERO DE CUENTA NUEVO
                NewNumCtaXNivel = part1 + "-" + String.valueOf(NewNum) + "-" + part3 + "-" + part4 + "-" + part5;
                IdNivel = IdNivel + 1;
                datos.AddCuentaContable(NumeroCta, NombreCta, IdTipoCta, IdNivel, NewNumCtaXNivel, Descripcion);
            }

            //CASO QUE LA CUENTA SERA DE NIVEL 3
            if (IdNivel == 2) {
                //OBTENGO EL NUMERO DE CUENTA PADRE Y LO SEPARO DE LOS GUIONES 
                //PARA MANDAR A BUSCAR SI HAY MAS SUB-CUENTAS Y PODER ASIGNAR UN NUMERO CONSECUTIVO
                // A LA NUEVA SUB-CUENTA
                String[] nivel = NumCtaXNivel.split("-");
                String nivel1 = nivel[0];
                String nivel2 = nivel[1];
                String nivel3 = nivel[2];
                String nivel4 = nivel[3];
                String nivel5 = nivel[4];

                //OBTENGO EL ULTIMO NUMERO DE LA SUB-CUENTA A ASIGNAR POR NIVEL
                datos.ObtenerNumCtaXNivel(IdNivel, nivel1, nivel2, nivel3, nivel4, nivel5);
                NewNumCtaXNivel = datos.NewNumCta;
                //VUELVO A SEPARAR PARA ASI SUMARLE UNO Y TENER CONSECUTIVO EN LAS SUBCUENTAS
                String[] part = NewNumCtaXNivel.split("-");
                String part1 = part[0];
                String part2 = part[1];
                String part3 = part[2];// COMO SERA DE NIVEL 3 ESTA SUB-CUENTA AQUI SUMAMOS 1
                String part4 = part[3];
                String part5 = part[4];
                int NewNum = Integer.valueOf(part3) + 1;

                //UNIMOS TODAS LAS PARTES PARA ASIGNAR EL NUMERO DE CUENTA NUEVO
                NewNumCtaXNivel = part1 + "-" + part2 + "-" + String.valueOf(NewNum) + "-" + part4 + "-" + part5;
                IdNivel = IdNivel + 1;
                datos.AddCuentaContable(NumeroCta, NombreCta, IdTipoCta, IdNivel, NewNumCtaXNivel, Descripcion);
            }

            //CASO QUE LA CUENTA SERA DE NIVEL 4
            if (IdNivel == 3) {
                //OBTENGO EL NUMERO DE CUENTA PADRE Y LO SEPARO DE LOS GUIONES 
                //PARA MANDAR A BUSCAR SI HAY MAS SUB-CUENTAS Y PODER ASIGNAR UN NUMERO CONSECUTIVO
                // A LA NUEVA SUB-CUENTA
                String[] nivel = NumCtaXNivel.split("-");
                String nivel1 = nivel[0];
                String nivel2 = nivel[1];
                String nivel3 = nivel[2];
                String nivel4 = nivel[3];
                String nivel5 = nivel[4];

                //OBTENGO EL ULTIMO NUMERO DE LA SUB-CUENTA A ASIGNAR POR NIVEL
                datos.ObtenerNumCtaXNivel(IdNivel, nivel1, nivel2, nivel3, nivel4, nivel5);
                NewNumCtaXNivel = datos.NewNumCta;
                //VUELVO A SEPARAR PARA ASI SUMARLE UNO Y TENER CONSECUTIVO EN LAS SUBCUENTAS
                String[] part = NewNumCtaXNivel.split("-");
                String part1 = part[0];
                String part2 = part[1];
                String part3 = part[2];
                String part4 = part[3];// COMO SERA DE NIVEL 4 ESTA SUB-CUENTA AQUI SUMAMOS 1
                String part5 = part[4];
                int NewNum = Integer.valueOf(part4) + 1;

                //UNIMOS TODAS LAS PARTES PARA ASIGNAR EL NUMERO DE CUENTA NUEVO
                NewNumCtaXNivel = part1 + "-" + part2 + "-" + part3 + "-" + String.valueOf(NewNum) + "-" + part5;
                IdNivel = IdNivel + 1;
                datos.AddCuentaContable(NumeroCta, NombreCta, IdTipoCta, IdNivel, NewNumCtaXNivel, Descripcion);
            }

            //CASO QUE LA SUB-CUENTA VAYA A SER NIVEL 5
            if (IdNivel == 4) {
                //OBTENGO EL NUMERO DE CUENTA PADRE Y LO SEPARO DE LOS GUIONES 
                //PARA MANDAR A BUSCAR SI HAY MAS SUB-CUENTAS Y PODER ASIGNAR UN NUMERO CONSECUTIVO
                // A LA NUEVA SUB-CUENTA
                String[] nivel = NumCtaXNivel.split("-");
                String nivel1 = nivel[0];
                String nivel2 = nivel[1];
                String nivel3 = nivel[2];
                String nivel4 = nivel[3];
                String nivel5 = nivel[4];

                //OBTENGO EL ULTIMO NUMERO DE LA SUB-CUENTA A ASIGNAR POR NIVEL
                datos.ObtenerNumCtaXNivel(IdNivel, nivel1, nivel2, nivel3, nivel4, nivel5);
                NewNumCtaXNivel = datos.NewNumCta;
                //VUELVO A SEPARAR PARA ASI SUMARLE UNO Y TENER CONSECUTIVO EN LAS SUBCUENTAS
                String[] part = NewNumCtaXNivel.split("-");
                String part1 = part[0];
                String part2 = part[1];
                String part3 = part[2];
                String part4 = part[3];
                String part5 = part[4];// COMO SERA DE NIVEL 5 ESTA SUB-CUENTA AQUI SUMAMOS 1
                int NewNum = Integer.valueOf(part5) + 1;

                //UNIMOS TODAS LAS PARTES PARA ASIGNAR EL NUMERO DE CUENTA NUEVO
                NewNumCtaXNivel = part1 + "-" + part2 + "-" + part3 + "-" + part4 + "-" + String.valueOf(NewNum);
                IdNivel = IdNivel + 1;
                datos.AddCuentaContable(NumeroCta, NombreCta, IdTipoCta, IdNivel, NewNumCtaXNivel, Descripcion);
            }
        }//FIN DEL IF SI SUB-CUENTA>0

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
