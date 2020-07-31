package com.i_am_guna.controller;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.PhotoLink;
import com.i_am_guna.entity.PhotoLinksSearchBody;
import com.i_am_guna.entity.Tag;
import com.i_am_guna.repository.PhotoLinksRepository;
import com.i_am_guna.repository.TagsRepository;
import com.i_am_guna.repository.UserRepository;

@RestController
public class PhotoLinksController {
	
	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private TagsRepository tagRepository;
	
	@Autowired
	private PhotoLinksRepository photoLinksRepository;
	
	public List<Tag> findTagsByEventId(@PathVariable int eventId) {
		return tagRepository.findTagsByEventId(eventId);
	}
	
	@PostMapping("/users/{userName}/photoLinks")
	public List<PhotoLink> findUserPhotoLinks(@PathVariable String userName, @RequestBody PhotoLinksSearchBody photoLink) {
		String selectedTag = "%";
		userName = userName.toLowerCase();
		photoLink.setKeyword("%"+photoLink.getKeyword().toLowerCase().trim()+"%");
		if(photoLink.getSelectedTag()!=0) {
			selectedTag = Integer.toString(photoLink.getSelectedTag());
		}
		List<PhotoLink> photoLinks =  userRepository.findUserPhotoLinksByQuery(userName,photoLink.getKeyword(),photoLink.getFromDate(),photoLink.getToDate(),selectedTag);
		List<PhotoLink> photoLinksFinal = new ArrayList<PhotoLink>();
		for(PhotoLink pl : photoLinks) {
			String[] tagIds = pl.getTagIDs().split(",");
			String[] tagNames = pl.getTagNames().split(",");
			List<Tag> tagList = new ArrayList<Tag>();
			for(int i=0; i<tagIds.length;i++) {
				tagList.add(new Tag(Integer.parseInt(tagIds[i]),tagNames[i]));
			}
			pl.setTags(tagList);
			photoLinksFinal.add(pl);
		}
		return photoLinksFinal;
	}
	
	@PostMapping("/addOrUpdatePhotoLink")
	public void addOrUpdatePhotoLink(@RequestBody PhotoLink photoLink){
		Collection<Tag> tags = new ArrayList<Tag>();
		for(int tagId : photoLink.getTagids()) {
			tags.add(tagRepository.findById(tagId).get());
		}
		photoLink.setTags(tags);
		photoLinksRepository.save(photoLink);
	}
	
	@GetMapping("/getAllPhotos")
	public List<PhotoLink> getAllPhotos(){
		return photoLinksRepository.findAll();
	}
	
}
