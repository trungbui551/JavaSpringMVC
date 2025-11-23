<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="../layout/header.jsp" />

    <div id="layoutSidenav">
        <jsp:include page="../layout/sidebar.jsp" />

        <div id="layoutSidenav_content">
            <main class="container-fluid" style="padding-top: 80px; padding-bottom: 50px;">
                <div class="row">
                    <div class="col-md-3">
                        <div class="card shadow-sm">
                            <div class="card-header bg-light fw-bold">Tin nhắn đến</div>
                            <ul class="list-group list-group-flush" id="user-list"
                                style="height: 400px; overflow-y: auto;">
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-9">
                        <div class="card shadow-sm">
                            <div class="card-header bg-primary text-white">
                                Chat với: <span id="current-chat-user" class="fw-bold">...</span>
                            </div>

                            <div class="card-body" id="admin-message-area"
                                style="height: 400px; overflow-y: auto; background: #f1f2f6;">
                                <div class="text-center text-muted mt-5">
                                    <small>Chưa chọn người dùng nào</small>
                                </div>
                            </div>

                            <div class="card-footer">
                                <div class="input-group">
                                    <input type="text" id="admin-input" class="form-control"
                                        placeholder="Chọn user để chat..." disabled>
                                    <button class="btn btn-primary" id="admin-btn-send" disabled>Gửi</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <script>
        // 3. LOGIC CHAT
        console.log("🚀 Script Chat đã khởi động...");

        // Lấy tên Admin an toàn (tránh lỗi syntax nếu rỗng)
        var currentAdminName = "${pageContext.request.userPrincipal.name}";
        if (!currentAdminName) {
            console.warn("⚠️ Không tìm thấy tên Admin từ Session, đang dùng tên giả định 'admin'");
            currentAdminName = "admin";
        }

        var stompClient = null;
        var selectedUser = null;
        var userHistory = {};

        $(document).ready(function () {
            console.log("🌐 DOM Ready - Bắt đầu kết nối...");
            connectAdmin();

            $('#admin-btn-send').click(sendReply);
            $('#admin-input').keypress(function (e) { if (e.which == 13) sendReply(); });
        });

        function connectAdmin() {
            // Kết nối tới endpoint /ws mà bạn đã config trong Spring Boot
            var socket = new SockJS('/ws');
            stompClient = Stomp.over(socket);

            // Tắt debug nếu muốn console gọn: stompClient.debug = null; 

            stompClient.connect({}, function (frame) {
                console.log("✅ Đã kết nối Socket thành công! User: " + currentAdminName);

                // Đăng ký nhận tin nhắn
                stompClient.subscribe('/user/queue/messages', function (payload) {
                    console.log("📩 Có tin nhắn mới!");
                    var message = JSON.parse(payload.body);
                    handleIncomingMessage(message);
                });

            }, function (error) {
                console.error("❌ Lỗi kết nối Socket:", error);
                alert("Không thể kết nối tới Chat Server. Hãy tải lại trang.");
            });
        }

        function handleIncomingMessage(message) {
            // Xác định đối phương là ai
            var otherParty = (message.senderId === currentAdminName) ? message.recipientId : message.senderId;

            // Lưu vào lịch sử tạm
            if (!userHistory[otherParty]) {
                userHistory[otherParty] = [];

                // Nếu chưa có trong danh sách thì thêm vào cột trái
                if ($(`#user-item-${otherParty}`).length === 0) {
                    var itemHtml = `<li class="list-group-item list-group-item-action" 
                                    id="user-item-${otherParty}" 
                                    style="cursor:pointer" 
                                    onclick="selectUser('${otherParty}')">
                                    <i class="bi bi-person-circle"></i> ${otherParty}
                                </li>`;
                    $('#user-list').append(itemHtml);
                }
            }
            userHistory[otherParty].push(message);

            // Nếu đang chat với người này -> Render luôn
            if (selectedUser === otherParty) {
                renderMessage(message);
            } else {
                // Nếu không -> Highlight để báo tin mới
                $(`#user-item-${otherParty}`).addClass('bg-warning text-dark fw-bold');
            }
        }

        function selectUser(username) {
            selectedUser = username;
            $('#current-chat-user').text(username);

            // Mở khóa nhập liệu
            $('#admin-input').prop('disabled', false);
            $('#admin-btn-send').prop('disabled', false);
            $('#admin-input').focus();

            // Xóa highlight
            $(`#user-item-${username}`).removeClass('bg-warning text-dark fw-bold');

            // Load lại tin nhắn cũ
            $('#admin-message-area').empty();
            if (userHistory[username]) {
                userHistory[username].forEach(renderMessage);
            }
        }

        function renderMessage(message) {
            var isAdmin = (message.senderId === currentAdminName);
            var align = isAdmin ? 'text-end' : 'text-start';
            var bg = isAdmin ? 'bg-primary text-white' : 'bg-white border text-dark';

            var html = `
            <div class="mb-2 ${align}">
                <div class="d-inline-block p-2 rounded shadow-sm ${bg}" style="max-width: 75%;">
                    ${message.content}
                </div>
            </div>`;

            var area = $('#admin-message-area');
            area.append(html);
            area.scrollTop(area[0].scrollHeight);
        }

        function sendReply() {
            var content = $('#admin-input').val().trim();
            if (content && selectedUser) {
                var chatMessage = {
                    senderId: currentAdminName,
                    recipientId: selectedUser,
                    content: content
                };

                // Gửi lên server
                stompClient.send("/app/chat", {}, JSON.stringify(chatMessage));

                // Tự hiển thị tin nhắn của mình (để cảm giác nhanh hơn)
                handleIncomingMessage(chatMessage);
                $('#admin-input').val('');
            }
        }
    </script>