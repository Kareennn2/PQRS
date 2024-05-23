package clases;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class PQRS {
    
    private int idPQRS; 
    private String tipo;
    private String descripcion;
    private Date fechaCreacion;
    private String estado;

    public PQRS(int idPQRS, String tipo, String descripcion, Date fechaCreacion, String estado) {
        this.idPQRS = idPQRS;
        this.tipo = tipo;
        this.descripcion = descripcion;
        this.fechaCreacion = fechaCreacion;
        this.estado = estado;
    }
    
    private byte[] pdf;
    
    public int getIdPQRS() {
        return idPQRS;
    }

    public void setIdPQRS(int idPQRS) {
        this.idPQRS = idPQRS;
    }

    public String getTipo() {
        return tipo;
    }

    public void setTipo(String tipo) {
        this.tipo = tipo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public Date getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Date fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    public String getEstado() {
        return estado;
    }

    public void setEstado(String estado) {
        this.estado = estado;
    }
    
    public byte[] getPdf() {
        byte[] pdfData = null;
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            // Establecer conexión con la base de datos (suponiendo que tienes una clase para manejar la conexión)
            connection = DatabaseConnection.establecerConexion();
            
            // Preparar la consulta SQL para obtener el PDF
            String sql = "SELECT pdf FROM PQRS WHERE id_pqrs = ?";
            statement = connection.prepareStatement(sql);
            statement.setInt(1, idPQRS);
            
            // Ejecutar la consulta
            resultSet = statement.executeQuery();
            
            // Si se encuentra un resultado, obtener el PDF
            if (resultSet.next()) {
                pdfData = resultSet.getBytes("pdf");
            }
        } catch (SQLException e) {
            e.printStackTrace(); // Manejo de excepciones: puedes personalizar esto según tus necesidades
        } finally {
            // Cerrar recursos
            try {
                if (resultSet != null) {
                    resultSet.close();
                }
                if (statement != null) {
                    statement.close();
                }
                if (connection != null) {
                    connection.close();
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Manejo de excepciones: puedes personalizar esto según tus necesidades
            }
        }

        return pdfData;
    }
}
