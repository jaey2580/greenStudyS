package com.spring.greenStudyS.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.greenStudyS.dao.ReviewDAO;
import com.spring.greenStudyS.vo.ReviewVO;

@Service
public class ReviewServiceImpl implements ReviewService {
	
	@Autowired
	ReviewDAO reviewDAO;

	@Override
	public int setReviewInput(ReviewVO vo) {
		return reviewDAO.setReviewInput(vo);
	}

	@Override
	public int setReviewReplyInput(ReviewVO vo) {
		return reviewDAO.setReviewReplyInput(vo);
	}

	@Override
	public int setReviewReplyDelete(int replyIdx) {
		return reviewDAO.setReviewReplyDelete(replyIdx);
	}
}
