(function ($) {
    "use strict";

    // Spinner
    var spinner = function () {
        setTimeout(function () {
            if ($('#spinner').length > 0) {
                $('#spinner').removeClass('show');
            }
        }, 1);
    };
    spinner(0);


    // Fixed Navbar
    $(window).scroll(function () {
        if ($(window).width() < 992) {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow');
            } else {
                $('.fixed-top').removeClass('shadow');
            }
        } else {
            if ($(this).scrollTop() > 55) {
                $('.fixed-top').addClass('shadow').css('top', -55);
            } else {
                $('.fixed-top').removeClass('shadow').css('top', 0);
            }
        }
    });


    // Back to top button
    $(window).scroll(function () {
        if ($(this).scrollTop() > 300) {
            $('.back-to-top').fadeIn('slow');
        } else {
            $('.back-to-top').fadeOut('slow');
        }
    });
    $('.back-to-top').click(function () {
        $('html, body').animate({ scrollTop: 0 }, 1500, 'easeInOutExpo');
        return false;
    });


    // Testimonial carousel
    $(".testimonial-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 2000,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 1
            },
            992: {
                items: 2
            },
            1200: {
                items: 2
            }
        }
    });


    // vegetable carousel
    $(".vegetable-carousel").owlCarousel({
        autoplay: true,
        smartSpeed: 1500,
        center: false,
        dots: true,
        loop: true,
        margin: 25,
        nav: true,
        navText: [
            '<i class="bi bi-arrow-left"></i>',
            '<i class="bi bi-arrow-right"></i>'
        ],
        responsiveClass: true,
        responsive: {
            0: {
                items: 1
            },
            576: {
                items: 1
            },
            768: {
                items: 2
            },
            992: {
                items: 3
            },
            1200: {
                items: 4
            }
        }
    });


    // Modal Video
    $(document).ready(function () {
        var $videoSrc;
        $('.btn-play').click(function () {
            $videoSrc = $(this).data("src");
        });
        console.log($videoSrc);

        $('#videoModal').on('shown.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc + "?autoplay=1&amp;modestbranding=1&amp;showinfo=0");
        })

        $('#videoModal').on('hide.bs.modal', function (e) {
            $("#video").attr('src', $videoSrc);
        })
    });



    // Product Quantity
    // $('.quantity button').on('click', function () {
    //     var button = $(this);
    //     var oldValue = button.parent().parent().find('input').val();
    //     if (button.hasClass('btn-plus')) {
    //         var newVal = parseFloat(oldValue) + 1;
    //     } else {
    //         if (oldValue > 0) {
    //             var newVal = parseFloat(oldValue) - 1;
    //         } else {
    //             newVal = 0;
    //         }
    //     }
    //     button.parent().parent().find('input').val(newVal);
    // });
    $('.quantity button').on('click', function () {
        let change = 0;

        var button = $(this);
        var oldValue = button.parent().parent().find('input').val();

        if (button.hasClass('btn-plus')) {
            var newVal = parseFloat(oldValue) + 1;
            change = 1;
        } else {
            if (oldValue > 1) {
                var newVal = parseFloat(oldValue) - 1;
                change = -1;
            } else {
                newVal = 1;
            }
        }

        const input = button.parent().parent().find('input');
        input.val(newVal);
        //set form index
        const index = input.attr("data-cart-detail-index")
        const el = document.getElementById(`cartDetails${index}.quantity`);
        $(el).val(newVal);
        //get price
        const price = input.attr("data-cart-detail-price");
        const id = input.attr("data-cart-detail-id");

        const priceElement = $(`p[data-cart-detail-id='${id}']`);
        if (priceElement) {
            const newPrice = +price * newVal;
            priceElement.text(formatCurrency(newPrice.toFixed(2)) + " đ");
        }
        let grandTotal = 0;
        $('.quantity input').each(function () {
            const qty = parseInt($(this).val()) || 0;
            const itemPrice = parseFloat($(this).attr("data-cart-detail-price")) || 0;
            grandTotal += qty * itemPrice;
        });

        // Update subtotal
        const subtotalElement = $('#subtotal');
        if (subtotalElement.length) {
            subtotalElement.text(formatCurrency(grandTotal.toFixed(0)) + " đ");
            subtotalElement.attr('data-cart-total-price', grandTotal);
        }
        calculateTotal()
        change = 0;
    });
    // Format currency for Vietnamese đồng
    function formatCurrency(value) {
        // Use the 'vi-VN' locale for Vietnamese currency formatting
        const formatter = new Intl.NumberFormat('vi-VN', {
            style: 'decimal',
            minimumFractionDigits: 0, // no decimals for whole numbers
        });

        let formatted = formatter.format(value);
        // Replace dots with commas for thousands separator
        formatted = formatted.replace(/\./g, ',');
        return formatted;
    }

    var stompClient = null;
    // Lấy username từ server (Ví dụ Thymeleaf dùng [[${#authentication.name}]])
    // Hoặc nếu dùng JSP: var currentUsername = "${pageContext.request.userPrincipal.name}";
    // Ở đây mình giả sử bạn lấy được username rồi.
    var currentUsername = "user_dang_login";

    $(document).ready(function () {
        // 1. Xử lý UI: Bật tắt khung chat
        $('#chat-button').click(function () {
            $('#chat-box').show();
            connect(); // Mở chat là kết nối luôn
        });
        $('#close-chat').click(function () {
            $('#chat-box').hide();
        });

        // 2. Gửi tin khi ấn Enter hoặc nút Gửi
        $('#btn-send').click(sendMessage);
        $('#msg-input').keypress(function (e) {
            if (e.which == 13) sendMessage();
        });
    });

    function connect() {
        if (stompClient !== null) return; // Đã kết nối thì thôi

        var socket = new SockJS('/ws'); // Đường dẫn phải khớp config BE
        stompClient = Stomp.over(socket);

        stompClient.connect({}, function (frame) {
            console.log('Connected: ' + frame);

            // Đăng ký nhận tin nhắn trả về
            stompClient.subscribe('/user/queue/messages', function (messageOutput) {
                showMessage(JSON.parse(messageOutput.body));
            });
        });
    }

    function sendMessage() {
        var content = $('#msg-input').val().trim();
        if (content && stompClient) {
            var chatMessage = {
                senderId: currentUsername,
                recipientId: "admin", // Mặc định gửi cho admin
                content: content,
                timestamp: new Date()
            };

            // Gửi lên server
            stompClient.send("/app/chat", {}, JSON.stringify(chatMessage));

            // Hiển thị ngay tin nhắn của mình lên màn hình (cho mượt)
            showMessage(chatMessage);
            $('#msg-input').val(''); // Xóa ô nhập
        }
    }

    function showMessage(message) {
        var messageArea = $('#message-area');

        // Kiểm tra xem tin nhắn là của mình (Me) hay của Admin (Other)
        // Lưu ý: So sánh senderId với currentUsername
        var isMe = (message.senderId === currentUsername);

        var align = isMe ? 'text-end' : 'text-start';
        var bg = isMe ? 'bg-primary text-white' : 'bg-light text-dark border';

        var html = `
            <div class="mb-2 ${align}">
                <div class="d-inline-block p-2 rounded ${bg}" style="max-width: 75%;">
                    ${message.content}
                </div>
                <div class="small text-muted" style="font-size: 10px;">
                    ${new Date(message.timestamp).toLocaleTimeString()}
                </div>
            </div>
        `;

        messageArea.append(html);

        // Tự động cuộn xuống dưới cùng
        messageArea.scrollTop(messageArea[0].scrollHeight);
    }

})(jQuery);


