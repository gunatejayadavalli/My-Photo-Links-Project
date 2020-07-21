package com.i_am_guna.controller;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.repository.UserRepository;

@CrossOrigin
@RestController
public class MainController {
	
	@Autowired
	private UserRepository userRepository;
	
	@GetMapping("/users/{userName}/photoLinks")
	public List<PhotoLink> findPhotoLinksByUsername(@PathVariable String userName) {
		userName = userName.toLowerCase();
		return userRepository.findPhotoLinksByUserName(userName);
	}
	
	@PostMapping("/users/{userName}/photoLinks")
	public List<PhotoLink> findUserPhotoLinksByQuery(@PathVariable String userName, @RequestBody PhotoLink photoLink) {
		userName = userName.toLowerCase();
		photoLink.setEvent("%"+photoLink.getEvent().toLowerCase().trim()+"%");
		return userRepository.findUserPhotoLinksByQuery(userName,photoLink.getEvent(),photoLink.getFromDate(),photoLink.getToDate());
	}
	
}
