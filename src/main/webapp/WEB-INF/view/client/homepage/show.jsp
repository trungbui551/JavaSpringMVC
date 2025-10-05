<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

            <html lang="en">

            <head>
                <style>
                    /* CSS Fix cho Pagination - Phù hợp với LapTopShop */
                    .pagination {
                        display: flex !important;
                        padding-left: 0 !important;
                        list-style: none !important;
                        border-radius: 8px !important;
                        margin: 20px 0 !important;
                        justify-content: center !important;
                    }

                    .page-item {
                        display: inline-block !important;
                        margin: 0 2px !important;
                    }

                    .page-link {
                        position: relative !important;
                        display: block !important;
                        padding: 8px 12px !important;
                        line-height: 1.25 !important;
                        color: #666 !important;
                        text-decoration: none !important;
                        background-color: #fff !important;
                        border: 1px solid #ddd !important;
                        border-radius: 6px !important;
                        transition: all 0.3s ease !important;
                        font-weight: 500 !important;
                    }

                    .page-item:first-child .page-link {
                        margin-left: 0 !important;
                    }

                    .page-item:last-child .page-link {}

                    .page-link:hover {
                        z-index: 2 !important;
                        color: #fff !important;
                        text-decoration: none !important;
                        background-color: #8BC34A !important;
                        border-color: #8BC34A !important;
                        transform: translateY(-1px) !important;
                        box-shadow: 0 2px 4px rgba(139, 195, 74, 0.3) !important;
                    }

                    .page-item.active .page-link {
                        z-index: 3 !important;
                        color: #fff !important;
                        background-color: #4CAF50 !important;
                        border-color: #4CAF50 !important;
                        box-shadow: 0 2px 6px rgba(76, 175, 80, 0.4) !important;
                        font-weight: 600 !important;
                    }

                    /* Styling đặc biệt cho Previous/Next */
                    .page-item .page-link[href*="Previous"],
                    .page-item .page-link[href*="Next"] {
                        font-weight: 600 !important;
                        color: #4CAF50 !important;
                    }

                    .page-item .page-link[href*="Previous"]:hover,
                    .page-item .page-link[href*="Next"]:hover {
                        background-color: #4CAF50 !important;
                        color: #fff !important;
                    }

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
                <c:if test="${not empty message}">
                    <script>
                        alert("${message}");
                    </script>
                </c:if>
                <!-- Spinner Start -->
                <div id="spinner"
                    class="show w-100 vh-100 bg-white position-fixed translate-middle top-50 start-50  d-flex align-items-center justify-content-center">
                    <div class="spinner-grow text-primary" role="status"></div>
                </div>

                <jsp:include page="../layout/header.jsp" />
                <jsp:include page="../layout/banner.jsp" />


                <div class="container-fluid fruite py-5" id="san-pham">
                    <div class="container py-5">
                        <div class="tab-class text-center">
                            <div class="row g-4">
                                <div class="col-lg-4 text-start">
                                    <h1>Sản Phẩm Nổi Bật</h1>
                                </div>
                                <div class="col-lg-8 text-end ">
                                    <ul class="nav nav-pills d-inline-flex text-center mb-5">
                                        <li class="nav-item">
                                            <a class="d-flex m-2 py-2 bg-light rounded-pill active"
                                                data-bs-toggle="pill" href="#tab-1">
                                                <span class="text-dark" style="width: 130px;">All Products</span>
                                            </a>
                                        </li>

                                    </ul>
                                </div>
                            </div>
                            <div class="tab-content">
                                <div id="tab-1" class="tab-pane fade show p-0 active">
                                    <div class="row g-4">
                                        <div class="col-lg-12">
                                            <div class="row g-4 ">
                                                <tr>
                                                    <c:forEach var="pro" items="${pros}">
                                                        <div class="col-md-6 col-lg-4 col-xl-3 ">
                                                            <div class="rounded position-relative fruite-item">
                                                                <div class="fruite-img card-img-top">
                                                                    <img src="/images/product/${pro.image}"
                                                                        class="img-fluid w-100 rounded-top" alt="">
                                                                </div>
                                                                <div class="text-white bg-secondary px-3 py-1 rounded position-absolute"
                                                                    style="top: 10px; left: 10px;">Sale</div>
                                                                <div
                                                                    class="p-4 border border-secondary border-top-0 rounded-bottom">
                                                                    <a href="/product/${pro.id}">
                                                                        ${pro.name}
                                                                    </a>


                                                                    <p style="font-size: 13px;">${pro.shortDesc}</p>
                                                                    <div
                                                                        class="d-flex justify-content-center flex-lg-wrap">
                                                                        <p class="text-dark fs-5 fw-bold mb-0">
                                                                            <fmt:formatNumber type="number"
                                                                                value="${pro.price}" /> đ
                                                                        </p>
                                                                        <form action="/add-product-to-cart/${pro.id}"
                                                                            method="post">
                                                                            <div>
                                                                                <input type="hidden"
                                                                                    name="${_csrf.parameterName}"
                                                                                    value="${_csrf.token}" />

                                                                            </div>
                                                                            <button
                                                                                class="btn border border-secondary rounded-pill px-3 text-primary"><i
                                                                                    class="fa fa-shopping-bag me-2 text-primary"></i>
                                                                                Add to cart</button>
                                                                        </form>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </div>
                                                    </c:forEach>
                                                </tr>
                                            </div>
                                        </div>
                                    </div>
                                </div>




                            </div>

                        </div>
                    </div>
                </div>


                <ul class="pagination justify-content-center" style="display: flex; list-style: none; padding: 0;">
                    <!-- Nút Previous -->
                    <c:if test="${currentPage > 1}">
                        <li class="page-item" style="display: inline-block;">
                            <a class="page-link" href="?pageNo=${currentPage - 1}"
                                style="padding: 0.5rem 0.75rem; border: 1px solid #dee2e6; text-decoration: none; background: white; color: #007bff;">Previous</a>
                        </li>
                    </c:if>

                    <!-- Các số trang -->
                    <c:forEach var="i" begin="1" end="${totalPages}">
                        <li class="page-item ${currentPage == i ? 'active' : ''}" style="display: inline-block;">
                            <a class="page-link"
                                href="?${not empty keyword ? 'keyword='.concat(keyword).concat('&') : ''}pageNo=${i}"
                                style="padding: 0.5rem 0.75rem; border: 1px solid #dee2e6; text-decoration: none; margin-left: -1px; ${currentPage == i ? 'background: #007bff; color: white;' : 'background: white; color: #007bff;'}">${i}</a>
                        </li>
                    </c:forEach>

                    <!-- Nút Next -->
                    <c:if test="${currentPage < totalPages}">
                        <li class="page-item" style="display: inline-block;">
                            <a class="page-link" href="?pageNo=${currentPage + 1}"
                                style="padding: 0.5rem 0.75rem; border: 1px solid #dee2e6; text-decoration: none; background: white; color: #007bff;">Next</a>
                        </li>
                    </c:if>
                </ul>



                <!-- Fruits Shop End-->




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
                                <!--/*** This template is free as long as you keep the below author’s credit link/attribution link/backlink. ***/-->
                                <!--/*** If you'd like to use the template without the below author’s credit link/attribution link/backlink, ***/-->
                                <!--/*** you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". ***/-->
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