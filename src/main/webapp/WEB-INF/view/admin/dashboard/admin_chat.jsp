<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="../layout/header.jsp" />
    <link href="/client/lib/lightbox/css/lightbox.min.css" rel="stylesheet">
    <link href="/client/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">


    <!-- Customized Bootstrap Stylesheet -->
    <link href="/client/css/bootstrap.min.css" rel="stylesheet">
    <div class="container-fluid" style="padding-top: 80px; padding-bottom: 50px;">
        <div class="row">
            <!-- Danh sách người dùng -->
            <div class="col-md-3">
                <div class="card shadow-sm">
                    <div class="card-header bg-light fw-bold">Tin nhắn đến</div>
                    <ul class="list-group list-group-flush" id="user-list" style="height: 400px; overflow-y: auto;">
                    </ul>
                </div>
            </div>

            <!-- Khu vực chat -->
            <div class="col-md-9">
                <div class="card shadow-sm">
                    <div class="card-header bg-primary text-white">
                        Chat với: <span id="current-chat-user" class="fw-bold">...</span>
                    </div>
                    <div class="card-body" id="admin-message-area" name="admin-message-area"
                        style="height: 400px; overflow-y: auto; background: #f1f2f6;">
                        <div class="text-center text-muted mt-5"><small>Chưa chọn người dùng nào</small></div>
                    </div>
                    <div class="card-footer">
                        <div class="input-group">
                            <input type="text" id="admin-input" class="form-control" placeholder="Nhập tin nhắn..."
                                disabled>
                            <button class="btn btn-primary" id="admin-btn-send" disabled>Gửi</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.5.1/sockjs.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

    <script>
        // Lấy thông tin người dùng đăng nhập hiện tại (Principal Name)
        var currentAdminName = "${pageContext.request.userPrincipal.name}";
        var stompClient = null;
        var userHistory = {};
        var selectedUser = null;

        function encodeId(str) {
            return str.replace(/[^a-zA-Z0-9]/g, '_');
        }



        $(document).ready(function () {

            $('#admin-btn-send').click(sendReply);
            $('#admin-input').keypress(e => { if (e.which === 13) sendReply(); });
        });

        function handleIncomingMessage(message) {
            // Xác định đối phương là ai (nếu tin nhắn do mình gửi thì đối phương là recipient, ngược lại là sender)
            const otherParty = (message.senderId === currentAdminName) ? message.recipientId : message.senderId;
            const encodedId = encodeId(otherParty);
            console.log("currentAdminName: " + currentAdminName);
            console.log("senderId: : " + message.senderId);
            console.log("otherParty: " + otherParty)
            if (!userHistory[otherParty]) {
                userHistory[otherParty] = [];
                const itemHtml = `
            <li class="list-group-item list-group-item-action" 
                id="user-item-${encodedId}" style="cursor:pointer"
                onclick="selectUser('${otherParty}')">
                <i class="bi bi-person-circle"></i> ${otherParty}
            </li>`;
                $('#user-list').append(itemHtml);
            }

            userHistory[otherParty].push(message);
            // showMessage(message);
            // Nếu đang chat với người này thì hiện tin nhắn ngay
            if (selectedUser === otherParty) {
                console.log("-----------------------")
                showMessage(message);
            } else {
                // Nếu không, highlight tên người đó để báo có tin mới
                $('#user-item-' + encodedId).addClass('bg-warning fw-bold');
            }

            // Nếu chưa chọn ai, tự động chọn người vừa nhắn (tuỳ chọn)
            if (!selectedUser) {
                selectUser(otherParty);
            }
        }

        function selectUser(username) {
            selectedUser = username;
            $('#current-chat-user').text(username);
            $('#admin-input, #admin-btn-send').prop('disabled', false);
            $('#admin-input').focus();

            const encodedId = encodeId(username);
            $('#user-item-' + encodedId).removeClass('bg-warning fw-bold');

            $('#admin-message-area').html('');
            if (userHistory[username]) {
                userHistory[username].forEach(showMessage);
            }
        }

        function showMessage(message) {
            console.log('KIỂM TRA HÀM SHOWMESSAGE!');
            const messageArea = $('#admin-message-area');
            const isAdmin = (message.senderId === currentAdminName);
            const align = isAdmin ? 'text-end' : 'text-start';
            const bg = isAdmin ? 'bg-primary text-white' : 'bg-light text-dark border';
            const sender = isAdmin ? 'Admin' : String(message.senderId);
            const time = message.timestamp ? new Date(message.timestamp).toLocaleTimeString() : '';
            console.log("check hàm show: " + message.recipientId + " sender: " + sender);
            console.log("align: " + align);
            console.log("Full message object:", message);
            console.log("message.senderId type:", typeof message.senderId, message.senderId);
            console.log("message.content type:", typeof message.content, message.content);
            const html = `
        <div class="mb-2 \${align}">
            <div class="d-inline-block p-2 rounded \${bg}" style="max-width: 75%;">
                \${message.content}
            </div>
            <div class="small text-muted" style="font-size: 10px;">
                \${sender} •  \${time}
            </div>
        </div>
        `;
            console.log(">>> HTML chuẩn bị append:", html);
            messageArea.append(html);
            messageArea.scrollTop(messageArea[0].scrollHeight);
        }

        function sendReply() {
            const content = $('#admin-input').val().trim();
            if (!content || !selectedUser || !stompClient) {
                return;
            }

            const chatMessage = {
                senderId: currentAdminName,
                recipientId: selectedUser,
                content: content,
                timestamp: new Date().toISOString()
            };

            stompClient.send("/app/chat/admin/send", {}, JSON.stringify(chatMessage));

            // Hiển thị ngay tin nhắn mình vừa gửi lên giao diện
            handleIncomingMessage(chatMessage);
            $('#admin-input').val('');
        }
    </script>