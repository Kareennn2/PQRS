<%-- 
    Document   : book
    Created on : 27/04/2024, 3:20:18 p. m.
    Author     : Omar Salazar
--%>

<%@page import="clases.GestionPqrs"%>
<%@page import="java.util.List"%>
<%@page import="clases.PQRS"%>
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
                                Vanime
                            </span>
                        </a>

                        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                            <span class=""> </span>
                        </button>

                        <div class="collapse navbar-collapse" id="navbarSupportedContent">
                            <ul class="navbar-nav  mx-auto ">
                                <li class="nav-item">
                                    <a class="nav-link" href="index.jsp">VANCASA </a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="menu.jsp">ANIMENU</a>
                                </li>
                                <li class="nav-item active">
                                    <a class="nav-link" href="pqrs.jsp">pqrs <span class="sr-only">(current)</span> </a>
                                </li>
                                <li class="nav-item active">
                                    <a class="nav-link" href="#" onclick="openPasswordModal()">admin <span class="sr-only">(current)</span></a>
                                </li>
                            </ul>

                        </div>
                    </nav>
                </div>
            </header>
            <!-- end header section -->
        </div>

        <!-- book section -->
        <!-- Modal para ingresar la contraseña -->
        <div class="modal fade" id="passwordModal" tabindex="-1" role="dialog" aria-labelledby="passwordModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="passwordModalLabel">Ingresar Contraseña de Administrador</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <input type="password" id="adminPassword" class="form-control" placeholder="Contraseña" required />
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                        <button type="button" class="btn btn-warning" onclick="checkPassword()">Ingresar</button>
                    </div>
                </div>
            </div>
        </div>
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>Iniciar Sesión / Registrarse</h2>
                </div>
                <p>
                    ¡Hola! Esperamos que te encuentres bien.
                    Por favor inicia sesión para presentar tu solicitud.
                    Si no estás registrado, por favor regístrate a continuación.
                </p>

                <!-- Mensaje de respuesta del registro -->
                <% if (request.getAttribute("mensaje") != null) {%>
                <div style="color: red; font-size: 16px; margin-bottom: 20px;">
                    <strong><%= request.getAttribute("mensaje").toString()%></strong>
                </div>
                <% }%>

                <div class="row">
                    <div class="col-md-6">
                        <div class="form_container">

                            <!-- Formulario de Inicio de Sesión -->
                            <form action="LoginServlet" method="post">
                                <h2>Iniciar Sesión</h2>
                                <div>
                                    <input type="email" name="email" class="form-control" placeholder="Correo Electrónico" required />
                                </div>
                                <div>
                                    <input type="password" name="password" class="form-control" placeholder="Contraseña" required />
                                </div>
                                <div class="btn_box">
                                    <button type="submit">Iniciar Sesión</button>
                                </div>
                            </form>

                            <!-- Fin del Formulario de Inicio de Sesión -->

                            <!-- Botón para abrir el modal de registro -->
                            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#registerModal">
                                Registrarse
                            </button>

                            <!-- Modal de Registro -->
                            <div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="registerModalLabel" aria-hidden="true">
                                <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                        <div class="modal-header">
                                            <h5 class="modal-title" id="registerModalLabel">Registrarse</h5>
                                            
                                        </div>
                                        <form action="RegisterServlet" method="post" class="modal-body">
                                            <div class="form-group">
                                                <input type="text" name="nombre" class="form-control" placeholder="Nombre" required />
                                            </div>
                                            <div class="form-group">
                                                <input type="email" name="email" class="form-control" placeholder="Correo Electrónico" required />
                                            </div>
                                            <div class="form-group">
                                                <input type="password" name="password" class="form-control" placeholder="Contraseña" required />
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                                <button type="submit" class="btn btn-primary">Registrar</button>
                                            </div>
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

        </section>



        <!-- footer section -->
        <footer class="footer_section">
            <div class="container">
                <div class="row">
                    <div class="col-md-4 footer-col">
                        <div class="footer_contact">
                            <h4>
                                contactanos
                            </h4>
                            <div class="contact_link_box">
                                <a href="">
                                    <i class="fa fa-map-marker" aria-hidden="true"></i>
                                    <span>
                                        en mi casita
                                    </span>
                                </a>
                                <a href="">
                                    <i class="fa fa-phone" aria-hidden="true"></i>
                                    <span>
                                        Llama al 3008267129
                                    </span>
                                </a>
                                <a href="">
                                    <i class="fa fa-envelope" aria-hidden="true"></i>
                                    <span>
                                        vanime@gmail.com
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 footer-col">
                        <div class="footer_detail">
                            <a href="" class="footer-logo">
                                vanime
                            </a>
                            <p>
                                La mejor combinacion de sabor y entretenimiento
                            </p>
                            <div class="footer_social">
                                <a href="">
                                    <i class="fa fa-facebook" aria-hidden="true"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-twitter" aria-hidden="true"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-linkedin" aria-hidden="true"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-instagram" aria-hidden="true"></i>
                                </a>
                                <a href="">
                                    <i class="fa fa-pinterest" aria-hidden="true"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4 footer-col">
                        <h4>
                            Horario de atencion
                        </h4>
                        <p>
                            Lunes a Sabado
                        </p>
                        <p>
                            10.00 Am -10.00 Pm
                        </p>
                    </div>
                </div>

            </div>
        </footer>
        <!-- footer section -->

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
        
        <script>
      function openPasswordModal() {
    $('#passwordModal').modal('show');
 }

 function checkPassword() {
    var password = $('#adminPassword').val();
    // Aquí puedes realizar la verificación de la contraseña
    // Por ejemplo, puedes compararla con una contraseña predefinida
    if (password === 'vanimeAdministracion24') {
        // Si la contraseña es correcta, redirigir al panel de administración
        window.location.href = 'admin.jsp';
    } else {
        // Si la contraseña es incorrecta, mostrar un mensaje de error
        alert('Contraseña incorrecta');
    }
}   
        </script>      

    </body>
 

</html>
