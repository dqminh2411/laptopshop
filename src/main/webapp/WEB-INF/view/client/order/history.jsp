<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Lịch sử mua hàng</title>

                    <!-- Google Web Fonts -->
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Open+Sans:wght@400;600&family=Raleway:wght@600;800&display=swap"
                        rel="stylesheet">

                    <!-- Icon Font Stylesheet -->
                    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" />
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
                        rel="stylesheet">

                    <!-- Libraries Stylesheet -->
                    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
                    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


                    <!-- Customized Bootstrap Stylesheet -->
                    <link href="/client/css/bootstrap.min.css" rel="stylesheet">

                    <!-- Template Stylesheet -->
                    <link href="/client/css/style.css" rel="stylesheet">

                </head>

                <body>
                    <!-- Spinner Start -->
                    <div id="spinner"
                        class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                        <div class="spinner-grow text-primary" role="status"></div>
                    </div>
                    <!-- Spinner End -->

                    <jsp:include page="../layout/header.jsp" />

                    <!-- Cart start -->
                    <div class="container-fluid py-5">
                        <div class="container py-5">
                            <ol class="breadcrumb mb-4">
                                <li class="breadcrumb-item active"><a href="/">Home</a> </li>
                                <li class="breadcrumb-item active">Lịch sử mua hàng</li>
                            </ol>
                            <c:if test="${empty orders}">
                                <div class="alert alert-danger">Bạn chưa có đơn hàng nào</div>
                            </c:if>
                            <c:if test="${not empty orders}">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Sản phẩm</th>
                                                <th scope="col">Tên sản phẩm</th>
                                                <th scope="col">Giá cả</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Thành tiền</th>
                                                <th scope="col">Trạng thái</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="o" items="${orders}">
                                                <tr>
                                                    <td colspan="2">Order Id: ${o.id}</td>

                                                    <td colspan="3">
                                                        <fmt:formatNumber value="${o.totalPrice}" />đ
                                                    </td>

                                                    <td colspan="1">${o.status}</td>
                                                </tr>
                                                <c:forEach var="od" items="${o.orderDetails}">
                                                    <tr>
                                                        <th scope="row">
                                                            <div class="d-flex align-items-center">
                                                                <img src="/images/products/${od.product.image}"
                                                                    class="img-fluid me-5 rounded-circle"
                                                                    style="width: 80px; height: 80px;" alt="">
                                                            </div>
                                                        </th>
                                                        <td>
                                                            <p class="mb-0 mt-4"><a href="/product/${od.product.id}"
                                                                    target="_blank">${od.product.name}</a></p>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4">
                                                                <fmt:formatNumber value="${od.product.price}" />đ
                                                            </p>
                                                        </td>
                                                        <td>
                                                            <div class="input-group quantity mt-4"
                                                                style="width: 100px;">

                                                                <input type="text"
                                                                    class="form-control form-control-sm text-center border-0"
                                                                    value="${od.quantity}" data-cart-detail-id="${p.id}"
                                                                    data-cart-detail-price="${od.product.price}"
                                                                    data-cart-detail-index="${status.index}">

                                                            </div>
                                                        </td>
                                                        <td>
                                                            <p class="mb-0 mt-4" data-cart-detail-id="${od.id}">
                                                                <fmt:formatNumber
                                                                    value="${od.product.price * od.quantity}" />
                                                                đ
                                                            </p>
                                                        </td>
                                                        <td>

                                                        </td>
                                                    </tr>
                                                </c:forEach>

                                            </c:forEach>


                                        </tbody>
                                    </table>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    </div>
                    <jsp:include page="../layout/footer.jsp" />


                    <!-- Back to Top -->
                    <a href="#" class="btn btn-primary border-3 border-primary rounded-circle back-to-top"><i
                            class="fa fa-arrow-up"></i></a>


                    <!-- JavaScript Libraries -->
                    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script src="/client/lib/easing/easing.min.js"></script>
                    <script src="/client/lib/waypoints/waypoints.min.js"></script>
                    <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
                    <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

                    <!-- Template Javascript -->
                    <script src="/client/js/main.js"></script>
                </body>

                </html>