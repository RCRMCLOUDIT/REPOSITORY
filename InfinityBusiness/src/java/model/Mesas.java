package model;

/**
 *
 * @author Moises Romero
 */
public class Mesas {

    private int IdMesa;
    private String Nombre;
    private String Estado;
    private String Activo;

    public Mesas() {

    }

    public Mesas(int IdMesa, String Nombre, String Estado, String Activo) {
        this.IdMesa = IdMesa;
        this.Nombre = Nombre;
        this.Estado = Estado;
        this.Activo = Activo;
    }

    public int getIdMesa() {
        return IdMesa;
    }

    public void setIdMesa(int IdMesa) {
        this.IdMesa = IdMesa;
    }

    public String getNombre() {
        return Nombre;
    }

    public void setNombre(String Nombre) {
        this.Nombre = Nombre;
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
    
    
}
