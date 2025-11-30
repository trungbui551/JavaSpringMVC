<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <jsp:include page="../layout/header.jsp" />

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
                    <div class="card-body" id="admin-message-area"
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

    <script>
        function encodeId(str) {
            return str.replace(/[^a-zA-Z0-9]/g, '_');
        }

        $(document).ready(function () {
            $('#admin-btn-send').click(sendReply);
            $('#admin-input').keypress(e => { if (e.which === 13) sendReply(); });
        });

        function handleIncomingMessage(message) {
            const otherParty = (message.senderId === currentAdminName) ? message.recipientId : message.senderId;
            const encodedId = encodeId(otherParty);

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

            if (!selectedUser) {
                selectUser(otherParty);
            }

            if (selectedUser === otherParty) {
                showMessage(message);
            } else {
                $('#user-item-' + encodedId).addClass('bg-warning fw-bold');
            }
        }

        function selectUser(username) {
            selectedUser = username;
            $('#current-chat-user').text(username);
            $('#admin-input, #admin-btn-send').prop('disabled', false);
            $('#admin-input').focus();
            $('#user-item-' + encodeId(username)).removeClass('bg-warning fw-bold');
            $('#admin-message-area').html('');

            if (userHistory[username]) {
                userHistory[username].forEach(showMessage);
            }
        }

        function showMessage(message) {
            const messageArea = $('#admin-message-area');
            const isAdmin = (message.senderId === currentAdminName);
            const align = isAdmin ? 'text-end' : 'text-start';
            const bg = isAdmin ? 'bg-primary text-white' : 'bg-light text-dark border';
            const sender = isAdmin ? 'Admin' : message.senderId;
            const time = message.timestamp ? new Date(message.timestamp).toLocaleTimeString() : '';

            const html = `
            <div class="mb-2 ${align}">
                <div class="d-inline-block p-2 rounded ${bg}" style="max-width: 75%;">
                    ${message.content}
                </div>
                <div class="small text-muted" style="font-size: 10px;">
                    ${sender} • ${time}
                </div>
            </div>
        `;

            messageArea.append(html);
            messageArea.scrollTop(messageArea[0].scrollHeight);
        }

        function sendReply() {
            const content = $('#admin-input').val().trim();
            if (!content || !selectedUser || !stompClient || !stompClient.connected) {
                console.warn("WebSocket chưa sẵn sàng để gửi tin nhắn.");
                return;
            }

            const chatMessage = {
                senderId: currentAdminName,
                recipientId: selectedUser,
                content: content,
                timestamp: new Date().toISOString()
            };

            stompClient.send("/app/chat/admin/send", {}, JSON.stringify(chatMessage));
            handleIncomingMessage(chatMessage);
            $('#admin-input').val('');
        }
    </script>