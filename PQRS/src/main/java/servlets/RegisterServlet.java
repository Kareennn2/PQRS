/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;
import clases.GestionPqrs;
import clases.GestionUsuario;
import clases.PQRS;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.List;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;
import org.mindrot.jbcrypt.BCrypt;

/**
 *
 * @author Omar Salazar
 */

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        boolean registrado = GestionUsuario.registrarUsuario(nombre, email, password);

        if (registrado) {
            request.setAttribute("mensaje", "Registro exitoso!");
            request.getRequestDispatcher("pqrs.jsp").forward(request, response);
        } else {
            request.setAttribute("mensaje", "Error en el registro. Por favor intente nuevamente.");
            request.getRequestDispatcher("pqrs.jsp").forward(request, response);
        }
    }
  
}

