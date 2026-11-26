package com.spring.greenStudyS.service;

import com.spring.greenStudyS.vo.ReviewVO;

public interface ReviewService {

	int setReviewInput(ReviewVO vo);

	int setReviewReplyInput(ReviewVO vo);

	int setReviewReplyDelete(int replyIdx);

}
