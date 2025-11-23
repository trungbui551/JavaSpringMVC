package com.taplamweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.taplamweb.domain.ChatMessage;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    // Tìm tin nhắn giữa 2 người (ví dụ user1 và admin)
    List<ChatMessage> findBySenderIdAndRecipientId(String senderId, String recipientId);

}
