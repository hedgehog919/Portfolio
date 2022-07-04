package com.jerryboot.springbootdemo.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.jerryboot.springbootdemo.util.SessionInterceptor;


@Configuration
public class WebConfig implements WebMvcConfigurer {
	
	@Override
	public void addInterceptors(InterceptorRegistry registry) {
		registry.addInterceptor(new SessionInterceptor())
				.addPathPatterns("/Backstage/*") // 攔截路徑
				.excludePathPatterns("/Backstage/employeelogin", "/Backstage/employeepost"); // 排除路徑
	}

}
