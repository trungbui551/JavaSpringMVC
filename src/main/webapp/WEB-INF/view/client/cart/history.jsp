<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <html>

            <head>
                <title>Lịch sử mua hàng</title>

                <style>
                    .btn-back-home {
                        display: inline-block;
                        background-color: #8BC815;
                        /* màu chủ đạo */
                        color: white;
                        padding: 12px 24px;
                        border-radius: 8px;
                        text-decoration: none;
                        font-weight: bold;
                        font-size: 16px;
                        box-shadow: 0 4px 6px rgba(0, 0, 0, 0.2);
                        transition: all 0.3s ease;
                    }

                    .btn-back-home:hover {
                        background-color: #7AB512;
                        /* xanh đậm hơn chút */
                        transform: translateY(-3px) scale(1.05);
                        box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
                    }

                    .btn-back-home:active {
                        transform: translateY(0) scale(0.98);
                        box-shadow: 0 2px 4px rgba(0, 0, 0, 0.2);
                    }

                    .btn-back-container {
                        margin-top: 30px;
                        text-align: center;
                    }

                    /* Reset CSS nhẹ */
                    * {
                        margin: 0;
                        padding: 0;
                        box-sizing: border-box;
                    }

                    body {
                        font-family: "Segoe UI", Tahoma, sans-serif;
                        background-color: #F6FDEB;
                        /* nền sáng xanh nhạt */
                        color: #333;
                        line-height: 1.6;
                    }

                    .container {
                        width: 90%;
                        max-width: 1200px;
                        margin: 40px auto;
                    }

                    h1 {
                        text-align: center;
                        color: #7AB512;
                        margin-bottom: 30px;
                        font-size: 28px;
                        font-weight: 700;
                    }

                    /* Card cho mỗi đơn hàng */
                    .order {
                        background-color: #fff;
                        border-radius: 12px;
                        padding: 20px 25px;
                        margin-bottom: 25px;
                        border: 1px solid #e0e0e0;
                        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.06);
                        transition: transform 0.2s ease, box-shadow 0.2s ease;
                    }

                    .order:hover {
                        transform: translateY(-3px);
                        box-shadow: 0 6px 16px rgba(0, 0, 0, 0.12);
                    }

                    .order-header {
                        font-size: 18px;
                        font-weight: 600;
                        color: #8BC815;
                        margin-bottom: 15px;
                        border-bottom: 2px solid #e8f5e9;
                        padding-bottom: 8px;
                    }

                    /* Trạng thái */
                    .order-status {
                        margin-top: 12px;
                        font-size: 15px;
                        font-weight: 500;
                    }

                    .status-pending {
                        color: #FFA000;
                    }

                    .status-done {
                        color: #8BC815;
                    }

                    .status-cancel {
                        color: #c62828;
                    }

                    /* Sản phẩm */
                    .product {
                        display: flex;
                        justify-content: space-between;
                        align-items: center;
                        padding: 12px 0;
                        border-bottom: 1px solid #f1f1f1;
                    }

                    .product:last-child {
                        border-bottom: none;
                    }

                    .product-info {
                        font-size: 15px;
                        color: #444;
                    }

                    .product-info span {
                        display: block;
                        font-size: 13px;
                        color: #777;
                    }

                    .product-price {
                        font-weight: 600;
                        color: #7AB512;
                        font-size: 15px;
                    }

                    /* Tổng tiền */
                    .order-total {
                        text-align: right;
                        font-weight: bold;
                        color: #8BC815;
                        margin-top: 18px;
                        font-size: 16px;
                        border-top: 2px solid #d8f0c0;
                        padding-top: 10px;
                    }

                    /* Responsive */
                    @media (max-width: 768px) {
                        .product {
                            flex-direction: column;
                            align-items: flex-start;
                        }

                        .product-price {
                            margin-top: 6px;
                        }
                    }
                </style>
            </head>

            <body>
                <div class="container">
                    <h1>Lịch sử mua hàng</h1>

                    <c:forEach var="order" items="${orderList}">
                        <div class="order">
                            <div class="order-header">
                                Đơn hàng #${order.id}
                            </div>

                            <c:forEach var="p" items="${order.orderDetails}">
                                <div class="product">
                                    <div class="product-info">
                                        ${p.product.name}
                                        <span>SL: ${p.quantity}</span>
                                    </div>
                                    <div class="product-price">
                                        <fmt:formatNumber type="number" value="${p.price}" /> đ
                                    </div>
                                </div>
                            </c:forEach>

                            <div class="order-total">
                                Tổng tiền:
                                <fmt:formatNumber type="number" value="${order.totalPrice}" /> đ
                            </div>

                            <div class="order-status">
                                Trạng thái:
                                <span class="<c:choose>
                        <c:when test='${order.status == " Đang xử lý"}'>status-pending</c:when>
                                    <c:when test='${order.status == "Hoàn tất"}'>status-done</c:when>
                                    <c:when test='${order.status == "Đã hủy"}'>status-cancel</c:when>
                                    </c:choose>">
                                    ${order.status}
                                </span>
                            </div>
                        </div>
                    </c:forEach>
                </div>
                <div class="btn-back-container">
                    <a href="/" class="btn-back-home">⬅ Quay lại Trang chủ</a>
                </div>

            </body>

            </html>