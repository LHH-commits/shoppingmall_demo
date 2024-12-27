package com.shoppingmall.demo.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.util.matcher.AntPathRequestMatcher;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
	
	@Bean
	public PasswordEncoder passwordEncoder() {
		return new BCryptPasswordEncoder();
	}

	@Bean
	public SecurityFilterChain securityFilterChain(HttpSecurity http) throws Exception {
		http
			// 인증과 권한
			.authorizeHttpRequests((req) -> req
                .requestMatchers("/user/**").authenticated() // 인증된 사용자는 접근가능
                .requestMatchers("/admin/**").hasAuthority("ROLE_ADMIN") // ADMIN만 접근가능
                .anyRequest().permitAll()
            )
			// 폼 로그인
			.formLogin((form) -> form
					.loginPage("/")
					.loginProcessingUrl("/loginPro")
					.defaultSuccessUrl("/loginSuccess",true)
                    .failureUrl("/?error=true")
					.usernameParameter("uId")
					.passwordParameter("uPassword")
					.permitAll()
			)
			// 로그아웃 설정
            .logout((logout) -> logout
                .logoutRequestMatcher(new AntPathRequestMatcher("/logout"))
                .logoutSuccessUrl("/")
                .invalidateHttpSession(true)
                .deleteCookies("JSESSIONID", "remember-me")
            )
            // remember me 설정
            .rememberMe((rememberMe) -> rememberMe
                .key("myWeb")
                .rememberMeParameter("remember-me")
                .tokenValiditySeconds(86400)
            )
            // exceptionHandling
            .exceptionHandling((exceptionHandling) -> exceptionHandling
                .accessDeniedPage("/denied")
            )
            // session 관리
            .sessionManagement((sessionManagement) -> sessionManagement
                .sessionCreationPolicy(SessionCreationPolicy.NEVER)
                .invalidSessionUrl("/")
            )

            .headers(headers -> headers
                .frameOptions(frame -> frame.sameOrigin())
            )

			.csrf((AbstractHttpConfigurer::disable));
		
		return http.build();
	}
}
