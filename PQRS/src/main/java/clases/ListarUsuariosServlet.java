/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package clases;

import static com.mysql.cj.conf.PropertyKey.PASSWORD;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import static javax.servlet.SessionTrackingMode.URL;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Omar Salazar
 */
@WebServlet("/ListarUsuariosServlet")
public class ListarUsuariosServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/DB_PQRS";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "admin";

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Usuario> usuarios = new ArrayList<>();
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            String sql = "SELECT * FROM Usuarios";
            PreparedStatement statement = connection.prepareStatement(sql);
            ResultSet resultSet = statement.executeQuery();
            System.out.println("agregando datos");
            while (resultSet.next()) {
                int idUsuario = resultSet.getInt("id_usuario");
                String nombre = resultSet.getString("nombre");
                String correoElectronico = resultSet.getString("correo_electronico");
                String telefono = resultSet.getString("telefono");
                String contrasenaHash = resultSet.getString("contrasena_hash");
                String rol = resultSet.getString("rol");
                System.out.println("agregando datos");
                Usuario usuario = new Usuario(idUsuario, nombre, correoElectronico, telefono, contrasenaHash, rol);
                usuarios.add(usuario);
                System.out.println(usuario);
            }

            connection.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("usuarios", usuarios);
        request.getRequestDispatcher("listaUsuarios.jsp").forward(request, response);
    }
}



