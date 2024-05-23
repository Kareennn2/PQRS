/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;

import clases.DatabaseConnection;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Omar Salazar
 */
@WebServlet("/DownloadPDFServlet")
public class DownloadPDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idPqrsStr = request.getParameter("pqrsId");
        if (idPqrsStr == null || idPqrsStr.isEmpty()) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid PQRS ID.");
            return;
        }

        int idPqrs;
        try {
            idPqrs = Integer.parseInt(idPqrsStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid PQRS ID format.");
            return;
        }

        try (Connection connection = DatabaseConnection.establecerConexion()) {
            String sql = "SELECT pdf FROM PQRS WHERE id_pqrs = ?";
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setInt(1, idPqrs);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                byte[] pdfBytes = resultSet.getBytes("pdf");
                if (pdfBytes != null) {
                    response.setContentType("application/pdf");
                    response.setContentLength(pdfBytes.length);
                    response.setHeader("Content-Disposition", "inline; filename=\"document.pdf\"");

                    try (OutputStream out = response.getOutputStream()) {
                        out.write(pdfBytes);
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND, "PDF not found.");
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "PQRS not found.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error: " + e.getMessage());
        }
    }
}
