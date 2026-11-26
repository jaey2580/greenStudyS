package com.spring.greenStudyS.vo;

import lombok.Data;

@Data
public class ReviewVO {
	//review 필드
	private int idx;
	private String part;
	private int partIdx;
	private String mid;
	private String nickName;
	private int star;
	private String content;
	private String rDate;
	
	//revieReply 테이블의 필드
	private int replyIdx;
	private int reviewIdx;
	private String replyMid;
	private String replyNickName;
	private String replyContent;
	private String replyDate;
	
}
