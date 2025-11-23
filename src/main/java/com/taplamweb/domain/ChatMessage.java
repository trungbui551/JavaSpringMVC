package com.taplamweb.domain;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "chat_messages")
public class ChatMessage {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;
    private String chatId; // (Tùy chọn) Gom nhóm tin nhắn giữa A và B

    private String senderId; // Username người gửi
    private String recipientId; // Username người nhận
    private String content; // Nội dung tin nhắn

    private Date timestamp; // Thời gian gửi

    // Trạng thái tin nhắn (đã xem hay chưa) - rất quan trọng cho Admin biết tin nào
    // mới
    @Enumerated(EnumType.STRING)
    private MessageStatus status;
}
