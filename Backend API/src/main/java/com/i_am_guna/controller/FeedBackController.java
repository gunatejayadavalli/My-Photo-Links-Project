package com.i_am_guna.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import com.i_am_guna.entity.Feedback;
import com.i_am_guna.repository.FeedbackRepository;

@RestController
public class FeedBackController {
	
	@Autowired
	private FeedbackRepository feedbackRepository;
	
	@GetMapping("/getAllFeedbacks")
	public List<Feedback> getAllFeedbacks() {
		return feedbackRepository.findAllByOrderBySubmittedDateDesc();
	}

}