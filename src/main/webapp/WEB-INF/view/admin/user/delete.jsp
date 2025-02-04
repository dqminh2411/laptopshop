<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <html lang="en">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Create user</title>
                <!-- Latest compiled and minified CSS -->
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

                <!-- Latest compiled JavaScript -->
                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
            </head>

            <body>
                <div class="container mt-5 col-9">
                    <div class="row">
                        <h3>Delete user with id: ${id}</h3>

                        <hr />
                        <div class="alert alert-warning">
                            Are you sure to delete this user?
                        </div>
                        <form:form action="/admin/user/delete" method="post" modelAttribute="deletedUser">
                            <form:input type="hidden" path="id" value="${id}" />
                            <button type="submit" class="btn btn-danger">Delete</button>
                        </form:form>
                    </div>
                </div>
            </body>

            </html>