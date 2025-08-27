<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- Bootstrap CSS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

        <!-- Bootstrap JS (bao gồm Popper) -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <!-- Navbar Brand-->
            <a class="navbar-brand ps-3" href="admin">Laptop Store</a>
            <!-- Sidebar Toggle-->
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i
                    class="fas fa-bars"></i></button>
            <!-- Navbar Search-->
            <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0">

            </form>

            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                </a>
                <div class="dropdown my-auto">
                    <a href="#" class="dropdown-toggle" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                        aria-expanded="false">

                        <i class="fas fa-user fa-2x"></i>
                    </a>

                    <ul class="dropdown-menu  dropdown-menu-lg-end p-4" style="min-width: 250px; max-width: 90vw;"
                        aria-labelledby="dropdownMenuLink">
                        <li class="d-flex align-items-center flex-column" style="width: 100%;">
                            <img style="width: 150px; height: 150px; border-radius: 50%; overflow: hidden;"
                                src="/images/avatar/${sessionScope.images}" />
                            <div class="text-center my-3">
                                <c:out value="${sessionScope.fullname}" />

                            </div>
                        </li>

                        <li><a class="dropdown-item" href="#">Quản lý tài khoản</a></li>
                        <li><a class="dropdown-item" href="#">Lịch sử mua hàng</a></li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>
                        <li>
                            <form method="post" action="/logout">
                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                <button class="dropdown-item">Đăng xuất</button>
                            </form>
                        </li>
                    </ul>
        </nav>