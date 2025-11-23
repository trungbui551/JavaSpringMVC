package com.taplamweb.controller;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.service.ChatService;

@Controller

public class ChatController {
    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    @Autowired
    private ChatService chatService;

    // Endpoint nhận tin nhắn từ Client
    @MessageMapping("/chat")
    public void processMessage(@Payload ChatMessage chatMessage, Principal principal) {

        // 1. Xác thực người gửi (Lấy từ Spring Security Session)
        String senderName = principal.getName();
        chatMessage.setSenderId(senderName);

        // 2. Lưu vào Database
        ChatMessage savedMsg = chatService.save(chatMessage);

        // 3. Gửi tin nhắn tới Người nhận (Recipient)
        // Đường dẫn đích: /user/{recipientId}/queue/messages
        messagingTemplate.convertAndSendToUser(
                chatMessage.getRecipientId(),
                "/queue/messages",
                savedMsg);

        // 4. (Tùy chọn) Gửi lại cho chính người gửi để họ thấy tin nhắn vừa chat
        // (Hoặc Frontend tự render ngay khi bấm gửi cho nhanh)
    }
}
