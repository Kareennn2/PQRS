/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Omar Salazar
 */
@WebServlet(name = "AdminAccessServlet", urlPatterns = {"/AdminAccessServlet"})
public class AdminAccessServlet extends HttpServlet {

     private static final String ADMIN_JSP = "Admin2.jsp";
    private static final String ADMIN_KEY = "vanimeAdministracion24";

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Obtener la clave de la URL
        String key = request.getParameter("key");

        // Verificar si la clave es correcta
        if (key != null && key.equals(ADMIN_KEY)) {
            // La clave es correcta, redirigir al panel de administración
            response.sendRedirect(ADMIN_JSP);
        } else {
            // La clave es incorrecta, redirigir a una página de acceso denegado
            response.sendRedirect("pqrs.jsp");
        }
    }
}
