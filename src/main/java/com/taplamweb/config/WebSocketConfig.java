package com.taplamweb.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.messaging.simp.config.MessageBrokerRegistry;
import org.springframework.web.socket.config.annotation.EnableWebSocketMessageBroker;
import org.springframework.web.socket.config.annotation.StompEndpointRegistry;
import org.springframework.web.socket.config.annotation.WebSocketMessageBrokerConfigurer;

@Configuration
@EnableWebSocketMessageBroker
public class WebSocketConfig implements WebSocketMessageBrokerConfigurer {
    @Override
    public void registerStompEndpoints(StompEndpointRegistry registry) {
        // Frontend kết nối vào đường dẫn này
        // setAllowedOriginPatterns("*") để tránh lỗi CORS nếu chạy FE riêng
        registry.addEndpoint("/ws").setAllowedOriginPatterns("*").withSockJS();
    }

    @Override
    public void configureMessageBroker(MessageBrokerRegistry registry) {
        // 3. Cấu hình nơi tin nhắn đi ra (Client lắng nghe ở đây)

        registry.enableSimpleBroker("/queue", "/user");
        // 4. Cấu hình nơi tin nhắn đi vào (Client gửi lên đây)
        // Khi Client gửi tin nhắn có prefix /app, nó sẽ chạy vào các hàm trong
        // Controller
        registry.setApplicationDestinationPrefixes("/app");
        // 5. Cấu hình prefix riêng cho user (mặc định là /user)
        registry.setUserDestinationPrefix("/user");
    }

}
