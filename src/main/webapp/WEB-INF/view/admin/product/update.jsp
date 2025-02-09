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
                <title>Update Product</title>
                <link href="/css/styles.css" rel="stylesheet" />
                <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
                <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

                <script>
                    $(document).ready(() => {
                        const productImage = $("#productImage");
                        productImage.change(function (e) {
                            const imgURL = URL.createObjectURL(e.target.files[0]);
                            $("#productImagePreview").attr("src", imgURL);
                            $("#productImagePreview").css({ "display": "block" });
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
                                <h1 class="mt-4 ">Manage Products</h1>
                                <ol class="breadcrumb mb-4 ">
                                    <li class="breadcrumb-item"><a href="/admin">Dashboard</a></li>
                                    <li class="breadcrumb-item active">Products</li>
                                </ol>
                                <div class="mt-5">
                                    <div class="row">
                                        <div class="col-md-6 col-12 mx-auto">
                                            <h3>Update a product</h3>
                                            <hr />
                                            <!-- Spring form tags -->
                                            <form:form method="post" action="/admin/product/update"
                                                modelAttribute="product" target="_self" class="row"
                                                enctype="multipart/form-data">
                                                <c:set var="nameError">
                                                    <form:errors path="name" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="priceError">
                                                    <form:errors path="price" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="detailDescError">
                                                    <form:errors path="detailDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="shortDescError">
                                                    <form:errors path="shortDesc" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="factoryError">
                                                    <form:errors path="factory" cssClass="invalid-feedback" />
                                                </c:set>
                                                <c:set var="quantityError">
                                                    <form:errors path="quantity" cssClass="invalid-feedback" />
                                                </c:set>

                                                <c:set var="targetError">
                                                    <form:errors path="target" cssClass="invalid-feedback" />
                                                </c:set>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Id:</label>
                                                    <form:input type="number" class="form-control" readonly="true"
                                                        path="id" />
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label for="name" class="form-label">Name:</label>
                                                    <!-- Instead of using id (complicated if we have multiple forms,...), use attribute "path" of Spring to identify inputs -->
                                                    <!-- The value of path must match the attribute of the model User  -->
                                                    <form:input type="text"
                                                        class="form-control ${not empty nameError? 'is-invalid':''}"
                                                        path="name" />
                                                    ${nameError}
                                                </div>

                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Price:</label>
                                                    <form:input type="number"
                                                        class="form-control ${not empty priceError? 'is-invalid':''}"
                                                        path="price" />
                                                    ${priceError}
                                                </div>
                                                <div class="mb-3 col-12">
                                                    <label class="form-label">Detailed Description:</label><br />
                                                    <form:textarea path="detailDesc"
                                                        class="form-control ${not empty detailDescError? 'is-invalid':''}" />
                                                    ${detailDescError}
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Short Description:</label>
                                                    <form:input type="text"
                                                        class="form-control ${not empty shortDescError? 'is-invalid':''}"
                                                        path="shortDesc" />
                                                    ${shortDescError}
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Quantity:</label>
                                                    <form:input type="number"
                                                        class="form-control ${not empty quantityError? 'is-invalid':''}"
                                                        path="quantity" min="0" />
                                                    ${quantityError}
                                                </div>

                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Factory:</label>
                                                    <form:select
                                                        class="form-select ${not empty factoryError? 'is-invalid':''}"
                                                        path="factory">
                                                        <form:option value="APPLE">Apple (MacBook)
                                                        </form:option>
                                                        <form:option value="ASUS">Asus</form:option>
                                                        <form:option value="LENOVO">Lenovo</form:option>
                                                        <form:option value="DELL">Dell</form:option>
                                                        <form:option value="LG">LG</form:option>
                                                        <form:option value="ACER">Acer</form:option>
                                                    </form:select>
                                                    ${factoryError}
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Target:</label>
                                                    <form:select
                                                        class="form-select ${not empty targetError? 'is-invalid':''}"
                                                        path="target">
                                                        <form:option value="GAMING">Gaming</form:option>
                                                        <form:option value="SINHVIEN-VANPHONG">Sinh viên - Văn phòng
                                                        </form:option>
                                                        <form:option value="THIET-KE-DO-HOA">Thiết kế đồ họa
                                                        </form:option>
                                                        <form:option value="MONG-NHE">Mỏng nhẹ</form:option>
                                                        <form:option value="DOANH-NHAN">Doanh nhân</form:option>
                                                    </form:select>
                                                    ${targetError}
                                                </div>
                                                <div class="mb-3 col-md-6">
                                                    <label class="form-label">Image:</label>
                                                    <input class="form-control ${not empty imageError? 'is-invalid':''}"
                                                        type="file" id="productImage" accept=".png,.jpeg,.jpg"
                                                        name="productImage" />

                                                </div>
                                                <div class="col-12 mb-3">
                                                    <img style="max-height: 250px" alt="product image preview"
                                                        id="productImagePreview" src="${productImageSrc}" />
                                                </div>
                                                <div>
                                                    <button type="submit" class="btn btn-primary">Update</button>
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