package com.i_am_guna.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.i_am_guna.entity.Tag;
import com.i_am_guna.entity.User;
import com.i_am_guna.repository.TagsRepository;
import com.i_am_guna.repository.UserRepository;

@RestController
public class ManageUsersController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private TagsRepository tagsRepository;
	
	@GetMapping("/getAllUsers")
	public List<User> getAllUsers() {
		return userRepository.findAllByOrderByCreationTimeDesc();
	}
	
	@PostMapping("/blockUnblockUser")
	public int blockUnblockUser(@RequestBody User user) {
		return userRepository.blockUnblockUser(user.getBlockFlag(),user.getBlockReason(),user.getUserName());
	}
	
	@GetMapping("/toggleAdminRole/{userId}")
	public boolean toggleAdminRole(@PathVariable int userId) {
		int adminRoleId = 2;
		boolean flag = false;
		if(checkIfUserHasRole(userId, adminRoleId)>0) {
			if(deleteUserRole(userId, adminRoleId)>0)
			flag = true;
		}else {
			if(insertUserRole(userId, adminRoleId)>0)
			flag = true;
		}
		return flag;
	}
	
	public int checkIfUserHasRole(int userId, int roleId) {
		return userRepository.checkIfUserHasRole(userId,roleId);
	}
	
	public int deleteUserRole(int userId, int roleId) {
		return userRepository.deleteUserRole(userId,roleId);
	}
	
	public int insertUserRole(int userId, int roleId) {
		return userRepository.insertUserRole(userId,roleId);
	}
	
	@PostMapping("/modifyUserTags")
	public boolean modifyUserTags(@RequestBody User user, @RequestParam("hasTags") boolean hasTags) {
		boolean flag = false;
		if(hasTags) {
			tagsRepository.deleteAllUserTags(user.getUserId());
			for(Tag tag : user.getTags()) {
				tagsRepository.insertUserTag(user.getUserId(), tag.getTagId());
			}
			flag = true;
		}else {
			for(Tag tag : user.getTags()) {
				tagsRepository.insertUserTag(user.getUserId(), tag.getTagId());
			}
			flag = true;
		}
		return flag;
	}
	
}
