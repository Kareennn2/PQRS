<%-- 
    Document   : book
    Created on : 27/04/2024, 3:20:18 p. m.
    Author     : Omar Salazar
--%>

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
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

        <!-- bootstrap core css -->
        <link rel="stylesheet" type="text/css" href="css/bootstrap.css" />
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">

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
        <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>


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
                                
                                <li class="nav-item active">
                                    <a class="nav-link" href="index.jsp">LogOut <span class="sr-only">(current)</span> </a>
                                </li>
                            </ul>

                        </div>
                    </nav>
                </div>
            </header>
            <!-- end header section -->
        </div>

        <!-- book section -->
        <section class="book_section layout_padding">
            <div class="container">
                <div class="heading_container">
                    <h2>Mis PQRS</h2>
                </div>
                <% if (request.getAttribute("mensaje") != null) {%>
                <div class="alert alert-info">
                    <%= request.getAttribute("mensaje").toString()%>
                </div>
                <% } %>
                <!-- Formulario para enviar nuevas PQRS -->
                <form action="PQRSHandlerServlet" method="post">
                    <div class="form-group">
                        <label for="tipo">Tipo de solicitud:</label>
                        <select class="form-control" id="tipo" name="tipo">
                            <option>Petición</option>
                            <option>Queja</option>
                            <option>Reclamo</option>
                            <option>Sugerencia</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label for="descripcion">Descripción:</label>
                        <textarea class="form-control" id="descripcion" name="descripcion" required></textarea>
                    </div>
                    <div class="btn_box">
                        <button type="submit" class="btn btn-warning">Enviar</button>
                    </div>
                </form>

                <!-- Tabla para mostrar las PQRS existentes -->
                <table class="table table-bordered mt-4">
                    <thead>
                        <tr>
                            <th>Tipo</th>
                            <th>Descripción</th>
                            <th>Fecha de Creación</th>
                            <th>Estado</th>
                            <th>PDF</th> <!-- Nueva columna para el PDF -->
                            <th>Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<PQRS> pqrsList = (List<PQRS>) request.getAttribute("listaPqrs");
                            if (pqrsList != null && !pqrsList.isEmpty()) {
                                for (PQRS pqrs : pqrsList) {
                        %>
                        <tr>
                            <td><%= pqrs.getTipo()%></td>
                            <td><%= pqrs.getDescripcion()%></td>
                            <td><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(pqrs.getFechaCreacion())%></td>
                            <td><%= pqrs.getEstado()%></td>
                            <td>
                                <% if (pqrs.getPdf() != null) {%>
                                <a href="DownloadPDFServlet?pqrsId=<%= pqrs.getIdPQRS()%>" target="_blank">Ver PDF</a>
                                <% } else { %>
                                No disponible
                                <% }%>
                            </td>
                            <td>
                                <button onclick="setupEditModal('<%= pqrs.getIdPQRS()%>', '<%= pqrs.getTipo()%>', '<%= pqrs.getDescripcion()%>')" class="btn btn-primary">
                                    <i class="fas fa-edit"></i>
                                </button>
                                <a href="DeletePQRS?pqrsId=<%= pqrs.getIdPQRS()%>" class="btn btn-danger" onclick="return confirm('Are you sure?');">
                                    <i class="fas fa-trash-alt"></i>
                                </a>
                                <button type="button" class="btn btn-success" onclick="showUploadPDFModal('<%= pqrs.getIdPQRS()%>')">
                                    <i class="fas fa-file-upload"></i>
                                </button>
                            </td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr><td colspan="6">No hay solicitudes disponibles.</td></tr>
                        <% }%>
                    </tbody>
                </table>

                <!-- Modal para editar PQRS -->
                <div class="modal fade" id="editPQRSModal" tabindex="-1" role="dialog" aria-labelledby="editPQRSModalLabel" aria-hidden="true">
                    <div class="modal-dialog" role="document">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="editPQRSModalLabel">Editar PQRS</h5>
                                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                    <span aria-hidden="true">&times;</span>
                                </button>
                            </div>
                            <form id="editPQRSForm" action="EditPQRS" method="post">
                                <div class="modal-body">
                                    <input type="hidden" id="editIdPQRS" name="pqrsId">
                                    <div class="form-group">
                                        <label for="editTipo">Tipo de Solicitud:</label>
                                        <select class="form-control" id="editTipo" name="tipo">
                                            <option value="Petición">Petición</option>
                                            <option value="Queja">Queja</option>
                                            <option value="Reclamo">Reclamo</option>
                                            <option value="Sugerencia">Sugerencia</option>
                                        </select>
                                    </div>
                                    <div class="form-group">
                                        <label for="editDescripcion">Descripción:</label>
                                        <textarea class="form-control" id="editDescripcion" name="descripcion" required></textarea>
                                    </div>
                                </div>
                                <div class="modal-footer">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                    <button type="submit" class="btn btn-warning">Guardar Cambios</button>
                                </div>
                            </form>
                        </div>
                    </div>  
                </div>

            </div>
            <!-- Modal para subir PDF -->
            <div class="modal fade" id="uploadPDFModal" tabindex="-1" role="dialog" aria-labelledby="uploadPDFModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="uploadPDFModalLabel">Subir PDF</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <form id="uploadPdfForm" action="UploadPDFServlet" method="post" enctype="multipart/form-data">
                            <div class="modal-body">
                                <input type="hidden" name="id_pqrs" id="pdfPqrsId">
                                <div class="form-group">
                                    <label for="pdfFile">Selecciona un archivo PDF:</label>
                                    <input type="file" class="form-control" name="pdf" id="pdfFile" accept="application/pdf" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-dismiss="modal">Cerrar</button>
                                <button type="submit" class="btn btn-warning">Subir PDF</button>
                            </div>
                        </form>
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
                    // Esta función se llama cuando se hace clic en el botón de editar de una PQRS
                    function setupEditModal(pqrsId, tipo, descripcion) {
                        // Configura el formulario con los valores actuales de la PQRS
                        document.getElementById('editIdPQRS').value = pqrsId;
                        document.getElementById('editTipo').value = tipo;
                        document.getElementById('editDescripcion').value = descripcion;
                        $('#editPQRSModal').modal('show'); // Abre el modal
                    }
        </script>
        <script>
            function showUploadPDFModal(pqrsId) {
                document.getElementById('pdfPqrsId').value = pqrsId;
                $('#uploadPDFModal').modal('show');
            }

            document.getElementById('uploadPdfForm').addEventListener('submit', function (event) {
                event.preventDefault(); // Evitar que el formulario se envíe de manera tradicional

                let formData = new FormData(this);

                fetch('UploadPDFServlet', {
                    method: 'POST',
                    body: formData
                }).then(response => response.json())
                        .then(data => {
                            $('#uploadPDFModal').modal('hide'); // Cerrar el modal

                            if (data.status === 'success') {
                                alert(data.message);
                                location.reload(); // Recargar la página para actualizar la tabla
                            } else {
                                alert('Error: ' + data.message);
                            }
                        })
                        .catch(error => {
                            console.error('Error:', error);
                            alert('Ocurrió un error al subir el PDF.');
                        });
            });
        </script>




    </body>

</html>
