/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clases;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Omar Salazar
 */
public class GestionAdministrador {

    public static Administrador validarCredenciales(String email, String password) {
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        Administrador admin = null;

        try {
            conn = DatabaseConnection.establecerConexion();
            String sql = "SELECT * FROM Administradores WHERE correo_electronico = ? AND contrasena_hash = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                int idAdmin = rs.getInt("id_administrador");
                String nombre = rs.getString("nombre");
                String correoElectronico = rs.getString("correo_electronico");
                // Puedes agregar más campos aquí si los necesitas
                admin = new Administrador(idAdmin, nombre, correoElectronico);
            }
        } catch (SQLException ex) {
            System.out.println("Error al validar las credenciales del administrador: " + ex.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                System.out.println("Error al cerrar conexiones: " + ex.getMessage());
            }
        }

        return admin;
 
    }
    
    public List<Usuario> obtenerUsuarios() {
        List<Usuario> usuarios = new ArrayList<>();
        DatabaseConnection conn = new DatabaseConnection();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = conn.establecerConexion();
            String sql = "SELECT * FROM Usuarios";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            
            while (resultSet.next()) {
                int idUsuario = resultSet.getInt("id_usuario");
                String nombre = resultSet.getString("nombre");
                String correoElectronico = resultSet.getString("correo_electronico");
                String telefono = resultSet.getString("telefono");
                String contrasenaHash = resultSet.getString("contrasena_hash");
                String rol = resultSet.getString("rol");

                Usuario usuario = new Usuario(idUsuario, nombre, correoElectronico, telefono, contrasenaHash, rol);
                usuarios.add(usuario);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return usuarios;
    }
    
    public List<PQRS> obtenerPQRS() {
        List<PQRS> pqrsList = new ArrayList<>();
        DatabaseConnection conn = new DatabaseConnection();
        try {
            Connection connection = conn.establecerConexion();
            String sql = "SELECT * FROM PQRS";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                int idPQRS = resultSet.getInt("id_pqrs");
                String tipo = resultSet.getString("tipo");
                String descripcion = resultSet.getString("descripcion");
                Date fechaCreacion = resultSet.getDate("fecha_creacion");
                String estado = resultSet.getString("estado");

                PQRS pqrs = new PQRS(idPQRS, tipo, descripcion, fechaCreacion, estado);
                pqrsList.add(pqrs);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return pqrsList;
    }

}
