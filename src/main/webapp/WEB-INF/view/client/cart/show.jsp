<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>

                <html lang="en">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Giỏ hàng</title>

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
                                <li class="breadcrumb-item active">Cart</li>
                            </ol>
                            <c:if test="${empty cartProducts}">
                                <div class="alert alert-danger">Bạn chưa thêm sản phẩm nào</div>
                            </c:if>
                            <c:if test="${not empty cartProducts}">
                                <div class="table-responsive">
                                    <table class="table">
                                        <thead>
                                            <tr>
                                                <th scope="col">Sản phẩm</th>
                                                <th scope="col">Tên sản phẩm</th>
                                                <th scope="col">Giá cả</th>
                                                <th scope="col">Số lượng</th>
                                                <th scope="col">Thành tiền</th>
                                                <th scope="col">Xoá</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="p" items="${cartProducts}" varStatus="status">
                                                <tr>
                                                    <th scope="row">
                                                        <div class="d-flex align-items-center">
                                                            <img src="/images/products/${p.product.image}"
                                                                class="img-fluid me-5 rounded-circle"
                                                                style="width: 80px; height: 80px;" alt="">
                                                        </div>
                                                    </th>
                                                    <td>
                                                        <p class="mb-0 mt-4"><a href="/product/${p.product.id}"
                                                                target="_blank">${p.product.name}</a></p>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4">
                                                            <fmt:formatNumber value="${p.product.price}" />đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <div class="input-group quantity mt-4" style="width: 100px;">
                                                            <div class="input-group-btn">
                                                                <button
                                                                    class="btn btn-sm btn-minus rounded-circle bg-light border">
                                                                    <i class="fa fa-minus"></i>
                                                                </button>
                                                            </div>
                                                            <input type="text"
                                                                class="form-control form-control-sm text-center border-0"
                                                                value="${p.quantity}" data-cart-detail-id="${p.id}"
                                                                data-cart-detail-price="${p.product.price}"
                                                                data-cart-detail-index="${status.index}">
                                                            <div class="input-group-btn">
                                                                <button
                                                                    class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                                    <i class="fa fa-plus"></i>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <p class="mb-0 mt-4" data-cart-detail-id="${p.id}">
                                                            <fmt:formatNumber value="${p.product.price * p.quantity}" />
                                                            đ
                                                        </p>
                                                    </td>
                                                    <td>
                                                        <form method="post" action="/cart/delete-product/${p.id}">
                                                            <input type="hidden" name="${_csrf.parameterName}"
                                                                value="${_csrf.token}" />
                                                            <button
                                                                class="btn btn-md rounded-circle bg-light border mt-4">
                                                                <i class="fa fa-times text-danger"></i>
                                                            </button>
                                                        </form>

                                                    </td>
                                                </tr>
                                            </c:forEach>


                                        </tbody>
                                    </table>
                                </div>
                            </c:if>


                            <div class="row g-4 justify-content-start">

                                <div class="col-sm-8 col-md-7 col-lg-6">
                                    <div class="bg-light rounded">
                                        <div class="p-4">
                                            <h1 class="display-6 mb-4">Thông tin đơn hàng </h1>
                                            <div class="d-flex justify-content-between mb-4">
                                                <h5 class="mb-0 me-4">Tạm tính:</h5>
                                                <p class="mb-0" data-cart-detail-total="${totalPrice}">
                                                    <fmt:formatNumber value="${totalPrice}" />đ
                                                </p>
                                            </div>
                                            <div class="d-flex justify-content-between">
                                                <h5 class="mb-0 me-4">Phí vận chuyển</h5>
                                                <div class="">
                                                    <p class="mb-0">
                                                        <fmt:formatNumber value="0" />đ
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                            <h5 class="mb-0 ps-4 me-4">Tổng tiền</h5>
                                            <p class="mb-0 pe-4" data-cart-detail-total="${totalPrice}">
                                                <fmt:formatNumber value="${totalPrice}" />đ
                                            </p>
                                        </div>
                                        <form:form method="post" action="/confirm-checkout" modelAttribute="cart">
                                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                            <div style="display: none">
                                                <c:forEach var="p" items="${cart.cartDetails}" varStatus="status">
                                                    <div class="mb-3">
                                                        <div class="form-group">
                                                            <label>Id:</label>
                                                            <form:input class="form-control" value="${p.id}"
                                                                path="cartDetails[${status.index}].id" type="number" />
                                                        </div>
                                                        <div class="form-group">
                                                            <label>Quantity:</label>
                                                            <form:input class="form-control" value="${p.quantity}"
                                                                path="cartDetails[${status.index}].quantity"
                                                                type="number" />
                                                        </div>
                                                    </div>
                                                </c:forEach>
                                            </div>
                                            <button
                                                class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4">Xác
                                                nhận đặt hàng</button>
                                        </form:form>

                                    </div>



                                </div>
                            </div>
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