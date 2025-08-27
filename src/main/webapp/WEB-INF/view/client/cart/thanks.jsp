<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

        <!DOCTYPE html>
        <html lang="vi">

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <title>Cảm ơn bạn đã đặt hàng!</title>
            <style>
                * {
                    margin: 0;
                    padding: 0;
                    box-sizing: border-box;
                }

                body {
                    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                    line-height: 1.6;
                    background: linear-gradient(135deg, #f0f9f0 0%, #e8f5e8 100%);
                    min-height: 100vh;
                }

                /* Header Section - Để trống cho code riêng */
                .header {
                    background: #fff;
                    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                    /* Để trống để inner code */
                }

                /* Main Thank You Content */
                .thank-you-container {
                    max-width: 800px;
                    margin: 60px auto;
                    padding: 0 20px;
                }

                .thank-you-card {
                    background: #fff;
                    border-radius: 20px;
                    box-shadow: 0 20px 60px rgba(34, 139, 34, 0.15);
                    overflow: hidden;
                    position: relative;
                }

                .card-header {
                    background: linear-gradient(135deg, #228B22 0%, #32CD32 100%);
                    color: white;
                    padding: 40px 30px;
                    text-align: center;
                    position: relative;
                    overflow: hidden;
                }

                .card-header::before {
                    content: '';
                    position: absolute;
                    top: -50%;
                    left: -50%;
                    width: 200%;
                    height: 200%;
                    background: radial-gradient(circle, rgba(255, 255, 255, 0.1) 0%, transparent 70%);
                    animation: shimmer 3s ease-in-out infinite;
                }

                @keyframes shimmer {

                    0%,
                    100% {
                        transform: translateX(-100px) translateY(-100px) rotate(0deg);
                    }

                    50% {
                        transform: translateX(100px) translateY(100px) rotate(180deg);
                    }
                }

                .success-icon {
                    width: 80px;
                    height: 80px;
                    background: rgba(255, 255, 255, 0.2);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 20px;
                    animation: bounce 1s ease-out;
                }

                @keyframes bounce {
                    0% {
                        transform: scale(0.3);
                        opacity: 0;
                    }

                    50% {
                        transform: scale(1.1);
                    }

                    100% {
                        transform: scale(1);
                        opacity: 1;
                    }
                }

                .checkmark {
                    width: 40px;
                    height: 40px;
                    position: relative;
                }

                .checkmark::after {
                    content: '';
                    position: absolute;
                    left: 50%;
                    top: 50%;
                    width: 16px;
                    height: 8px;
                    border: solid white;
                    border-width: 0 0 4px 4px;
                    transform: translate(-50%, -60%) rotate(-45deg);
                    animation: checkmark-draw 0.5s ease-in-out 0.5s both;
                }

                @keyframes checkmark-draw {
                    0% {
                        width: 0;
                        height: 0;
                    }

                    100% {
                        width: 16px;
                        height: 8px;
                    }
                }

                .thank-you-title {
                    font-size: 2.5em;
                    font-weight: 700;
                    margin-bottom: 10px;
                    position: relative;
                }

                .thank-you-subtitle {
                    font-size: 1.2em;
                    opacity: 0.9;
                    font-weight: 300;
                }

                .card-body {
                    padding: 40px 30px;
                }

                .order-info {
                    background: linear-gradient(135deg, #f8fdf8 0%, #f0f9f0 100%);
                    border-radius: 15px;
                    padding: 30px;
                    margin-bottom: 30px;
                    border: 2px solid #e8f5e8;
                }

                .order-number {
                    text-align: center;
                    margin-bottom: 25px;
                }

                .order-number h3 {
                    color: #228B22;
                    font-size: 1.3em;
                    margin-bottom: 5px;
                }

                .order-id {
                    font-size: 1.8em;
                    font-weight: 700;
                    color: #2d5a2d;
                    font-family: 'Courier New', monospace;
                    background: #fff;
                    padding: 10px 20px;
                    border-radius: 8px;
                    display: inline-block;
                    border: 2px dashed #228B22;
                }

                .info-grid {
                    display: grid;
                    grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
                    gap: 20px;
                    margin-top: 25px;
                }

                .info-item {
                    text-align: center;
                    padding: 20px;
                    background: #fff;
                    border-radius: 12px;
                    box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
                    transition: transform 0.3s ease;
                }

                .info-item:hover {
                    transform: translateY(-2px);
                }

                .info-icon {
                    width: 50px;
                    height: 50px;
                    background: linear-gradient(135deg, #228B22, #32CD32);
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin: 0 auto 15px;
                    color: white;
                    font-size: 20px;
                }

                .info-title {
                    font-weight: 600;
                    color: #2d5a2d;
                    margin-bottom: 5px;
                }

                .info-value {
                    color: #666;
                    font-size: 0.9em;
                }

                .next-steps {
                    background: #fff;
                    border-radius: 15px;
                    padding: 30px;
                    box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
                }

                .next-steps h3 {
                    color: #228B22;
                    margin-bottom: 20px;
                    font-size: 1.4em;
                    display: flex;
                    align-items: center;
                }

                .next-steps h3::before {
                    content: '📋';
                    margin-right: 10px;
                    font-size: 1.2em;
                }

                .steps-list {
                    list-style: none;
                }

                .steps-list li {
                    padding: 15px 0;
                    border-bottom: 1px solid #f0f0f0;
                    display: flex;
                    align-items: flex-start;
                }

                .steps-list li:last-child {
                    border-bottom: none;
                }

                .step-number {
                    background: linear-gradient(135deg, #228B22, #32CD32);
                    color: white;
                    width: 30px;
                    height: 30px;
                    border-radius: 50%;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    margin-right: 15px;
                    flex-shrink: 0;
                    font-weight: 600;
                    font-size: 0.9em;
                }

                .step-content {
                    flex: 1;
                }

                .step-title {
                    font-weight: 600;
                    color: #2d5a2d;
                    margin-bottom: 5px;
                }

                .step-description {
                    color: #666;
                    font-size: 0.9em;
                }

                .action-buttons {
                    display: flex;
                    gap: 15px;
                    justify-content: center;
                    margin-top: 30px;
                    flex-wrap: wrap;
                }

                .btn {
                    padding: 15px 30px;
                    border-radius: 50px;
                    text-decoration: none;
                    font-weight: 600;
                    text-align: center;
                    transition: all 0.3s ease;
                    border: none;
                    cursor: pointer;
                    font-size: 1em;
                }

                .btn-primary {
                    background: linear-gradient(135deg, #228B22, #32CD32);
                    color: white;
                    box-shadow: 0 5px 15px rgba(34, 139, 34, 0.3);
                }

                .btn-primary:hover {
                    transform: translateY(-2px);
                    box-shadow: 0 8px 25px rgba(34, 139, 34, 0.4);
                }

                .btn-secondary {
                    background: #fff;
                    color: #228B22;
                    border: 2px solid #228B22;
                }

                .btn-secondary:hover {
                    background: #228B22;
                    color: #fff;
                    transform: translateY(-2px);
                }

                .contact-info {
                    text-align: center;
                    margin-top: 30px;
                    padding: 20px;
                    background: linear-gradient(135deg, #f8fdf8 0%, #f0f9f0 100%);
                    border-radius: 12px;
                }

                .contact-info h4 {
                    color: #228B22;
                    margin-bottom: 10px;
                }

                .contact-info p {
                    color: #666;
                    margin: 5px 0;
                }

                /* Footer Section - Để trống cho code riêng */
                .footer {
                    background: #2d5a2d;
                    color: white;
                    margin-top: 60px;
                    /* Để trống để inner code */
                }

                /* Responsive Design */
                @media (max-width: 768px) {
                    .thank-you-container {
                        margin: 30px auto;
                        padding: 0 15px;
                    }

                    .card-header {
                        padding: 30px 20px;
                    }

                    .thank-you-title {
                        font-size: 2em;
                    }

                    .card-body {
                        padding: 30px 20px;
                    }

                    .order-info,
                    .next-steps {
                        padding: 20px;
                    }

                    .info-grid {
                        grid-template-columns: 1fr;
                        gap: 15px;
                    }

                    .action-buttons {
                        flex-direction: column;
                        align-items: center;
                    }

                    .btn {
                        width: 100%;
                        max-width: 250px;
                    }
                }

                /* Loading animation for dynamic content */
                .loading {
                    display: inline-block;
                    width: 20px;
                    height: 20px;
                    border: 3px solid #f3f3f3;
                    border-top: 3px solid #228B22;
                    border-radius: 50%;
                    animation: spin 1s linear infinite;
                }

                @keyframes spin {
                    0% {
                        transform: rotate(0deg);
                    }

                    100% {
                        transform: rotate(360deg);
                    }
                }
            </style>
        </head>

        <body>


            <jsp:include page="../layout/header.jsp" />


            <!-- JavaScript Libraries -->
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
            <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
            <script src="/client/lib/easing/easing.min.js"></script>
            <script src="/client/lib/waypoints/waypoints.min.js"></script>
            <script src="/client/lib/lightbox/js/lightbox.min.js"></script>
            <script src="/client/lib/owlcarousel/owl.carousel.min.js"></script>

            <!-- Customized Bootstrap Stylesheet -->
            <link href="/client/css/bootstrap.min.css" rel="stylesheet">

            <!-- Template Stylesheet -->
            <link href="/client/css/style.css" rel="stylesheet">
            <!-- Template Javascript -->
            <script src="/client/js/main.js"></script>

            <!-- Main Thank You Content -->
            <main class="thank-you-container">
                <div class="thank-you-card">
                    <div class="card-header">
                        <div class="success-icon">
                            <div class="checkmark"></div>
                        </div>
                        <h1 class="thank-you-title">Cảm ơn bạn!</h1>
                        <p class="thank-you-subtitle">Đơn hàng của bạn đã được đặt thành công</p>
                    </div>

                    <div class="card-body">
                        <div class="order-info">
                            <div class="order-number">
                                <h3>Mã đơn hàng của bạn</h3>
                                <div class="order-id" id="orderId">DH2024001234</div>
                            </div>

                            <div class="info-grid">
                                <div class="info-item">
                                    <div class="info-icon">📧</div>
                                    <div class="info-title">Email xác nhận</div>
                                    <div class="info-value">Đã gửi đến email của bạn</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-icon">📱</div>
                                    <div class="info-title">SMS thông báo</div>
                                    <div class="info-value">Cập nhật trạng thái đơn hàng</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-icon">🚚</div>
                                    <div class="info-title">Thời gian giao hàng</div>
                                    <div class="info-value">2-3 ngày làm việc</div>
                                </div>
                                <div class="info-item">
                                    <div class="info-icon">💳</div>
                                    <div class="info-title">Thanh toán</div>
                                    <div class="info-value">Đã xác nhận thành công</div>
                                </div>
                            </div>
                        </div>

                        <div class="next-steps">
                            <h3>Các bước tiếp theo</h3>
                            <ul class="steps-list">
                                <li>
                                    <div class="step-number">1</div>
                                    <div class="step-content">
                                        <div class="step-title">Xác nhận đơn hàng</div>
                                        <div class="step-description">Chúng tôi sẽ xử lý và xác nhận đơn hàng của bạn
                                            trong vòng
                                            30 phút</div>
                                    </div>
                                </li>
                                <li>
                                    <div class="step-number">2</div>
                                    <div class="step-content">
                                        <div class="step-title">Chuẩn bị hàng hóa</div>
                                        <div class="step-description">Sản phẩm sẽ được đóng gói cẩn thận và chuẩn bị để
                                            giao
                                            hàng</div>
                                    </div>
                                </li>
                                <li>
                                    <div class="step-number">3</div>
                                    <div class="step-content">
                                        <div class="step-title">Giao hàng</div>
                                        <div class="step-description">Đơn vị vận chuyển sẽ liên hệ và giao hàng tận nơi
                                            cho bạn
                                        </div>
                                    </div>
                                </li>
                                <li>
                                    <div class="step-number">4</div>
                                    <div class="step-content">
                                        <div class="step-title">Nhận hàng & Đánh giá</div>
                                        <div class="step-description">Kiểm tra sản phẩm và để lại đánh giá để giúp chúng
                                            tôi cải
                                            thiện dịch vụ</div>
                                    </div>
                                </li>
                            </ul>
                        </div>

                        <div class="action-buttons">
                            <a href="/orders/tracking" class="btn btn-primary">Theo dõi đơn hàng</a>
                            <a href="/" class="btn btn-secondary">Tiếp tục mua sắm</a>
                        </div>

                        <div class="contact-info">
                            <h4>Cần hỗ trợ?</h4>
                            <p>📞 Hotline: 1900-xxxx</p>
                            <p>📧 Email: support@yourstore.com</p>
                            <p>💬 Chat trực tuyến: 8:00 - 22:00 hàng ngày</p>
                        </div>
                    </div>
                </div>
            </main>


            <jsp:include page="../layout/footer.jsp" />



            <script>
                // Script để có thể tùy chỉnh động
                document.addEventListener('DOMContentLoaded', function () {
                    // Có thể lấy mã đơn hàng từ URL parameters hoặc server
                    const urlParams = new URLSearchParams(window.location.search);
                    const orderId = urlParams.get('orderId');

                    if (orderId) {
                        document.getElementById('orderId').textContent = orderId;
                    }

                    // Animation cho các elements khi load
                    const animateElements = document.querySelectorAll('.info-item');
                    animateElements.forEach((element, index) => {
                        setTimeout(() => {
                            element.style.opacity = '0';
                            element.style.transform = 'translateY(20px)';
                            element.style.transition = 'all 0.6s ease';

                            requestAnimationFrame(() => {
                                element.style.opacity = '1';
                                element.style.transform = 'translateY(0)';
                            });
                        }, index * 100);
                    });
                });

                // Function để có thể gọi từ Spring Boot controller
                function updateOrderInfo(orderData) {
                    if (orderData.orderId) {
                        document.getElementById('orderId').textContent = orderData.orderId;
                    }
                    // Có thể cập nhật thêm thông tin khác nếu cần
                }
            </script>
        </body>

        </html>