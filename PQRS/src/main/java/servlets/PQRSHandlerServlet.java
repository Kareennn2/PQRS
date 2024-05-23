/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.GestionPqrs;
import clases.PQRS;
import clases.Usuario;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
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
@WebServlet(name = "PQRSHandlerServlet", urlPatterns = {"/PQRSHandlerServlet"})
public class PQRSHandlerServlet extends HttpServlet {
 
     
   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario != null) {
            List<PQRS> pqrsList = GestionPqrs.obtenerPQRS(usuario.getCorreoElectronico());
            request.setAttribute("listaPqrs", pqrsList);
        } else {
            request.setAttribute("mensaje", "Debe iniciar sesión para ver sus solicitudes.");
        }

        RequestDispatcher dispatcher = request.getRequestDispatcher("Sol_Usuario.jsp");
        dispatcher.forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String tipo = request.getParameter("tipo");
        String descripcion = request.getParameter("descripcion");
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;

        if (usuario != null) {
            boolean isInserted = GestionPqrs.insertPQRS(usuario.getCorreoElectronico(), tipo, descripcion);
            if (isInserted) {
                request.setAttribute("mensaje", "Su solicitud ha sido enviada exitosamente.");
            } else {
                request.setAttribute("mensaje", "Error al enviar la solicitud. Intente de nuevo.");
            }
            doGet(request, response); // Llama a doGet para mostrar la lista actualizada junto con el mensaje
        } else {
            request.setAttribute("mensaje", "Debe iniciar sesión para enviar una solicitud.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("Sol_Usuario.jsp");
            dispatcher.forward(request, response);
        }
    }

}
