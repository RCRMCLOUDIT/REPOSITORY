package model;

/**
 *
 * @author Moises Romero
 */
public class Habitaciones {

    private int IdHab, IdTipoHab, NumeroHab;
    private String Nombre, Descripcion, Estado, Activo, TipoHab;
    private double Precio;

    public Habitaciones() {

    }

    public Habitaciones(int IdHab, String TipoHab, String Nombre, int NumeroHab, String Descripcion, double Precio, String Estado, String Activo) {
        this.IdHab = IdHab;
        this.TipoHab = TipoHab;
        this.Nombre = Nombre;
        this.NumeroHab = NumeroHab;
        this.Descripcion = Descripcion;
        this.Precio = Precio;
        this.Estado = Estado;
        this.Activo = Activo;

    }

    public int getIdHab() {
        return IdHab;
    }

    public void setIdHab(int IdHab) {
        this.IdHab = IdHab;
    }

    public String getTipoHab() {
        return TipoHab;
    }

    public void setTipoHab(String TipoHab) {
        this.TipoHab = TipoHab;
    }

    public int getNumeroHab() {
        return NumeroHab;
    }

    public void setNumeroHab(int NumeroHab) {
        this.NumeroHab = NumeroHab;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
    }

    public String getDescripcion() {
        return Descripcion;
    }

    public void setDescripcion(String Descripcion) {
        this.Descripcion = Descripcion;
    }

    public String getEstado() {
        return Estado;
    }

    public void setEstado(String Estado) {
        this.Estado = Estado;
    }

    public String getActivo() {
        return Activo;
    }

    public void setActivo(String Activo) {
        this.Activo = Activo;
    }

    public double getPrecio() {
        return Precio;
    }

    public void setPrecio(double Precio) {
        this.Precio = Precio;
    }

}
