package model;

/**
 *
 * @author Moises Romero
 */
public class Producto {
    private int IdProducto, IdCategoria;
    private String Nombre, Descripcion, Foto, Activo; 
    private double Precio1, Precio2, Precio3;
    
    public Producto(){
        
    }

    public Producto(int IdProducto, int IdCategoria, String Nombre, String Descripcion, String Foto, String Activo, double Precio1, double Precio2, double Precio3) {
        this.IdProducto = IdProducto;
        this.IdCategoria = IdCategoria;
        this.Nombre = Nombre;
        this.Descripcion = Descripcion;
        this.Foto = Foto;
        this.Activo = Activo;
        this.Precio1 = Precio1;
        this.Precio2 = Precio2;
        this.Precio3 = Precio3;
    }

    public int getIdProducto() {
        return IdProducto;
    }

    public void setIdProducto(int IdProducto) {
        this.IdProducto = IdProducto;
    }

    public int getIdCategoria() {
        return IdCategoria;
    }

    public void setIdCategoria(int IdCategoria) {
        this.IdCategoria = IdCategoria;
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

    public String getFoto() {
        return Foto;
    }

    public void setFoto(String Foto) {
        this.Foto = Foto;
    }

    public String getActivo() {
        return Activo;
    }

    public void setActivo(String Activo) {
        this.Activo = Activo;
    }

    public double getPrecio1() {
        return Precio1;
    }

    public void setPrecio1(double Precio1) {
        this.Precio1 = Precio1;
    }

    public double getPrecio2() {
        return Precio2;
    }

    public void setPrecio2(double Precio2) {
        this.Precio2 = Precio2;
    }

    public double getPrecio3() {
        return Precio3;
    }

    public void setPrecio3(double Precio3) {
        this.Precio3 = Precio3;
    }
    
    
}
