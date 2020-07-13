package com.i_am_guna.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.AuthRequest;
import com.i_am_guna.entity.LoginSuccessData;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.repository.UserRepository;
import com.i_am_guna.service.CustomUserDetailsService;
import com.i_am_guna.util.JwtUtil;

@RestController
public class WelcomeController {
	
	@Autowired
	private JwtUtil jwtUtil;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private CustomUserDetailsService userDetailsService;
	
	@Autowired
	private UserRepository userRepository;

	@GetMapping("/")
	public String testMethod() {
		return "Hello World..!!!";
	}
	
	@CrossOrigin
	@PostMapping("/authenticate")
	public LoginSuccessData generateToken(@RequestBody AuthRequest authRequest) throws Exception {
		System.out.println("inside generateToken");
		LoginSuccessData loginSuccessData = new LoginSuccessData();
		try {		
			authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
			loginSuccessData = userDetailsService.getUserDetails(authRequest.getUsername());
			loginSuccessData.setToken(jwtUtil.generateToken(authRequest.getUsername()));
			loginSuccessData.setLoggedInDate(JwtUtil.createTokenDate);
			loginSuccessData.setTokenExpirationDate(JwtUtil.expireTokenDate);
		}catch (Exception e) {
			throw new Exception("Invalid Username or Password");
		}
		return loginSuccessData;
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
	
	@GetMapping("/users/{userName}/photoLinks")
	public List<PhotoLink> findPhotoLinksByUsername(@PathVariable String userName) {
		return userRepository.findPhotoLinksByUserName(userName);
	}
	
}
