package com.spring.greenStudyS.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.greenStudyS.dao.AdminDAO;
import com.spring.greenStudyS.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	AdminDAO adminDAO;

	@Override
	public int setMemberLevelSelectCheck(int idx, int levelItem) {
		return adminDAO.setMemberLevelSelectCheck(idx, levelItem);
	}

	@Override
	public int setMemberDeleteOk(int idx) {
		return adminDAO.setMemberDeleteOk(idx);
	}

	@Override
	public List<MemberVO> getMemberList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberList(startIndexNo, pageSize, level);
	}

	@Override
	public List<MemberVO> getNewMemberList(int startIndexNo, int pageSize) {
		return adminDAO.getNewMemberList(startIndexNo, pageSize);
	}

	@Override
	public List<MemberVO> getMemberDeleteList(int startIndexNo, int pageSize, int level) {
		return adminDAO.getMemberDeleteList(startIndexNo, pageSize, level);
	}
	
}
