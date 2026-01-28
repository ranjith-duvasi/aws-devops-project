package com.example.order.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.client.WebClient;

import java.util.Map;

@Component
public class NotificationClient {

    private static final Logger log = LoggerFactory.getLogger(NotificationClient.class);

    private final WebClient webClient = WebClient.create();

    public void sendNotification(String user, String message) {
        log.info("Calling Notification Service for user={}", user);

        try {
            webClient.post()
                    .uri("http://notification-service:3000/notify")
                    .bodyValue(Map.of("user", user, "message", message))
                    .retrieve()
                    .bodyToMono(String.class)
                    .block();

            log.info("Notification sent successfully");
        } catch (Exception e) {
            log.error("Failed to send notification", e);
        }
    }
}
