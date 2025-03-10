<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <!DOCTYPE html>
            <html lang="en">

            <head>
                <meta charset="utf-8" />
                <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                <meta name="author" content="Hỏi Dân IT" />
                <title>Update User</title>
                <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
                <script>
                    $(document).ready(() => {
                        const orgImage = "${user.avatar}";
                        if (orgImage) {
                            const imgURL = "/images/avatars/" + orgImage;
                            $("#avatarPreview").attr("src", imgURL);
                            $("#avatarPreview").css({ "display": "block" });

                        }

                        const avatarImage = $("#avatarFile");
                        avatarImage.change(function (e) {
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
                                <h1 class="mt-4">Manage Users</h1>
                                <ol class="breadcrumb mb-4">
                                    <li class="breadcrumb-item active"><a href="/admin">Dashboard</a> / Users</li>
                                </ol>
                                <div class=" mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update a user</h3>
                                            <hr />
                                            <form:form method="post" action="/admin/user/update" modelAttribute="user"
                                                target="_self">
                                                <div class="mb-3">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="text" class="form-control" path="id"
                                                        readonly="true" />
                                                </div>
                                                <div class="mb-3">
                                                    <label for="email" class="form-label">Email:</label>
                                                    <form:input type="email" class="form-control" path="email"
                                                        disabled="true" />
                                                    <div id="emailHelp" class="form-text">We'll never share your email
                                                        with
                                                        anyone else.
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
                                                    <div class="mb-3">
                                                        <label class="form-label">Role: </label>
                                                        <form:select class="form-select" path="role.name">
                                                            <form:option value="ADMIN">ADMIN</form:option>
                                                            <form:option value="USER">USER</form:option>
                                                        </form:select>
                                                    </div>
                                                    <div class="mb-3">
                                                        <label class="form-label">Avatar: </label>
                                                        <form:input type="file" id="avatarFile" name="avatarFile"
                                                            class="form-control" accept=".png, .jpg, .jpeg"
                                                            path="avatar" />
                                                    </div>
                                                    <div class="col-12 mb-3">
                                                        <img style="max-height: 250px; display: none;"
                                                            alt="avatar preview" id="avatarPreview"
                                                            src="/images/avatars/${user.avatar}" />
                                                    </div>

                                                    <button type="submit" class="btn btn-primary">Update</button>
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