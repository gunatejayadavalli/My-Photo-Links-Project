package com.i_am_guna.controller;
import java.util.Arrays;
import java.util.Date;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.AuthRequest;
import com.i_am_guna.entity.LoginSuccessData;
import com.i_am_guna.entity.Role;
import com.i_am_guna.entity.User;
import com.i_am_guna.repository.RoleRepository;
import com.i_am_guna.repository.UserRepository;
import com.i_am_guna.service.CustomUserDetailsService;
import com.i_am_guna.util.JwtUtil;

@RestController
public class AuthController {
	
	@Autowired
	private JwtUtil jwtUtil;
	
	@Autowired
	private AuthenticationManager authenticationManager;
	
	@Autowired
	private CustomUserDetailsService userDetailsService;
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RoleRepository roleRepository;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
	
	@PostMapping("/authenticate")
	public LoginSuccessData generateToken(@RequestBody AuthRequest authRequest) throws Exception {
		authRequest.setUsername(authRequest.getUsername().toLowerCase());
		LoginSuccessData loginSuccessData = new LoginSuccessData();
			if(checkUserNameExist(authRequest.getUsername())) {
			try {		
				authenticationManager.authenticate(new UsernamePasswordAuthenticationToken(authRequest.getUsername(), authRequest.getPassword()));
				loginSuccessData = userDetailsService.getUserDetails(authRequest.getUsername());
				loginSuccessData.setToken(jwtUtil.generateToken(authRequest.getUsername()));
				loginSuccessData.setLoggedInDate(JwtUtil.createTokenDate);
				loginSuccessData.setTokenExpirationDate(JwtUtil.expireTokenDate);
			}catch (Exception e) {
				throw new Exception("INVALID_PASSWORD");
			}
			return loginSuccessData;
		}else {
			throw new Exception("USER_NOT_FOUND");
		}
	}
	
	@GetMapping("/refreshUser/{userName}")
	public LoginSuccessData refreshUser(@PathVariable String userName) {
		LoginSuccessData loginSuccessData = null;
		if(userRepository.checkUserNameExist(userName)>0) {
			return userDetailsService.getUserDetails(userName);
		}
		return loginSuccessData;
	}
	
	@GetMapping("/checkUserNameExist/{userName}")
	public boolean checkUserNameExist(@PathVariable String userName) {
		userName = userName.toLowerCase();
		if(userRepository.checkUserNameExist(userName)>0) {
			return true;
		}else {
			return false;
		}
	}
	
	@GetMapping("/getUserSecQues/{userName}")
	public String getUserSecQues(@PathVariable String userName) {
		userName = userName.toLowerCase();
		String returnString = "USER_DONT_EXIST";
		if(userRepository.checkUserNameExist(userName)>0) {
			returnString = userRepository.getSecQuesByUserName(userName);
		}
		return returnString;
	}
	
	@PostMapping("/validateAnswer")
	public boolean validateAnswer(@RequestBody User user) {
		user.setUserName(user.getUserName().toLowerCase());
		if(userRepository.validateAnswer(user.getUserName(),user.getSecurityAns())>0) {
			return true;
		}else {
			return false;
		}
	}
	
	@PostMapping("/resetPassword")
	public int resetPassword(@RequestBody User user) {
		user.setUserName(user.getUserName().toLowerCase());
		return userRepository.updatePassword(passwordEncoder.encode(user.getPassword()),new Date(),user.getUserName());
	}
	
	@GetMapping("/getSecQuesAnswer/{userName}")
	public String getSecQuesAnswer(@PathVariable String userName) {
		userName = userName.toLowerCase();
		String answer ="";
		answer = userRepository.getSecQuesAnswer(userName);
		return answer;
	}
	
	@PostMapping("/registerUser")
	public User registerUser(@RequestBody User user){
		user.setUserName(user.getUserName().toLowerCase());
		Role role = roleRepository.findByRoleName("ROLE_USER");
		user.setUserName(user.getUserName());
		user.setPassword(passwordEncoder.encode(user.getPassword()));
		user.setRoles(Arrays.asList(role));
		userRepository.save(user);
		return user;
	}
	
	@PostMapping("/updateUserProfile")
	public LoginSuccessData updateUserProfile(@RequestBody User user) {
		System.out.println("User in request : "+user);
		if(user.getPassword()!=null) {
			user.setPassword(passwordEncoder.encode(user.getPassword()));
			userRepository.updateUserProfileWithPassword(user.getPassword(), user.getFirstName(), user.getLastName(), user.getEmail(), 
					user.getSecurityQues(), user.getSecurityAns(), new Date(), user.getUserId());
		}else {
			userRepository.updateUserProfileWithNoPassword(user.getFirstName(), user.getLastName(), user.getEmail(), 
					user.getSecurityQues(), user.getSecurityAns(), new Date(), user.getUserId());
		}
		return userDetailsService.getUserDetails(user.getUserName());
	}
	
}
