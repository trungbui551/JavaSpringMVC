package com.taplamweb.controller.admin;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.service.ChatService;

@Controller
public class AdminChatController {
    @Autowired
    ChatService chatService;
    @Autowired
    private SimpMessagingTemplate messagingTemplate;

    @GetMapping("/admin/chat")
    public String getChatPage() {
        return "admin/dashboard/admin_chat";
    }

    @MessageMapping("/chat/admin/send")
    public void sendFromAdmin(ChatMessage msg, Principal principal) {
        msg.setSenderId(principal.getName());
        chatService.save(msg);

        messagingTemplate.convertAndSendToUser(msg.getRecipientId(), "/queue/messages", msg);
    }

}
