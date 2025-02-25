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
                        <title>Order</title>
                        <!-- url=localhost:8080/css/styles.css -->
                        <link href="/css/styles.css" rel="stylesheet" />
                        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
                            crossorigin="anonymous"></script>
                    </head>

                    <body class="sb-nav-fixed">
                        <jsp:include page="../layout/header.jsp" />
                        <div id="layoutSidenav">
                            <jsp:include page="../layout/sidebar.jsp" />
                            <div id="layoutSidenav_content">
                                <main>
                                    <div class="container-fluid px-4">
                                        <h1 class="mt-4">Manage orders</h1>
                                        <ol class="breadcrumb mb-4">
                                            <li class="breadcrumb-item active"><a href="/admin">Dashboard</a></li>
                                            <li class="breadcrumb-item active">Orders</li>
                                        </ol>
                                        <c:if test="${not empty message}">
                                            <div class="alert alert-success">
                                                ${message}
                                            </div>
                                        </c:if>

                                        <div class="mt-5 col-12 mx-auto">
                                            <div class="row">
                                                <div class="d-flex justify-content-start mb-2">
                                                    <h3>Order Table</h3>

                                                </div>
                                                <hr />
                                                <table class="table table-bordered table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>ID đơn hàng</th>
                                                            <th>Email người đặt</th>
                                                            <th>Thời gian đặt</th>
                                                            <th>Trị giá</th>
                                                            <th>Trạng thái</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <c:forEach var="o" items="${orders}">
                                                            <tr>
                                                                <td>${o.id}</td>
                                                                <td>${o.user.email}</td>
                                                                <td>
                                                                    ${f:formatLocalDateTime(o.orderTime,"HH:mm:ss
                                                                    dd-MM-yyyy")}

                                                                </td>
                                                                <td>
                                                                    <fmt:formatNumber value="${o.totalPrice}" /> đ
                                                                </td>
                                                                <td>${o.status}</td>
                                                                <td>
                                                                    <a href="/admin/order/${o.id}"
                                                                        class="btn btn-success">View</a>
                                                                    <a href="/admin/order/update/${o.id}"
                                                                        class="btn btn-warning">Update</a>
                                                                    <a href="/admin/order/delete/${o.id}"
                                                                        class="btn btn-danger">Delete</a>
                                                                </td>
                                                            </tr>
                                                        </c:forEach>
                                                    </tbody>
                                                </table>
                                                <nav aria-label="Page navigation example">
                                                    <ul class="pagination justify-content-center">
                                                        <li class="page-item">
                                                            <a class="page-link ${currentPage eq 1? 'disabled':''}"
                                                                href="/admin/order?page=${currentPage-1}"
                                                                aria-label="Previous">
                                                                <span aria-hidden="true">&laquo;</span>
                                                                <span class="sr-only">Previous</span>
                                                            </a>
                                                        </li>
                                                        <c:forEach begin="1" end="${totalPages}" varStatus="loop">
                                                            <li class="page-item"><a
                                                                    class="${loop.index eq currentPage? 'active page-link':'page-link'}"
                                                                    href="/admin/order?page=${loop.index}">${loop.index}</a>
                                                            </li>
                                                        </c:forEach>


                                                        <li class="page-item">
                                                            <a class="page-link ${currentPage eq totalPages? 'disabled':''}"
                                                                href="/admin/order?page=${currentPage+1}"
                                                                aria-label="Next">
                                                                <span aria-hidden="true">&raquo;</span>
                                                                <span class="sr-only">Next</span>
                                                            </a>
                                                        </li>
                                                    </ul>
                                                </nav>
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