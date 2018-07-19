package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.DaoProveedor;
// *************************************>
// * @author Ing. Moises Romero Mojica**> 
// *************************************>

public class ServletProveedor extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String Accion = request.getParameter("Accion");
        if (Accion.equals("Add")) {
            String NombreProveedor = request.getParameter("form-NombreProveedor");
            String Ruc = request.getParameter("form-form-CodigoRuc");
            String FechaAlta = request.getParameter("FechaIngreso");
            String FormaPago = request.getParameter("FormaPago");
            String Direccion = request.getParameter("form-Direccion");
            String Departamento = request.getParameter("form-Departamento");
            String TipoDireccion = request.getParameter("TipoDireccion");
            String Telefono = request.getParameter("form-Telefono");
            String Extension = request.getParameter("form-Extension");
            String TipoTelefono = request.getParameter("TipoTelefono");
            String Email = request.getParameter("form-Email");
            String TipoEmail = request.getParameter("TipoEmail");
            String CntaContable = request.getParameter("CtaContable");
            String CntaContableDescuento = request.getParameter("CtaContableDescuento");
            String CntaContableInteres = request.getParameter("CtaContableInteres");
            String Principal = request.getParameter("Principal");
            try {
                DaoProveedor datos = new DaoProveedor();
                int IdCntContContable, IdCntaContableDescuento, IdCntaContableInteres;
                // PRIMERO OBTENGO EL ID DE LA CUENTA CONTABLE, MANDO A BUSCAR EL NOMBRE SELECCIONADO
                datos.BuscarIdCnta(CntaContable);
                IdCntContContable = datos.IdCatalogo;
                // OBTENGO EL ID DE LA CUENTA DE DECUESTO, MANDO A BUSCAR EL NOMBRE SELECCIONADO
                datos.BuscarIdCnta(CntaContableDescuento);
                IdCntaContableDescuento = datos.IdCatalogo;
                // OBTENGO EL ID DE LA CUENTA DE INTERES, MANDO A BUSCAR EL NOMBRE SELECCIONADO
                datos.BuscarIdCnta(CntaContableInteres);
                IdCntaContableInteres = datos.IdCatalogo;

                // MANDO A GUARDAR LOS DATOS DEL PROVEEDOR
                datos.AddProveedor(Ruc, NombreProveedor, FormaPago, FechaAlta, IdCntContContable, IdCntaContableDescuento, IdCntaContableInteres);

                ///RECUPERO EL ID GENERAD DEL PROVEEDOR QUE SE ACABABA GUARDAR
                datos.ObtenerIdProveedor(NombreProveedor);
                int IdProveedor = datos.IdProveedor;

                //MANDO A GUARDAR LA INFORMACION DE CONTACTO DEL PROVEEDOR
                datos.AddDirProveedor(IdProveedor, 0, TipoDireccion, Direccion, Departamento, FechaAlta, Principal);
                datos.AddTelProveedor(IdProveedor, 0, TipoTelefono, Telefono, Extension, FechaAlta, Principal);
                datos.AddEmailProveedor(IdProveedor, 0, TipoEmail, Email, FechaAlta, Principal);

                //REDIRECCION AL LISTADO DE PROVEEDORES CON EL RESULTADO DEL PROVEEDOR QUE SE ACABA DE CREAR
                response.sendRedirect("proveedor/BuscaProveedor.jsp");
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
