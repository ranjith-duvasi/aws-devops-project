package com.example.orders.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.util.*;

@RestController
@RequestMapping("/orders")
public class OrderController {

    private static final Logger log = LoggerFactory.getLogger(OrderController.class);
    private final Map<String, String> orders = new HashMap<>();

    @PostMapping
    public Map<String, String> createOrder(@RequestBody Map<String, String> payload) {
        String id = UUID.randomUUID().toString();
        orders.put(id, payload.getOrDefault("item", "unknown"));

        log.info("Order created with id={} item={}", id, payload.get("item"));
        return Map.of("orderId", id);
    }

    @GetMapping
    public Map<String, String> getOrders() {
        log.info("Fetching all orders. count={}", orders.size());
        return orders;
    }

    @GetMapping("/error")
    public void simulateError() {
        log.error("Simulated error endpoint called");
        throw new RuntimeException("Simulated failure");
    }
}
