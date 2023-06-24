
<%@page import="atg.taglib.json.util.JSONObject"%>
<%@page import="atg.taglib.json.util.JSONObject"%>
<%@page import="atg.taglib.json.util.JSONArray"%>
<%@page import="java.io.InputStreamReader"%>

<%@page import="java.io.BufferedReader"%>
<%@page import="java.net.HttpURLConnection"%>
<%@page import="java.net.URL"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Document</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet"
              integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
                integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
        crossorigin="anonymous"></script>
        <script type="text/javascript" src="https://www.jeasyui.com/easyui/jquery.min.js"></script>
    </head>
    <script>

        $(document).ready(function () {
            $("#insertar").submit(function () {
                cedula = $("#cedulaI").val();
                nombre = $("#nombreI").val();
                apellido = $("#apellidoI").val();
                edad = $("#edadI").val();
                // Crear un objeto con los datos a insertar
                var datos = {
                    cedula: cedula,
                    nombre: nombre,
                    apellido: apellido,
                    edad: edad,
                    estado: "activo"
                };

                $.ajax({
                    url: "http://localhost:8095/grupo3/webresources/persona",
                    type: "POST",
                    data: JSON.stringify(datos),
                    contentType: "application/json",
                    success: function (data) {
                        alert("Los datos se guardaron correctamente");
                        $(location).attr('href', 'index.jsp');
                    },
                    error: function (xhr, status, error) {
                        alert("No se pudo guardar los datos: " + error);
                    }
                });
            });
            $("#editar").submit(function () {
                cedula = $("#cedula").val();
                nombre = $("#nombre").val();
                apellido = $("#apellido").val();
                edad = $("#edad").val();
                //transforma todo en un json
                var datos = {
                    cedula: cedula,
                    nombre: nombre,
                    apellido: apellido,
                    edad: edad,
                    estado: "activo"
                };
                //consume el servicio de editar
                $.ajax({
                    url: "http://localhost:8095/grupo3/webresources/persona/" + cedula,
                    type: "PUT",
                    data: JSON.stringify(datos),
                    contentType: "application/json",
                    success: function (data) {
                        alert("Los datos se actualizaron correctamente");
                        $(location).attr('href', 'index.jsp');
                    },
                    error: function (xhr, status, error) {
                        alert("No se pudo actualizar los datos: " + error);
                    }
                });
            });

            $(".actualizar").click(function () {
                //obtener los datos de la fila y llenar el formulario del exampleModal
                cedula = $(this).parents("tr").find("td")[0].innerHTML;
                nombre = $(this).parents("tr").find("td")[1].innerHTML;
                apellido = $(this).parents("tr").find("td")[2].innerHTML;
                edad = $(this).parents("tr").find("td")[3].innerHTML;
                $("#cedula").val(cedula);
                $("#nombre").val(nombre);
                $("#apellido").val(apellido);
                $("#edad").val(edad);
                $("#exampleModal").modal("show");
            });

            $(".eliminar").click(function (event) {
                fila = $(this).closest("tr");
                cedula = fila.find('td:eq(0)').text();
                $.ajax({
                    url: "http://localhost:8095/grupo3/webresources/persona/" + cedula,
                    type: "DELETE",
                    success: function (data) {
                        alert("Eliminado Correctamente"); // Mostrar el mensaje de la respuesta
                        $(location).attr('href', 'index.jsp'); // Redireccionar a la página index.php
                    }
                });

            });
            $("form").submit(function (event) {
                event.preventDefault();
                // Obtener el valor del campo cedula
                cedula = $("input[name='cedulaB']").val();
                // URL del servicio que deseas consumir, reemplaza {CEDULA} por el valor de la cédula ingresada
                var url = "http://localhost:8095/grupo3/webresources/persona/" + cedula;

                // Realizar la solicitud Ajax
                $.ajax({
                    url: url,
                    type: "GET",
                    dataType: "json",
                    success: function (response) {

                        var eliminar = "<button type='button' class='eliminar'>Eliminar</button>";
                        var actualizar = "<button type='button' class='actualizar'>Actualizar</button>";
                        $("tbody").html("<tr><td>" + response.cedula + "</td><td>" + response.nombre + "</td><td>" + response.apellido + "</td><td>" + response.edad + "</td><td>" + actualizar + "</td><td>" + eliminar + "</td></tr>");
                        $(".actualizar").click(function () {

                            cedula = $(this).parents("tr").find("td")[0].innerHTML;
                            nombre = $(this).parents("tr").find("td")[1].innerHTML;
                            apellido = $(this).parents("tr").find("td")[2].innerHTML;
                            edad = $(this).parents("tr").find("td")[3].innerHTML;
                            $("#cedula").val(cedula);
                            $("#nombre").val(nombre);
                            $("#apellido").val(apellido);
                            $("#edad").val(edad);
                            $("#exampleModal").modal("show");
                        });
                        $(".eliminar").click(function (event) {
                            fila = $(this).closest("tr");
                            cedula = fila.find('td:eq(0)').text();
                            $.ajax({
                                url: "http://localhost:8095/grupo3/webresources/persona/" + cedula,
                                type: "DELETE",
                                success: function (data) {
                                    alert("Eliminado Correctamente"); // Mostrar el mensaje de la respuesta
                                    $(location).attr('href', 'index.jsp'); // Redireccionar a la página index.php
                                }
                            });

                        });
                    },
                    error: function () {
                        // Manejar el caso de error al realizar la solicitud al servicio
                        console.log("Error al consumir el servicio.");
                    }
                });
            });

            $("#cedulaI").keypress(function (e) {
                var cedula = $("#cedulaI").val();
                if (cedula.length == 10) {
                    e.preventDefault();
                }
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    e.preventDefault();
                }
            });

            $("#nombreI").keypress(function (e) {
                var nombre = $("#nombreI").val();
                if (nombre.length == 20) {
                    e.preventDefault();
                }
                if (e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 97 || e.which > 122) && e.which != 32) {
                    e.preventDefault();
                }
            });

            $("#apellidoI").keypress(function (e) {
                var apellido = $("#apellidoI").val();
                if (apellido.length == 20) {
                    e.preventDefault();
                }
                if (e.which != 8 && e.which != 0 && (e.which < 65 || e.which > 90) && (e.which < 97 || e.which > 122) && e.which != 32) {
                    e.preventDefault();
                }
            });

            $("#edadI").keypress(function (e) {
                var edad = $("#edadI").val();
                if (edad.length == 2) {
                    e.preventDefault();
                }
                if (e.which != 8 && e.which != 0 && (e.which < 48 || e.which > 57)) {
                    e.preventDefault();
                }
            });


        });
    </script>
    <button type="button" class="btn-primary" data-bs-toggle='modal' data-bs-target="#insertar">Insertar</button>
    <body>

        <table class="table">
            <thead>
                <tr>
                    <th>Cedula</th>
                    <th>Nombre</th>
                    <th>Apellido</th>
                    <th>Edad</th>
                    <th colspan="2">Acciones</th>
                </tr>
            </thead>
            <tbody>
                <%
                    String url = "http://localhost:8095/grupo3/webresources/persona";
                    String json = "";
                    try {
                        URL serviceUrl = new URL(url);
                        HttpURLConnection connection = (HttpURLConnection) serviceUrl.openConnection();
                        connection.setRequestMethod("GET");
                        connection.setRequestProperty("Accept", "application/json");

                        if (connection.getResponseCode() == HttpURLConnection.HTTP_OK) {
                            BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
                            String line;
                            while ((line = reader.readLine()) != null) {
                                json += line;
                            }
                            reader.close();
                        }
                        connection.disconnect();
                    } catch (Exception e) {
                        e.printStackTrace();
                    }

                    JSONArray datos = new JSONArray(json);
                    for (int i = 0; i < datos.length(); i++) {
                        JSONObject dato = datos.getJSONObject(i);
                %>
                <tr>
                    <td><%= dato.getString("cedula")%></td>
                    <td><%= dato.getString("nombre")%></td>
                    <td><%= dato.getString("apellido")%></td>
                    <td><%= dato.getInt("edad")%></td>
                    <td><button class="eliminar">Eliminar</button></td>
                    <td><button class="actualizar">Editar</button></td>
                </tr>
                <%
                    }
                %>
            </tbody>
        </table>
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="Modificar" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabelled">Actualizar Personas</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="editar">
                            <input type="text" name="cedula" id='cedula' readonly>
                            <input type="text" name="nombre" id='nombre'>
                            <input type="text" name="apellido" id='apellido'>
                            <input type="text" name="edad" id='edad'>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secundary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Guardar cambios</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </table>
        <div class="modal fade" id="insertar" tabindex="-1" aria-labelledby="Insertar" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Insertar Personas</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form id="insertar">
                            <input type="text" name="cedulaI" id='cedulaI'>
                            <input type="text" name="nombreI" id='nombreI'>
                            <input type="text" name="apellidoI" id='apellidoI'>
                            <input type="text" name="edadI" id='edadI'>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secundary" data-bs-dismiss="modal">Cancelar</button>
                                <button type="submit" class="btn btn-primary">Guardar</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            </body>
            </html>