package com.jenkinsmono.controller;

import com.jenkinsmono.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/api/test")
@CrossOrigin(origins = "*")
public class TestController {

    @Autowired
    private DataSource dataSource;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("/database")
    public ResponseEntity<Map<String, Object>> testDatabase() {
        Map<String, Object> response = new HashMap<>();
        
        try (Connection connection = dataSource.getConnection()) {
            response.put("databaseStatus", "CONNECTED");
            response.put("databaseUrl", connection.getMetaData().getURL());
            response.put("databaseProduct", connection.getMetaData().getDatabaseProductName());
            response.put("databaseVersion", connection.getMetaData().getDatabaseProductVersion());
            response.put("timestamp", java.time.LocalDateTime.now());
            
            // 사용자 테이블 정보
            response.put("totalUsers", userRepository.count());
            
            return ResponseEntity.ok(response);
        } catch (SQLException e) {
            response.put("databaseStatus", "ERROR");
            response.put("error", e.getMessage());
            response.put("timestamp", java.time.LocalDateTime.now());
            return ResponseEntity.status(500).body(response);
        }
    }

    @GetMapping("/jpa")
    public ResponseEntity<Map<String, Object>> testJpa() {
        Map<String, Object> response = new HashMap<>();
        
        try {
            long userCount = userRepository.count();
            response.put("jpaStatus", "WORKING");
            response.put("userCount", userCount);
            response.put("timestamp", java.time.LocalDateTime.now());
            
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            response.put("jpaStatus", "ERROR");
            response.put("error", e.getMessage());
            response.put("timestamp", java.time.LocalDateTime.now());
            return ResponseEntity.status(500).body(response);
        }
    }
} 