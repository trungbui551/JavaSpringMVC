<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!-- jQuery phải load trước -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <!-- SockJS + STOMP -->
        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/stompjs@2.3.3/lib/stomp.min.js"></script>

        <!-- Bootstrap CSS + JS -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            // Khai báo biến toàn cục một lần duy nhất
            if (typeof stompClient === 'undefined') {
                var stompClient = null;
            }
            if (typeof currentAdminName === 'undefined') {
                var currentAdminName = "${pageContext.request.userPrincipal != null ? pageContext.request.userPrincipal.name : 'admin'}";
            }
            if (typeof selectedUser === 'undefined') {
                var selectedUser = null;
            }
            if (typeof userHistory === 'undefined') {
                var userHistory = {};
            }

            function connectAdminWebSocket() {
                if (stompClient) return; // tránh kết nối lại

                const socket = new SockJS('/ws');
                stompClient = Stomp.over(socket);
                stompClient.debug = () => { };

                stompClient.connect({}, () => {
                    stompClient.subscribe('/user/queue/messages', payload => {
                        const message = JSON.parse(payload.body);
                        if (typeof handleIncomingMessage === 'function') {
                            handleIncomingMessage(message); // gọi hàm ở admin_chat.jsp
                        } else {
                            console.log("Tin nhắn đến:", message);
                        }
                    });
                }, error => {
                    console.error("Lỗi kết nối:", error);
                });
            }

            $(document).ready(connectAdminWebSocket);
        </script>

        <!-- Navbar -->
        <nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
            <a class="navbar-brand ps-3" href="/admin">Laptop Store</a>
            <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle">
                <i class="fas fa-bars"></i>
            </button>

            <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
                <div class="dropdown my-auto">
                    <a href="#" class="dropdown-toggle" role="button" id="dropdownMenuLink" data-bs-toggle="dropdown"
                        aria-expanded="false">
                        <i class="fas fa-user fa-2x"></i>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-lg-end p-4" style="min-width: 250px; max-width: 90vw;"
                        aria-labelledby="dropdownMenuLink">
                        <li class="d-flex align-items-center flex-column">
                            <img style="width: 150px; height: 150px; border-radius: 50%;"
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
                </div>
            </ul>
        </nav>