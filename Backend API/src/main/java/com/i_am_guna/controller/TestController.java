package com.i_am_guna.controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TestController {

	@GetMapping("/")
	public String testMethod() {
		return "Hello World..!!!";
	}
	
	@GetMapping("/access-denied")
	public String accessedDeniedPage() {
		return "Access denied page";
	}
	
	@GetMapping("/noLogin")
	public String noLoginRequired() {
		return "Hello...This Page doesn't require login...!!!";
	}
	
	@GetMapping("/superAdmin")
	public String onlySuperAdminPage() {
		return "This page is accessable by Super Admin Only";
	}
	
	@GetMapping("/admin")
	public String onlyAdminPage() {
		return "This page is accessable by Super Admin/Admin Only";
	}
	
	@GetMapping("/user")
	public String userPage() {
		return "This page is accessable by all Users authenticated";
	}

}
