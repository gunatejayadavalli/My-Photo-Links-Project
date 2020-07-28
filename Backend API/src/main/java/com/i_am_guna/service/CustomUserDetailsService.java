package com.i_am_guna.service;

import java.util.Collection;
import java.util.stream.Collectors;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import com.i_am_guna.entity.LoginSuccessData;
import com.i_am_guna.entity.Role;
import com.i_am_guna.entity.User;
import com.i_am_guna.repository.UserRepository;

@Service
public class CustomUserDetailsService  implements UserDetailsService{
	
	@Autowired
	private UserRepository userRepository;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		User user = userRepository.findByUserName(username);
		return new org.springframework.security.core.userdetails.User(user.getUserName(), user.getPassword(), mapRolesToAuthorities(user.getRoles()));
	}

	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Collection<Role> roles) {
		return roles.stream().map(role -> new SimpleGrantedAuthority(role.getRoleName())).collect(Collectors.toList());
	}
	
	public LoginSuccessData getUserDetails(String username) {
		User user = userRepository.findByUserName(username);
		return new LoginSuccessData(user.getUserId(), user.getUserName(), user.getFirstName(), user.getLastName(), user.getEmail(), user.getBlockFlag(), user.getBlockReason(),user.getSecurityQues(), user.getRoles(), user.getTags());
	}
	
}
