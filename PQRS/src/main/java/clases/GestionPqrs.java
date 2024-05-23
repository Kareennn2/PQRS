/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Omar Salazar
 */
public class GestionPqrs {
    
    public static boolean insertPQRS(String email, String tipo, String descripcion) {
        String sql = "INSERT INTO PQRS (id_usuario, tipo, descripcion) VALUES ((SELECT id_usuario FROM Usuarios WHERE correo_electronico = ?), ?, ?)";
        try (Connection conn = DatabaseConnection.establecerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, email);
            pstmt.setString(2, tipo);
            pstmt.setString(3, descripcion);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error al insertar PQRS: " + e.getMessage());
            return false;
        }
    }
    
    public static List<PQRS> obtenerPQRS(String email) {
    List<PQRS> listaPqrs = new ArrayList<>();
    String sql = "SELECT PQRS.id_pqrs, PQRS.tipo, PQRS.descripcion, PQRS.fecha_creacion, PQRS.estado FROM PQRS JOIN Usuarios ON PQRS.id_usuario = Usuarios.id_usuario WHERE Usuarios.correo_electronico = ?";
    try (Connection conn = DatabaseConnection.establecerConexion();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, email);
        try (ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                PQRS pqrs = new PQRS(
                    rs.getInt("id_pqrs"), // Asegúrate de que el nombre de la columna sea correcto
                    rs.getString("tipo"),
                    rs.getString("descripcion"),
                    rs.getTimestamp("fecha_creacion"),
                    rs.getString("estado")
                );
                listaPqrs.add(pqrs);
            }
        }
    } catch (SQLException e) {
        System.out.println("Error al obtener PQRS: " + e.getMessage());
    }
    return listaPqrs;
}

    public static boolean deletePQRS(int idPQRS) {
        String sql = "DELETE FROM PQRS WHERE id_pqrs = ?";
        try (Connection conn = DatabaseConnection.establecerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idPQRS);
            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error al eliminar PQRS: " + e.getMessage());
            return false;
        }
    }
public static boolean updatePQRS(int idPQRS, String tipo, String descripcion) {
    String sql = "UPDATE PQRS SET tipo = ?, descripcion = ? WHERE id_pqrs = ?";
    try (Connection conn = DatabaseConnection.establecerConexion();
         PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, tipo);
        pstmt.setString(2, descripcion);
        pstmt.setInt(3, idPQRS);

        int affectedRows = pstmt.executeUpdate();
        return affectedRows > 0;
    } catch (SQLException e) {
        System.out.println("Error al actualizar PQRS: " + e.getMessage());
        return false;
    }
}
public static boolean subirPDF(int idPQRS, InputStream pdfStream) {
        String sql = "UPDATE PQRS SET pdf = ? WHERE id_pqrs = ?";
        try (Connection conn = DatabaseConnection.establecerConexion();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setBinaryStream(1, pdfStream);
            pstmt.setInt(2, idPQRS);

            int affectedRows = pstmt.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.out.println("Error al subir PDF: " + e.getMessage());
            return false;
        }
    }





}
