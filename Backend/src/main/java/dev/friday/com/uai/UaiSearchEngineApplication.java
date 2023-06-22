package dev.friday.com.uai;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.openfeign.EnableFeignClients;

@SpringBootApplication
@EnableFeignClients
public class UaiSearchEngineApplication {

    public static void main(String[] args) {
        SpringApplication.run(UaiSearchEngineApplication.class, args);
    }

}
