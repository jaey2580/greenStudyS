package com.spring.greenStudyS.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.spring.greenStudyS.vo.ScheduleVO;

public interface ScheduleService {

	void getSchedule(HttpServletRequest request);

	List<ScheduleVO> getScheduleMenu(String mid, String ymd);

	int setScheduleInputOk(ScheduleVO vo);

	int setScheduleDelete(int idx);

	int setScheduleUpdate(ScheduleVO vo);

}
