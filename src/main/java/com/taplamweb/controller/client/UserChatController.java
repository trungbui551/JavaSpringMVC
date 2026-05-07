package com.taplamweb.controller.client;

import java.security.Principal;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.domain.User;
import com.taplamweb.service.ChatService;
import com.taplamweb.service.UserService;

@Controller
public class UserChatController {

    ChatMessage chatMessage;
    @Autowired
    ChatService chatService;
    @Autowired
    SimpMessagingTemplate messagingTemplate;
    @Autowired
    UserService userService;

    @MessageMapping("/chat/user/send")
    public void sendFromUser(ChatMessage msg, Principal principal) {
        msg.setSenderId(principal.getName());
        chatService.save(msg);

        // Tìm tất cả admin users trong database và gửi tin nhắn tới họ
        List<User> allUsers = userService.getAllUsers();
        List<User> adminUsers = allUsers.stream()
            .filter(u -> u.getRole() != null && "ADMIN".equalsIgnoreCase(u.getRole().getName()))
            .collect(Collectors.toList());
        
        if (!adminUsers.isEmpty()) {
            // Gửi tin nhắn tới TẤT CẢ admin users
            for (User adminUser : adminUsers) {
                System.out.println("📤 Gửi tin nhắn từ " + msg.getSenderId() + " tới admin: " + adminUser.getEmail());
                messagingTemplate.convertAndSendToUser(adminUser.getEmail(), "/queue/messages", msg);
            }
        } else {
            // Fallback: thử gửi tới các email admin phổ biến
            System.out.println("⚠️ Không tìm thấy admin trong DB, thử gửi tới email mặc định");
            messagingTemplate.convertAndSendToUser("admins@gmail.com", "/queue/messages", msg);
            messagingTemplate.convertAndSendToUser("admin@gmail.com", "/queue/messages", msg);
        }
    }
}
