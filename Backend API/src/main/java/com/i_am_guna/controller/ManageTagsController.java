package com.i_am_guna.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.Tag;
import com.i_am_guna.repository.TagsRepository;

@RestController
public class ManageTagsController {
	
	@Autowired
	private TagsRepository tagsRepository;
	
	@GetMapping("/getAllTags")
	public List<Tag> getAllTags() {
		return tagsRepository.findAllByOrderByCreationTimeDesc();
	}
	
	@GetMapping("/deleteTag/{tagId}")
	public boolean deleteTag(@PathVariable int tagId) {
		boolean flag = false;
		if(tagsRepository.deleteUserTag(tagId)>0) {
			if(tagsRepository.deletePhotoLinkTag(tagId)>0) {
				if(tagsRepository.deleteTag(tagId)>0){
					flag = true;
				}
			}
		}
		return flag;
	}
	
	@PostMapping("/addUpdateTag")
	public boolean addUpdateTag(@RequestBody Tag tag) {
		boolean flag=false;
		int tagId = tag.getTagId();
		Tag savedTag = tagsRepository.save(tag);
		if(savedTag!=null) {
			if(tagId==0) {
				int superAdminRoleId = 1;
				Object[] userIds = tagsRepository.getUserIdsWithRole(superAdminRoleId);
				for(Object userId : userIds) {
					tagsRepository.insertUserTag((int)userId, savedTag.getTagId());
				}
				flag= true;
			}else {
				flag= true;
			}
		}
		return flag;
	}

}