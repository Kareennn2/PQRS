/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.Administrador;
import clases.GestionAdministrador;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author Omar Salazar
 */
@WebServlet(name = "AdminLoginServlet", urlPatterns = {"/AdminLoginServlet"})
public class AdminLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Verificar las credenciales del administrador
        Administrador admin = GestionAdministrador.validarCredenciales(email, password);
        if (admin != null) {
            // Si las credenciales son válidas, crear una sesión para el administrador
            HttpSession session = request.getSession();
            session.setAttribute("admin", admin);
            // Redirigir al panel de administrador
            response.sendRedirect("Admin2.jsp");
        } else {
            // Si las credenciales no son válidas, mostrar un mensaje de error
            request.setAttribute("mensaje", "Correo electrónico o contraseña incorrectos.");
            // Mantener al administrador en la página de inicio de sesión
            request.getRequestDispatcher("pqrs.jsp").forward(request, response);
        }
    }
}
 



