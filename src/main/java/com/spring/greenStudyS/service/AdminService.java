package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.MemberVO;

public interface AdminService {

	int setMemberLevelSelectCheck(int idx, int levelItem);

	List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level);

	List<MemberVO> getNewMemberList(int startIndexNo, int pageSize);

	List<MemberVO> getMemberDeleteList(int startIndexNo, int pageSize, int level);

	int setMemberDeleteOk(int idx);

}
