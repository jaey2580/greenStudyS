package com.spring.greenStudyS.dao;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.ReviewVO;

public interface ReviewDAO {

	int setReviewInput(@Param("vo") ReviewVO vo);

	int setReviewReplyInput(@Param("vo") ReviewVO vo);

	int setReviewReplyDelete(@Param("replyIdx") int replyIdx);

}
