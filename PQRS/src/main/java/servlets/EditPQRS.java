/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.GestionPqrs;
import clases.Usuario;
import java.io.IOException;
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
@WebServlet(name = "EditPQRS", urlPatterns = {"/EditPQRS"})
public class EditPQRS extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirigir a la página principal de PQRS
        response.sendRedirect("Sol_Usuario.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        Usuario usuario = (session != null) ? (Usuario) session.getAttribute("usuario") : null;
        
        if (usuario == null) {
            // Si el usuario no está autenticado, redirigir al formulario de inicio de sesión
            request.setAttribute("mensaje", "Debe iniciar sesión para realizar esta acción.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }

        // Obtener los parámetros de la solicitud
        int pqrsId = Integer.parseInt(request.getParameter("pqrsId"));
        String tipo = request.getParameter("tipo");
        String descripcion = request.getParameter("descripcion");

        // Verificar si el usuario tiene permiso para editar esta PQRS
        // (puedes agregar lógica adicional según tus requisitos)
        boolean isUpdated = GestionPqrs.updatePQRS(pqrsId, tipo, descripcion);
        if (isUpdated) {
            // Si la edición fue exitosa, enviar un mensaje de éxito
            request.setAttribute("mensaje", "PQRS actualizada correctamente.");
        } else {
            // Si ocurrió un error, enviar un mensaje de error
            request.setAttribute("mensaje", "Error al actualizar PQRS.");
        }

        // Redirigir a la página principal de PQRS
        request.getRequestDispatcher("Sol_Usuario.jsp").forward(request, response);
    }
}
