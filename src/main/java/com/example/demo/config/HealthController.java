package com.example.demo.config;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
public class HealthController {

    @RequestMapping(value = "/health", method = {RequestMethod.GET, RequestMethod.HEAD})
    public ResponseEntity<Void> health() {
        return ResponseEntity.ok().build(); // HEAD면 바디 없음, GET도 200
    }
}
