/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.GestionUsuario;
import clases.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
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
@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {
@Override
protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    Usuario usuario = GestionUsuario.validarUsuario(email, password);

    if (usuario != null) {
        HttpSession session = request.getSession();
        session.setAttribute("usuario", usuario);
        response.sendRedirect("Sol_Usuario.jsp"); // Página de inicio después del login
    } else {
        request.setAttribute("mensaje", "Credenciales inválidas. Intente de nuevo.");
        RequestDispatcher dispatcher = request.getRequestDispatcher("pqrs.jsp");
        dispatcher.forward(request, response);
    }
}

}
