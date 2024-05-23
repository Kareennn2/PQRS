<%@ page import="clases.PQRS" %>
<%@ page import="java.util.List" %>
<%@ page import="DatabaseManager" %>

<%
    DatabaseManager dbManager = new DatabaseManager();
    List<PQRS> pqrsList = dbManager.obtenerPQRS();
    request.setAttribute("listaPqrs", pqrsList);
%>

<!-- Tabla para mostrar las PQRS existentes -->
<table class="table table-bordered mt-4">
    <thead>
        <tr>
            <th>Tipo</th>
            <th>Descripción</th>
            <th>Fecha de Creación</th>
            <th>Estado</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <%
            if (pqrsList != null && !pqrsList.isEmpty()) {
                for (PQRS pqrs : pqrsList) {
        %>
        <tr>
            <td><%= pqrs.getTipo()%></td>
            <td><%= pqrs.getDescripcion()%></td>
            <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(pqrs.getFechaCreacion())%></td>
            <td><%= pqrs.getEstado()%></td>
            <td>
                <button onclick="setupEditModal('<%= pqrs.getIdPQRS()%>', '<%= pqrs.getTipo()%>', '<%= pqrs.getDescripcion()%>')" class="btn btn-primary">
                    <i class="fas fa-edit"></i>
                </button>
                <a href="DeletePQRS?pqrsId=<%= pqrs.getIdPQRS()%>" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                    <i class="fas fa-trash-alt"></i>
                </a>
            </td> 
        </tr>
        <%
            }
        } else {
        %>
        <tr><td colspan="5">No hay solicitudes disponibles.</td></tr>
        <% }%>
    </tbody>
</table>
