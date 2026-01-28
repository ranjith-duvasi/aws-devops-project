package com.example.order.controller;

import com.example.order.model.Order;
import com.example.order.service.NotificationClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.UUID;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);

    private final NotificationClient notificationClient;

    public OrderController(NotificationClient notificationClient) {
        this.notificationClient = notificationClient;
    }

    @PostMapping
    public Order createOrder(@RequestBody Order order) {
        order.setId(UUID.randomUUID().toString());

        log.info("Order created: {}", order);

        notificationClient.sendNotification(
                "user123",
                "Order created with ID " + order.getId()
        );

        return order;
    }
}
