package com.jerryboot.springbootdemo.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpMethod;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@EnableWebSecurity
public class MoreSecurityConfig {
	
	
	
	
	

//	@Configuration
//	@Order(1)
//	public class adminSecurityConfig extends WebSecurityConfigurerAdapter{
		
//		@Autowired
//		private UserDetailsService adminUserDetiService;
//		
//		@Override
//		protected void configure(HttpSecurity http) throws Exception {
//			
//			/*
//			 * 可搭配JSP的Spring Security Taglibs標籤
//			 */
//			
//			/*
//			 * 授權認證
//			 */
//			//自訂規則
//			http.antMatcher("/Backstage/**")
//				.authorizeRequests()
////				.antMatchers("/Backstage/**").hasAnyRole("admin")
//				//有權限才可以
////				.antMatchers("").hasAuthority("")
////				有身分才可以
//				.antMatchers("/Backstage/employeelogin").permitAll()
//				//有複數身分或權限
////				.antMatchers("").hasAnyRole("")
//				//剩下的
//				.anyRequest().authenticated()//hasRole("admin")
////			GET方法且在網址/ShoppingCart時,要有驗證
////				.antMatchers(HttpMethod.GET, "/ShoppingCart").authenticated()
//				.and()
//				.csrf().disable();//關閉csrf防護,不會拒絕外部請求(ex:Postman)測試完要刪掉
//			
//			/*
//			 * 自訂登入登出頁面
//			 */
//			//登入
//			//用表單提交
//			http.formLogin()
//				//表單action內容
//				.loginProcessingUrl("/employeepost")
//				//登入頁面
//				.loginPage("/Backstage/employeelogin")
//				//登入成功的頁面
//				.successForwardUrl("/Backstage")
//				//登入失敗的頁面
//				.failureForwardUrl("/Backstage/employeeloginError");
//			
//			//登出,可直接在網址打上/logout
////			http.logout()
////				//刪除Session
////				.deleteCookies("JSESSIONID")
////				//發出登出POST的頁面
////				.logoutUrl("")
////				//登出成功頁面
////				.logoutSuccessUrl("/Logout");
//			/*
//			 * 自訂異常頁面
//			 */
////			http.exceptionHandling()
////				//實作MyAccessDeniedHandler介面AccessDeniedHandler//時間軸2:55:00
//////				.accessDeniedHandler(null)
////				//或依據頁面
////				.accessDeniedPage("");
//			/*
//			 * 記住我
//			 * 在HTML裡 name="remember-me"
//			 */
////			http.rememberMe()
////				//User物件
////				.userDetailsService(userDetailsService)
////				//持續時間(秒)
////				.tokenValiditySeconds(60*60*24*7);
//			/*
//			 * 第三方登入
//			 * 缺
//			 */
//			
//			
//		}
//		
//		/*
//		 * 把輸入的密碼加密
//		 * 
//		 * 規定要有,不能直接new
//		 */
//
////		@Bean
////		public PasswordEncoder getPasswordEncode() {
////			return new BCryptPasswordEncoder();
////		}
//		
//		/*
//		 * 自訂驗證
//		 */
//		@Override
//		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
//			
//			auth
//			.userDetailsService(adminUserDetiService);
//			
//		}
//	}
	
	@Configuration
	
	public class memberSecurityConfig extends WebSecurityConfigurerAdapter{
		
		@Autowired
		private UserDetailsService memberUserDetialsService;
		
		@Override
		protected void configure(HttpSecurity http) throws Exception {
			/*
			 * 可搭配JSP的Spring Security Taglibs標籤
			 */
			
			/*
			 * 授權認證
			 */
			//自訂規則
			http
				.authorizeRequests()
				//有權限才可以
//				.antMatchers("/ShoppingCart").hasAuthority("")
//				先把不要有權限的放在前面
				.antMatchers("/frontMemberLogin").permitAll()
				.antMatchers("/FrontMember/goAddMember").permitAll()
				.antMatchers("/FrontMember/addMember").permitAll()
//				有身分才可以
				.antMatchers("/FrontMember/**").hasRole("menber")
				.antMatchers("/ShoppingCart").hasRole("menber")
				//有複數身分或權限
//				.antMatchers("").hasAnyRole("")
				//剩下的//都可以訪問
				.anyRequest().permitAll()
//			GET方法且在網址/ShoppingCart時,要有驗證
//				.antMatchers(HttpMethod.GET, "/ShoppingCart").authenticated()
				//
//				.and()
//				.oauth2Login()
//                .loginPage("/frontMemberLogin")
				.and()
				.csrf().disable();//關閉csrf防護,不會拒絕外部請求(ex:Postman)測試完要刪掉
			
			/*
			 * 自訂登入登出頁面
			 */
			//登入
			//用表單提交
			http.formLogin()
				//表單action內容
				.loginProcessingUrl("/memberpost")
				//登入頁面
				.loginPage("/frontMemberLogin")
				//登入成功的頁面
				.successForwardUrl("/LoginOK")
				//登入失敗的頁面
				.failureForwardUrl("/LoginFail");
			
			//登出,可直接在網址打上/logout
			http.logout()
//				//刪除Session
				.deleteCookies("JSESSIONID")
//				//發出登出POST的頁面
//				.logoutUrl("")
//				//登出成功頁面
				.logoutSuccessUrl("/Logout");
			/*
			 * 自訂異常頁面
			 */
//			http.exceptionHandling()
//				//實作MyAccessDeniedHandler介面AccessDeniedHandler//時間軸2:55:00
////				.accessDeniedHandler(null)
//				//或依據頁面
//				.accessDeniedPage("");
			/*
			 * 記住我
			 * 在HTML裡 name="remember-me"
			 */
			http.rememberMe()
//				//User物件
				.userDetailsService(memberUserDetialsService)
//				//持續時間(秒)
				.tokenValiditySeconds(60*60*24*7);
			/*
			 * 第三方登入
			 * 缺
			 */
			
			
			
		}
		
		/*
		 * 把輸入的密碼加密
		 * 
		 * 規定要有,不能直接new
		 */

		@Bean
		public PasswordEncoder getPasswordEncode() {
			return new BCryptPasswordEncoder();
		}
		
		/*
		 * 自訂驗證
		 */
		@Override
		protected void configure(AuthenticationManagerBuilder auth) throws Exception {
			
			auth
			.userDetailsService(memberUserDetialsService);
			
		}
		
		
		
	}
	
	
}
