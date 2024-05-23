/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package servlets;


import clases.DatabaseConnection;
import clases.GestionPqrs;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.json.JSONObject;

/**
 *
 * @author Omar Salazar
 */
@WebServlet("/UploadPDFServlet")
@MultipartConfig(maxFileSize = 1024 * 1024 * 5) // 5MB
public class UploadPDFServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        JSONObject jsonResponse = new JSONObject();

        String idPqrsStr = request.getParameter("id_pqrs");
        if (idPqrsStr == null || idPqrsStr.isEmpty()) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid PQRS ID.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        int idPqrs;
        try {
            idPqrs = Integer.parseInt(idPqrsStr);
        } catch (NumberFormatException e) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "Invalid PQRS ID format.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        Part filePart = request.getPart("pdf");
        if (filePart == null || filePart.getSize() == 0) {
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "No PDF file uploaded.");
            response.getWriter().write(jsonResponse.toString());
            return;
        }

        try (InputStream pdfInputStream = filePart.getInputStream()) {
            try (Connection connection = DatabaseConnection.establecerConexion()) {
                String sql = "UPDATE PQRS SET pdf = ? WHERE id_pqrs = ?";
                PreparedStatement statement = connection.prepareStatement(sql);
                statement.setBlob(1, pdfInputStream);
                statement.setInt(2, idPqrs);

                int rowsUpdated = statement.executeUpdate();
                if (rowsUpdated > 0) {
                    jsonResponse.put("status", "success");
                    jsonResponse.put("message", "PDF uploaded successfully.");
                } else {
                    jsonResponse.put("status", "error");
                    jsonResponse.put("message", "Failed to update database.");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                jsonResponse.put("status", "error");
                jsonResponse.put("message", "Database error: " + e.getMessage());
            }
        } catch (IOException e) {
            e.printStackTrace();
            jsonResponse.put("status", "error");
            jsonResponse.put("message", "IO error: " + e.getMessage());
        }

        response.getWriter().write(jsonResponse.toString());
    }
}