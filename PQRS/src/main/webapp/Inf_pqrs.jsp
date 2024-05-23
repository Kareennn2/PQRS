<%-- 
    Document   : book
    Created on : 27/04/2024, 3:20:18 p. m.
    Author     : Omar Salazar
--%>

<%@page import="clases.PQRS"%>
<%@page import="clases.GestionAdministrador"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="clases.Usuario"%>
<!DOCTYPE html>
<html>

<head>
  <!-- Basic -->
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <!-- Mobile Metas -->
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
  <!-- Site Metas -->
  <meta name="keywords" content="" />
  <meta name="description" content="" />
  <meta name="author" content="" />
  <link rel="shortcut icon" href="images/favicon.png" type="">

  <title> vanime </title>

  <!-- bootstrap core css -->
  <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />

  <!--owl slider stylesheet -->
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/assets/owl.carousel.min.css" />
  <!-- nice select  -->
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/css/nice-select.min.css" integrity="sha512-CruCP+TD3yXzlvvijET8wV5WxxEh5H8P4cmz0RFbKK6FlZ2sYl3AEsKlLPHbniXKSrDdFewhbmBK5skbdsASbQ==" crossorigin="anonymous" />
  <!-- font awesome style -->
  <link href="css/font-awesome.min.css" rel="stylesheet" />

  <!-- Custom styles for this template -->
  <link href="css/style.css" rel="stylesheet" />
  <!-- responsive style -->
  <link href="css/responsive.css" rel="stylesheet" />

</head>

<body class="sub_page">

  <div class="hero_area">
    <div class="bg-box">
      <img src="images/hero-bg.jpg" alt="">
    </div>
    <!-- header section strats -->
    <header class="header_section">
      <div class="container">
        <nav class="navbar navbar-expand-lg custom_nav-container ">
          <a class="navbar-brand" href="index.jsp">
            <span>
              vanime
            </span>
          </a>

          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class=""> </span>
          </button>

          <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mx-auto">
        <li class="nav-item active">
            <a class="nav-link" href="pqrs.jsp">LOGOUT <i class="fa fa-sign-out" aria-hidden="true"></i> <span class="sr-only">(current)</span> </a>
        </li>
        <li class="nav-item">
                <a class="nav-link" href="Admin2.jsp">HOME</a>
              </li>
    </ul>
</div>

        </nav>
      </div>
    </header>
    <!-- end header section -->
  </div>

     <h2>Listado de Usuarios</h2>
  <%
    GestionAdministrador dbManager = new GestionAdministrador();
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
                <button onclick="setupEditModal('<%= pqrs.getIdPQRS() %>', '<%= pqrs.getTipo() %>', '<%= pqrs.getDescripcion() %>')" class="btn btn-primary">
    <i class="fas fa-eye"></i> Ver
</button>
<a href="DeletePQRS?pqrsId=<%= pqrs.getIdPQRS() %>" class="btn btn-danger" onclick="return confirm('Are you sure?');">
    <i class="fas fa-trash-alt"></i> Eliminar
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

 

  <!-- jQery -->
  <script src="js/jquery-3.4.1.min.js"></script>
  <!-- popper js -->
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous">
  </script>
  <!-- bootstrap js -->
  <script src="js/bootstrap.js"></script>
  <!-- owl slider -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/OwlCarousel2/2.3.4/owl.carousel.min.js">
  </script>
  <!-- isotope js -->
  <script src="https://unpkg.com/isotope-layout@3.0.4/dist/isotope.pkgd.min.js"></script>
  <!-- nice select -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-nice-select/1.1.0/js/jquery.nice-select.min.js"></script>
  <!-- custom js -->
  <script src="js/custom.js"></script>
  

</body>

</html>
