package com.spring.greenStudyS.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.greenStudyS.service.ReviewService;
import com.spring.greenStudyS.vo.ReviewVO;

@Controller
@RequestMapping("/review")
public class ReviewController {

	@Autowired
	ReviewService reviewService;
	
	@ResponseBody
	@PostMapping("/reviewInput")
	public int reviewInputPost(ReviewVO vo) {
		return reviewService.setReviewInput(vo);
	}
	
	@ResponseBody
	@PostMapping("/reviewReplyInputOk")
	public int reviewReplyInputOkPost(ReviewVO vo) {
		return reviewService.setReviewReplyInput(vo);
	}
	
	@ResponseBody
	@PostMapping("/reviewReplyDelete")
	public int reviewReplyDeletePost(int replyIdx) {
		return reviewService.setReviewReplyDelete(replyIdx);
	}
	
}

