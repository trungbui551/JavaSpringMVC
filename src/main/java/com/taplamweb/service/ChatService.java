package com.taplamweb.service;

import java.util.Date;

import org.springframework.stereotype.Service;

import com.taplamweb.domain.ChatMessage;
import com.taplamweb.domain.MessageStatus;
import com.taplamweb.repository.ChatMessageRepository;

import lombok.AllArgsConstructor;

@Service
@AllArgsConstructor
public class ChatService {
    private ChatMessageRepository ChatMessageRepository;

    public ChatMessage save(ChatMessage chatMessage) {
        chatMessage.setStatus(MessageStatus.RECEIVED);
        chatMessage.setTimestamp(new Date());
        return ChatMessageRepository.save(chatMessage);
    }
}
