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
                                                <div class="col-12 mx-auto">
                                                    <h3>Order detail</h3>
                                                    <div class="table-responsive">
                                                        <table class="table table-bordered">
                                                            <thead>
                                                                <tr>
                                                                    <th scope="col">Sản phẩm</th>
                                                                    <th scope="col">Tên sản phẩm</th>
                                                                    <th scope="col">Giá cả</th>
                                                                    <th scope="col">Số lượng</th>
                                                                    <th scope="col">Thành tiền</th>

                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <c:forEach var="o" items="${order.orderDetails}">
                                                                    <tr>
                                                                        <th scope="row">
                                                                            <div class="d-flex align-items-center">
                                                                                <img src="/images/products/${o.product.image}"
                                                                                    class="img-fluid me-5 rounded-circle"
                                                                                    style="width: 80px; height: 80px;"
                                                                                    alt="">
                                                                            </div>
                                                                        </th>
                                                                        <td>
                                                                            <p class="mb-0 mt-4"><a
                                                                                    href="/product/${o.product.id}"
                                                                                    target="_blank">${o.product.name}</a>
                                                                            </p>
                                                                        </td>
                                                                        <td>
                                                                            <p class="mb-0 mt-4">
                                                                                <fmt:formatNumber
                                                                                    value="${o.product.price}" />đ
                                                                            </p>
                                                                        </td>
                                                                        <td>
                                                                            <p class="mb-0 mt-4"> ${o.quantity}
                                                                            </p>
                                                                        </td>
                                                                        <td>
                                                                            <p class="mb-0 mt-4"
                                                                                data-cart-detail-id="${p.id}">
                                                                                <fmt:formatNumber
                                                                                    value="${o.product.price * o.quantity}" />
                                                                                đ
                                                                            </p>
                                                                        </td>

                                                                    </tr>
                                                                </c:forEach>


                                                            </tbody>
                                                        </table>
                                                    </div>
                                                    <div class="card" style="width: 60%;">

                                                        <div class="card-header">
                                                            Order information
                                                        </div>
                                                        <ul class="list-group list-group-flush">
                                                            <li class="list-group-item">Id: ${order.id}</li>
                                                            <li class="list-group-item">User email: ${order.user.email}
                                                            </li>
                                                            <li class="list-group-item">Order time:
                                                                ${f:formatLocalDateTime(order.orderTime,"HH:mm:ss
                                                                dd-MM-yyyy")}</li>
                                                            <li class="list-group-item">Receiver's Name:
                                                                ${order.receiverName}
                                                            </li>
                                                            <li class="list-group-item">Receiver's Address:
                                                                ${order.receiverAddress} </li>
                                                            <li class="list-group-item">Receiver's Phone:
                                                                ${order.receiverPhone}
                                                            </li>
                                                            <li class="list-group-item">Total Price:
                                                                <fmt:formatNumber value="${order.totalPrice}" />đ
                                                            </li>
                                                            <li class="list-group-item">Status: ${order.status}</li>
                                                        </ul>
                                                    </div>

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