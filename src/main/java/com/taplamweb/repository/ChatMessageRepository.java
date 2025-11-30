package com.taplamweb.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.taplamweb.domain.ChatMessage;

public interface ChatMessageRepository extends JpaRepository<ChatMessage, Long> {
    // Tìm tin nhắn giữa 2 người (ví dụ user1 và admin)
    List<ChatMessage> findBySenderIdAndRecipientId(String senderId, String recipientId);

    List<ChatMessage> findByRecipientId(String recipientId);

    // Lấy tất cả tin nhắn liên quan đến 2 user (cả 2 chiều)
    @Query("SELECT c FROM ChatMessage c WHERE " +
            "(c.senderId = :user1 AND c.recipientId = :user2) OR " +
            "(c.senderId = :user2 AND c.recipientId = :user1) " +
            "ORDER BY c.id ASC")
    List<ChatMessage> findChatHistory(@Param("user1") String user1,
            @Param("user2") String user2);

    // Lấy danh sách các user đã chat với admin
    @Query("SELECT DISTINCT CASE " +
            "WHEN c.senderId = 'ADMIN' THEN c.recipientId " +
            "ELSE c.senderId END " +
            "FROM ChatMessage c WHERE c.senderId = 'ADMIN' OR c.recipientId = 'ADMIN'")
    List<String> findAllChatUsers();
}
