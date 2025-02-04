<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>All Users</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            </head>

            <body>
                <div class="container mt-5">
                    <h3>User detail</h3>
                    <div class="card" style="width: 18rem;">
                        <div class="card-header">
                            Id: ${user.id}
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Email: ${user.email}</li>
                            <li class="list-group-item">Fullname: ${user.fullName}</li>
                            <li class="list-group-item">Address: ${user.address}</li>
                            <li class="list-group-item">Phone: ${user.phone}</li>
                        </ul>
                    </div>

                </div>

            </body>

            </html>