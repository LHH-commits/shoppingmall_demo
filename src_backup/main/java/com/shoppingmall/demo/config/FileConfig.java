package com.shoppingmall.demo.config;

import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.stereotype.Component;
import lombok.Getter;
import lombok.Setter;

@Component
// application.yml 또는 application.properties에서 custom.file.upload.path 값 주입
@ConfigurationProperties(prefix = "custom.file.upload")
@Getter
@Setter
public class FileConfig {
    // 업로드 경로를 저장하는 변수
    private String path;

    // 디버깅을 위한 생성자 추가
    public FileConfig() {
        // path 변수의 값을 출력하여 설정이 잘 되었는지 확인
        System.out.println("Upload Path: " + path);
    }

    // 업로드 경로 반환 메서드
    public String getUploadPath() {
        return path;
    }
}