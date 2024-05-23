/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.GestionPqrs;
import clases.PQRS;
import clases.Usuario;
import java.io.IOException;
import java.util.List;
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

@WebServlet(name = "DeletePQRS", urlPatterns = {"/DeletePQRS"})
public class DeletePQRS extends HttpServlet {

    @Override
 protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    HttpSession session = request.getSession(false);
    Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
    
    if (usuario == null) {
        request.setAttribute("mensaje", "Debe iniciar sesión para realizar esta acción.");
        request.getRequestDispatcher("login.jsp").forward(request, response);
        return;
    }

    try {
        int pqrsId = Integer.parseInt(request.getParameter("pqrsId"));
        boolean success = GestionPqrs.deletePQRS(pqrsId);
        if (success) {
            request.setAttribute("mensaje", "PQRS eliminada correctamente.");
        } else {
            request.setAttribute("mensaje", "Error al eliminar PQRS.");
        }
    } catch (NumberFormatException e) {
        request.setAttribute("mensaje", "ID inválido.");
    }

    request.getRequestDispatcher("PQRSHandlerServlet").forward(request, response);
 }
}


