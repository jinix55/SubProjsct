package com.portal;

import javax.annotation.PostConstruct;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

@SpringBootApplication
@EnableScheduling
@EnableEncryptableProperties
public class Application {

	@PostConstruct
	public void started() {
		//APP TimeZone KST
		//TimeZone.setDefault(TimeZone.getTimeZone("UTC+09"));
	}
	
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }

}