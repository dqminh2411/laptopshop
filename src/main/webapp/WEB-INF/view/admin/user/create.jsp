<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@taglib prefix="spring" uri="http://www.springframework.org/tags" %>

                <!DOCTYPE html>
                <html lang="en">

                <head>
                    <meta charset="utf-8" />
                    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                    <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                    <meta name="author" content="Hỏi Dân IT" />
                    <title>Create User</title>
                    <link href="/css/styles.css" rel="stylesheet" />
                    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                        crossorigin="anonymous"></script>
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                    <script>
                        $(document).ready(() => {
                            const avatarFile = $("#avatarFile");
                            avatarFile.change(function (e) {
                                const imgURL = URL.createObjectURL(e.target.files[0]);
                                $("#avatarPreview").attr("src", imgURL);
                                $("#avatarPreview").css({ "display": "block" });
                            });
                        });
                    </script>

                </head>

                <body class="sb-nav-fixed">
                    <jsp:include page="../layout/header.jsp" />
                    <div id="layoutSidenav">
                        <jsp:include page="../layout/sidebar.jsp" />
                        <div id="layoutSidenav_content">
                            <main>
                                <div class="container-fluid px-4">
                                    <h1 class="mt-4 ">Manage Users</h1>
                                    <ol class="breadcrumb mb-4 ">
                                        <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                        <li class="breadcrumb-item active">Users</li>
                                    </ol>
                                    <div class="mt-5">
                                        <div class="row">
                                            <div class="col-md-6 col-12 mx-auto">
                                                <h3>Create a user</h3>
                                                <hr />
                                                <!-- Spring form tags -->
                                                <form:form method="post" action="/admin/user/create"
                                                    modelAttribute="newUser" target="_self" class="row"
                                                    enctype="multipart/form-data">
                                                    <div class="mb-3 col-md-6">

                                                        <label for="email" class="form-label">Email:</label>
                                                        <!-- Instead of using id (complicated if we have multiple forms,...), use attribute "path" of Spring to identify inputs -->
                                                        <!-- The value of path must match the attribute of the model User  -->
                                                        <c:set var="emailError">
                                                            <form:errors path="email" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <form:input type="email"
                                                            class="form-control ${not empty emailError? 'is-invalid':''}"
                                                            path="email" />
                                                        ${emailError}
                                                    </div>
                                                    <div class="mb-3 col-md-6">
                                                        <label class="form-label">Password:</label>
                                                        <c:set var="passwordError">
                                                            <form:errors path="password" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <form:input type="password"
                                                            class="form-control ${not empty passwordError? 'is-invalid':''}"
                                                            path="password" />
                                                        ${passwordError}
                                                    </div>
                                                    <div class="mb-3 col-md-6">
                                                        <label class="form-label">Phone number:</label>
                                                        <c:set var="phoneError">
                                                            <form:errors path="phone" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <form:input type="text"
                                                            class="form-control ${not empty phoneError? 'is-invalid':''}"
                                                            path="phone" />
                                                        ${phoneError}
                                                    </div>
                                                    <div class="mb-3 col-md-6">
                                                        <label class="form-label">Full Name:</label>
                                                        <c:set var="nameError">
                                                            <form:errors path="fullName" cssClass="invalid-feedback" />
                                                        </c:set>
                                                        <form:input type="text"
                                                            class="form-control ${not empty nameError? 'is-invalid':''}"
                                                            path="fullName" />
                                                        ${nameError}
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Address:</label>
                                                        <form:input type="text" class="form-control" path="address" />
                                                    </div>
                                                    <div class="mb-3 col-md-4">
                                                        <label class="form-label">Role:</label>
                                                        <form:select class="form-select" path="role.name">
                                                            <form:option value="ADMIN" selected="true">ADMIN
                                                            </form:option>
                                                            <form:option value="USER">USER</form:option>
                                                        </form:select>
                                                    </div>

                                                    <div class="mb-3 col-md-8">
                                                        <label for="avatarFile" class="form-label">Avatar</label>
                                                        <input class="form-control" type="file" id="avatarFile"
                                                            accept=".png, .jpg, .jpeg" name="avatarFile" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 250px; display:none"
                                                            alt="avatar preview" id="avatarPreview" />
                                                    </div>
                                                    <div>
                                                        <button type="submit" class="btn btn-primary">Create</button>

                                                    </div>
                                                </form:form>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                            </main>
                            <jsp:include page="../layout/footer.jsp" />
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
                        crossorigin="anonymous"></script>
                    <script src="/js/scripts.js"></script>

                </body>

                </html>