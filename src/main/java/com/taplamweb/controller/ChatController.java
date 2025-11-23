
package com.taplamweb.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping; // Thêm import này

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.domain.User;
import com.taplamweb.service.ChatService;
import com.taplamweb.service.UserService;

@Controller
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @Autowired
    private ChatService chatService;
    @Autowired
    private UserService userService;

    // --- PHẦN 1: MỞ TRANG CHAT (QUAN TRỌNG) ---
    // Hàm này giúp đảm bảo khi bạn vào /admin/chat, nó load ĐÚNG file JSP bạn vừa
    // sửa
    @GetMapping("/admin/chat")
    public String getChatPage() {
        // Dựa vào file list của bạn, file jsp nằm ở:
        // /WEB-INF/view/admin/dashboard/admin_chat.jsp
        // Nếu file JSP của bạn tên là admin-chat.jsp (dấu gạch ngang) thì sửa lại bên
        // dưới
        return "admin/dashboard/admin_chat";
    }

    // --- PHẦN 2: XỬ LÝ NHẮN TIN SOCKET ---
    @MessageMapping("/chat")
    public void processMessage(@Payload ChatMessage chatMessage, Principal principal) {

        try {
            // 1. Xác thực người gửi
            if (principal == null) {
                System.out.println("LỖI: Principal is NULL (Chưa đăng nhập hoặc mất session)");
                return;
            }
            User user = this.userService.getUserByEmail(principal.getName());
            if (user.getRole().equals("ADMIN")) {
                chatMessage.setSenderId("ADMIN");
            } else {
                String senderName = principal.getName();
                chatMessage.setSenderId(senderName);
            }

            System.out.println("- Người gửi: " + chatMessage.getSenderId());
            System.out.println("- Người nhận: " + chatMessage.getRecipientId());
            System.out.println("- Nội dung: " + chatMessage.getContent());

            // 2. Lưu vào Database
            ChatMessage savedMsg = chatService.save(chatMessage);
            System.out.println("- Đã lưu vào DB thành công. ID: " + savedMsg.getId());

            // 3. Gửi tin nhắn tới Người nhận
            // Đường dẫn này khớp với Client subscribe: /user/queue/messages
            String recipient = chatMessage.getRecipientId();

            // Mẹo sửa nhanh: Nếu tin nhắn gửi cho "ADMIN", hãy lái nó sang email thật của
            // bạn
            if ("ADMIN".equals(recipient)) {
                recipient = "admin@gmail.com"; // <--- Thay bằng email admin thật của bạn (ví dụ: trungbui... gì đó)
            }

            messagingTemplate.convertAndSendToUser(
                    recipient,
                    "/queue/messages",
                    savedMsg);

            System.out.println("- Đã chuyển tiếp tin nhắn tới: " + chatMessage.getRecipientId());

        } catch (Exception e) {
            System.out.println("LỖI XỬ LÝ TIN NHẮN: " + e.getMessage());
            e.printStackTrace();
        }
        System.out.println("--------------------------------------------------");
    }
}