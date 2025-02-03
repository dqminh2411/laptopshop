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
                <div class="container mt-5">
                    <div class="row">
                        <div class="col-md-6 col-12 mx-auto">
                            <h3>Create a user</h3>
                            <hr />
                            <!-- Spring form tags -->
                            <form:form method="post" action="/admin/user/create" modelAttribute="newUser"
                                target="_self">
                                <div class="mb-3">
                                    <label for="email" class="form-label">Email:</label>
                                    <!-- Instead of using id (complicated if we have multiple forms,...), use attribute "path" of Spring to identify inputs -->
                                    <!-- The value of path must match the attribute of the model User  -->
                                    <form:input type="email" class="form-control" path="email" />
                                    <div id="emailHelp" class="form-text">We'll never share your email with anyone else.
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Password:</label>
                                        <form:input type="password" class="form-control" path="password" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Phone number:</label>
                                        <form:input type="text" class="form-control" path="phone" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Full Name:</label>
                                        <form:input type="text" class="form-control" path="fullName" />
                                    </div>
                                    <div class="mb-3">
                                        <label class="form-label">Address:</label>
                                        <form:input type="text" class="form-control" path="address" />
                                    </div>

                                    <button type="submit" class="btn btn-primary">Create</button>
                            </form:form>
                        </div>

                    </div>
                </div>
            </body>

            </html>