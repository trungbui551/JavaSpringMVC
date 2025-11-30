package com.taplamweb.controller.client;

import java.security.Principal;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.service.ChatService;

@Controller
public class UsercChatController {

    ChatMessage chatMessage;
    @Autowired
    ChatService chatService;
    @Autowired
    SimpMessagingTemplate messagingTemplate;

    @MessageMapping("/chat/user/send")
    public void sendFromUser(ChatMessage msg, Principal principal) {
        msg.setSenderId(principal.getName());
        chatService.save(msg);

        messagingTemplate.convertAndSendToUser("admins@gmail.com", "/queue/messages", msg);
    }
}
