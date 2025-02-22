<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
                <%@taglib uri="http://vn.hoidanit.laptopshop.utils/functions" prefix="f" %>
                    <!DOCTYPE html>
                    <html lang="en">

                    <head>
                        <meta charset="utf-8" />
                        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
                        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
                        <meta name="description" content="Hỏi Dân IT - Dự án laptopshop" />
                        <meta name="author" content="Hỏi Dân IT" />
                        <title>Order Details - ${order.id}</title>
                        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
                            rel="stylesheet" />
                        <link href="/css/styles.css" rel="stylesheet" />
                        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                            crossorigin="anonymous"></script>
                        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>


                    </head>

                    <body class="sb-nav-fixed">
                        <jsp:include page="../layout/header.jsp" />
                        <div id="layoutSidenav">
                            <jsp:include page="../layout/sidebar.jsp" />

                            <div id="layoutSidenav_content">
                                <main>
                                    <div class="container-fluid px-4">
                                        <h1 class="mt-4">Manage Orders</h1>
                                        <ol class="breadcrumb mb-4 ">
                                            <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                            <li class="breadcrumb-item active"><a href="/admin/order">Orders</a></li>
                                            <li class="breadcrumb-item active">${order.id}</li>
                                        </ol>
                                        <div class="container mt-5">
                                            <div class="row">
                                                <div class="col-12 mx-auto justify-content-center">


                                                    <div style="width: 60%;">

                                                        <div class="card-header">
                                                            <h3>Order detail</h3>
                                                        </div>
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">Id: ${order.id}</li>
                                                            <li class="list-group-item">User email: ${order.user.email}
                                                            </li>
                                                            <li class="list-group-item">Order time:
                                                                ${f:formatLocalDateTime(order.orderTime,"HH:mm:ss
                                                                dd-MM-yyyy")}</li>

                                                            <li class="list-group-item">Total Price:
                                                                <fmt:formatNumber value="${order.totalPrice}" />đ
                                                            </li>
                                                        </ul>
                                                        <form action="/admin/order/update" method="post">
                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                            <input type="hidden" name="id" value="${order.id}" />
                                                            <span class="col-auto"><label class="col-form-label">Status:
                                                                </label></span>
                                                            <select class="form-select" name="status">

                                                                <c:set var="curStatus" value="${order.status}" />
                                                                <c:forEach var="stt"
                                                                    items="${['PENDING','SHIPPING','COMPLETE','CANCEL']}">
                                                                    <c:if test="${stt == curStatus}">
                                                                        <option value="${stt}" selected>
                                                                            ${stt}</option>
                                                                    </c:if>
                                                                    <c:if test="${stt != curStatus}">
                                                                        <option value="${stt}">
                                                                            ${stt}</option>
                                                                    </c:if>
                                                                </c:forEach>


                                                            </select>


                                                            <button class="btn btn-warning mt-3">Update</button>
                                                        </form>
                                                    </div>



                                                    <c:if test="${not empty message}">
                                                        <div class="alert alert-success mt-3">
                                                            ${message}
                                                        </div>
                                                    </c:if>


                                                    <a class="btn btn-primary mt-3" href="/admin/order">Back</a>
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