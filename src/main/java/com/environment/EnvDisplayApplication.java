package com.environment;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
public class EnvDisplayApplication {

    public static void main(String[] args) {
        SpringApplication.run(EnvDisplayApplication.class, args);
    }

    @RestController
    class EnvController {

        @Value("${env.name:Desconocido}")
        private String environment;

        @GetMapping("/")
        public String showEnvironment() {
            return "<h1>Entorno Actual: " + environment + "</h1>";
        }
    }
}
