<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <style>
                    .card-img-top {
                        width: 100%;
                        height: 200px;
                        /* bạn chọn chiều cao phù hợp */
                        object-fit: cover;
                        /* giữ tỷ lệ, cắt bớt phần thừa */
                        border-radius: 8px;
                        /* nếu muốn bo góc */
                    }
                </style>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Home</title>
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





                <div class="md-5">
                    <hr />
                </div>



                <!-- Cart Page Start -->
                <div class="container-fluid py-5 pt-5">
                    <div class="container py-5 pt-5">
                        <div class="mb-3">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="/">Home</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Chi Tiết Giỏ Hàng</li>
                            </ol>
                        </div>
                        <div class="table-responsive">
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Products</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Price</th>
                                        <th scope="col">Quantity</th>
                                        <th scope="col">Total</th>
                                        <th scope="col">Handle</th>
                                    </tr>
                                </thead>
                                <tbody>

                                    <c:forEach var="de" items="${cartDetail}">
                                        <tr>

                                            <th scope="row">
                                                <div class="d-flex align-items-center">
                                                    <img src="/images/product/${de.product.image}"
                                                        class="img-fluid me-5 rounded-circle"
                                                        style="width: 80px; height: 80px;" alt="" alt="">
                                                </div>
                                            </th>
                                            <td>
                                                <p class="mb-0 mt-4">${de.product.name}</p>
                                            </td>
                                            <td>

                                                <p class="mb-0 mt-4">
                                                    <fmt:formatNumber type="number" value="${de.price}" /> đ
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
                                                        value="${de.quantity}">
                                                    <div class="input-group-btn">
                                                        <button
                                                            class="btn btn-sm btn-plus rounded-circle bg-light border">
                                                            <i class="fa fa-plus"></i>
                                                        </button>
                                                    </div>
                                                </div>
                                            </td>
                                            <td>

                                                <p class="mb-0 mt-4">
                                                    <fmt:formatNumber type="number" value="${de.price*de.quantity}" /> đ
                                                </p>
                                            </td>
                                            <td>
                                                <button class="btn btn-md rounded-circle bg-light border mt-4">
                                                    <i class="fa fa-times text-danger"></i>
                                                </button>
                                            </td>

                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <div class="mt-5">
                            <input type="text" class="border-0 border-bottom rounded me-5 py-3 mb-4"
                                placeholder="Coupon Code">
                            <button class="btn border-secondary rounded-pill px-4 py-3 text-primary" type="button">Apply
                                Coupon</button>
                        </div>
                        <div class="row g-4 justify-content-end">
                            <div class="col-8"></div>
                            <div class="col-12 col-md-8">
                                <div class="bg-light rounded">
                                    <div class="p-4">
                                        <h1 class="display-6 mb-4">Cart <span class="fw-normal">Total</span></h1>
                                        <div class="d-flex justify-content-between mb-4">
                                            <h5 class="mb-0 me-4">Subtotal:</h5>
                                            <p class="mb-0">
                                                <span id="subtotal">
                                                    <fmt:formatNumber type="number" value="${totalPrice}" /> đ
                                                </span>
                                            </p>
                                        </div>
                                        <div class="d-flex justify-content-between">
                                            <h5 class="mb-0 me-4">Shipping</h5>
                                            <div class="">
                                                <p class="mb-0" id="shipping">0 đ</p>
                                            </div>
                                        </div>
                                        <p class="mb-0 text-end">Shipping to Ukraine.</p>
                                    </div>
                                    <div class="py-4 mb-4 border-top border-bottom d-flex justify-content-between">
                                        <h5 class="mb-0 ps-4 me-4">Total</h5>
                                        <p class="mb-0 pe-4"><span id="total"></span></p>
                                    </div>

                                    <button
                                        class="btn border-secondary rounded-pill px-4 py-3 text-primary text-uppercase mb-4 ms-4"
                                        type="button">Proceed Checkout</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <script>
                    function calculateTotal() {
                        // Lấy giá trị text trong span
                        let subtotal = document.getElementById("subtotal").innerText;
                        let shipping = document.getElementById("shipping").innerText;

                        // Bỏ dấu phẩy nếu có, và convert sang số
                        subtotal = parseFloat(subtotal.replace(/,/g, ""));
                        shipping = parseFloat(shipping.replace(/,/g, ""));

                        // Tính tổng
                        let total = subtotal + shipping;

                        // Hiển thị ra ô Total
                        document.getElementById("total").innerText = total.toLocaleString() + " đ";
                    }

                    // Gọi hàm khi load trang
                    window.onload = calculateTotal;
                </script>
                <!-- Cart Page End -->


                <!-- Featurs Section Start -->
                <jsp:include page="../layout/feature.jsp" />
                <!-- Featurs Section End -->





                <!-- Footer Start -->
                <jsp:include page="../layout/footer.jsp" />
                <!-- Footer End -->

                <!-- Copyright Start -->
                <div class="container-fluid copyright bg-dark py-4">
                    <div class="container">
                        <div class="row">
                            <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                                <span class="text-light"><a href="#"><i
                                            class="fas fa-copyright text-light me-2"></i>Your
                                        Site Name</a>, All right reserved.</span>
                            </div>
                            <div class="col-md-6 my-auto text-center text-md-end text-white">

                                Designed By <a class="border-bottom" href="https://htmlcodex.com">HTML Codex</a>
                                Distributed
                                By <a class="border-bottom" href="https://themewagon.com">ThemeWagon</a>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Copyright End -->



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