package com.spring.greenStudyS.controller;

import java.util.List;

import com.spring.greenStudyS.vo.MemberVO;

public interface AdminService {

	void setMemberLevelSelectCheck(int idx, int levelItem);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	int setMemberDeleteOk(int idx);


}
