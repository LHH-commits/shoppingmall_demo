package com.shoppingmall.demo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class CKEditorController {
    
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    
    @Value("${custom.file.upload.editor-path}")
    private String editorUploadPath;
    
    @PostMapping("/upload/editor/image")
    @ResponseBody
    public Map<String, Object> uploadEditorImage(@RequestParam("upload") MultipartFile file, HttpServletRequest request) {
        Map<String, Object> response = new HashMap<>();
        
        try {
            // 프로젝트 루트 경로 가져오기
            String projectPath = System.getProperty("user.dir");
            
            // 전체 업로드 경로 생성
            String uploadDir = projectPath + "/" + editorUploadPath;
            
            // 에디터 전용 디렉토리에 저장
            File directory = new File(uploadDir);
            if (!directory.exists()) {
                directory.mkdirs();
            }
            
            String fileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            File destFile = new File(directory, fileName);
            file.transferTo(destFile);
            
            // 서버의 도메인 주소 가져오기
            String serverUrl = request.getScheme() + "://" + request.getServerName();
            if (request.getServerPort() != 80 && request.getServerPort() != 443) {
                serverUrl += ":" + request.getServerPort();
            }
            
            // 전체 URL 생성
            String fileUrl = serverUrl + "/upload/editor/" + fileName;
            
            logger.info("파일 업로드 성공: {}", fileUrl);
            
            response.put("uploaded", 1);
            response.put("fileName", fileName);
            response.put("url", fileUrl);  // 전체 URL 사용
            
        } catch (IOException e) {
            logger.error("파일 업로드 실패", e);
            response.put("uploaded", 0);
            response.put("error", new HashMap<String, String>(){{
                put("message", "파일 업로드 실패: " + e.getMessage());
            }});
        }
        
        return response;
    }
}
