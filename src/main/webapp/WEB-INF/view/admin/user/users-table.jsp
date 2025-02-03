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
                <div class="container mt-5 col-9 mx-auto">
                    <div class="row">
                        <div class="d-flex justify-content-between">
                            <h2>Users Table</h2>
                            <a href="/admin/user/create" class="btn btn-primary">Create a user</a>
                        </div>
                        <hr />
                        <table class="table table-bordered table-hover">
                            <thead>
                                <tr>
                                    <!-- scope="col" -->
                                    <th>ID</th>
                                    <th>Email</th>
                                    <th>Fullname</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <!-- scope="row" -->
                                    <th>1</th>
                                    <td>nkl@gmail.com</td>
                                    <td>NKL</td>
                                    <td>
                                        <button class="btn btn-success">View</button>
                                        <button class="btn btn-warning mx-2">Update</button>
                                        <button class="btn btn-danger">Delete</button>
                                    </td>
                                </tr>
                                <tr>
                                    <!-- scope="row" -->
                                    <th>2</th>
                                    <td>dqm@gmail.com</td>
                                    <td>DQM</td>
                                    <td>
                                        <button class="btn btn-success">View</button>
                                        <button class="btn btn-warning mx-2">Update</button>
                                        <button class="btn btn-danger">Delete</button>
                                    </td>
                                </tr>
                            </tbody>
                        </table>

                    </div>

                </div>
            </body>

            </html>