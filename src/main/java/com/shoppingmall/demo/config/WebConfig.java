package com.shoppingmall.demo.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 현재 프로젝트의 디렉토리 경로를 가져옴
        String projectPath = System.getProperty("user.dir");
        // 업로드된 파일이 저장될 경로를 지정
        // "file:" 프리픽스를 통해 파일 시스템 경로임을 명시하고, 프로젝트 내의 정적 리소스 폴더 경로로 설정
        String uploadPath = "file:" + projectPath + "/src/main/resources/static/upload/";
        
        // "/upload/**"로 시작하는 URL 요청을 위의 파일 경로로 매핑
        // 예: http://localhost:8080/upload/test.jpg -> src/main/resources/static/upload/test.jpg 파일 반환
        registry.addResourceHandler("/upload/**")
                .addResourceLocations(uploadPath);

        // CK에이터 이미지 핸들러
        String editorPath = "file:" + projectPath + "/src/main/resources/static/upload/editor/";
        registry.addResourceHandler("/upload/editor/**")
                .addResourceLocations(editorPath);
    }
} 