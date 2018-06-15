package model;

import java.util.Date;

/**
 *
 * @author Moises Romero
 */
public class ClaseOrdenes {

    private int IdDetalle, Cantidad;
    private String Estado, Nombre, Mesa;
    private Date HoraPedido;

    public ClaseOrdenes() {
    }

    public ClaseOrdenes(int IdDetalle, String Mesa, String Nombre, int Cantidad, Date HoraPedido, String Estado) {
        this.IdDetalle = IdDetalle;
        this.Cantidad = Cantidad;
        this.Estado = Estado;
        this.Nombre = Nombre;
        this.Mesa = Mesa;
        this.HoraPedido = HoraPedido;
    }

    public int getIdDetalle() {
        return IdDetalle;
    }

    public void setIdDetalle(int IdDetalle) {
        this.IdDetalle = IdDetalle;
    }

    public int getCantidad() {
        return Cantidad;
    }

    public void setCantidad(int Cantidad) {
        this.Cantidad = Cantidad;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getMesa() {
        return Mesa;
    }

    public void setMesa(String Mesa) {
        this.Mesa = Mesa;
    }

    public Date getHoraPedido() {
        return HoraPedido;
    }

    public void setHoraPedido(Date HoraPedido) {
        this.HoraPedido = HoraPedido;
    }
   
    
    
 

}
