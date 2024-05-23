/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;


/**
 *
 * @author Omar Salazar
 */


public class GestionUsuario {
    
    public static boolean registrarUsuario(String nombre, String email, String password) {
    Connection conn = DatabaseConnection.establecerConexion();
    String sql = "INSERT INTO Usuarios (nombre, correo_electronico, contrasena_hash) VALUES (?, ?, ?)";
    
    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
        pstmt.setString(1, nombre);
        pstmt.setString(2, email);
        // Aquí utilizamos BCrypt para hashear la contraseña
        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
        pstmt.setString(3, hashedPassword);

        int resultado = pstmt.executeUpdate();
        return resultado > 0;
    } catch (SQLException e) {
        System.out.println("Error al registrar el usuario: " + e.getMessage());
        return false;
    } finally {
        try {
            if (conn != null) conn.close();
        } catch (SQLException ex) {
            System.out.println("Error al cerrar la conexión: " + ex.getMessage());
        }
    }
}

    
    public static Usuario validarUsuario(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Usuario usuario = null;

        try {
            conn = DatabaseConnection.establecerConexion();
            String sql = "SELECT * FROM Usuarios WHERE correo_electronico = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String hashedPassword = rs.getString("contrasena_hash");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    // Las credenciales son válidas, creamos un objeto Usuario y lo devolvemos
                    usuario = new Usuario(
                        rs.getInt("id_usuario"),
                        rs.getString("nombre"),
                        rs.getString("correo_electronico"),
                        rs.getString("telefono"),
                        rs.getString("contrasena_hash"),
                        rs.getString("rol")
                    );
                }
            }
        } catch (SQLException ex) {
            System.out.println("Error al validar el usuario: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                System.out.println("Error al cerrar conexiones: " + ex.getMessage());
            }
        }

        return usuario;
    }

    
}