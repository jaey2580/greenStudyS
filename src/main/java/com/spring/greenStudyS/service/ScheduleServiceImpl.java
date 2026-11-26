package com.spring.greenStudyS.service;

import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.AbstractRequestAttributesScope;

import com.spring.greenStudyS.dao.ScheduleDAO;
import com.spring.greenStudyS.vo.ScheduleVO;

@Service
public class ScheduleServiceImpl implements ScheduleService {
	
	@Autowired
	ScheduleDAO scheduleDAO;

	@Override
	public void getSchedule(HttpServletRequest request) {
		// 오늘 날짜 처리(오늘 날짜를 저장시킬 변수 선언: 년(toYear), 월(toMonth), 일(toDay))
		Calendar calToday = Calendar.getInstance();
		int toYear = calToday.get(Calendar.YEAR);
		int toMonth = calToday.get(Calendar.MONTH);
		int toDay = calToday.get(Calendar.DATE);
		
		// 화면에 표시되는 년도와 월 처리
		Calendar calView = Calendar.getInstance();
 		int yy = request.getParameter("yy") == null ? calView.get(Calendar.YEAR) : Integer.parseInt(request.getParameter("yy"));
 		int mm = request.getParameter("mm") == null ? calView.get(Calendar.MONTH) : Integer.parseInt(request.getParameter("mm"));
 		
 		if(mm < 0) {
 			yy--;
 			mm = 11;
 		}
 		if(mm > 11) {
 			yy++;
 			mm = 0;
 		}
 		calView.set(yy, mm, 1);
 		
 		//해당월에 1일에 해당되는 요일을 숫자로 구하고, 그 달의 마지막 일자를 구한다.(일:1, 월:2 ~~)
 		int startWeek = calView.get(Calendar.DAY_OF_WEEK);
 		int lastDay = calView.getActualMaximum(Calendar.DAY_OF_MONTH);
 		
 		int prevYear = yy; //이전년도
 		int prevMonth = mm - 1; //이전월
 		int nextYear = yy; //다음년도
 		int nextMonth = mm + 1; //다음월
 		
 		if(prevMonth == -1) {
 			prevYear--;
 			prevMonth = 11;
 		}
 		if(nextMonth == 12) {
 			nextYear++;
 			nextMonth = 0;
 		}
 		
 		//1일 이전일자 칸을 공백으로 처리
 		Calendar calPre = Calendar.getInstance();
 		calPre.set(nextYear, nextMonth, 1);
 		int preLastDay = calPre.getActualMaximum(Calendar.DAY_OF_MONTH);
 		
 		// 마지막 남는 일자칸을 공백(다음일자)
 		Calendar calNext = Calendar.getInstance();
 		calNext.set(nextYear, nextMonth, 1);
 		int nextStartWeek = calNext.get(Calendar.DAY_OF_WEEK);
 		
 		request.setAttribute("toYear", toYear);
 		request.setAttribute("toMonth", toMonth);
 		request.setAttribute("toDay", toDay);

 		request.setAttribute("yy", yy);
 		request.setAttribute("mm", mm);
 		
 		request.setAttribute("startWeek", startWeek);
 		request.setAttribute("lastDay", lastDay);
 		
 		request.setAttribute("prevYear", prevYear);
 		request.setAttribute("prevMonth", prevMonth);
 		request.setAttribute("nextYear", nextYear);
 		request.setAttribute("nextMonth", nextMonth);
 		
 		request.setAttribute("preLastDay", preLastDay);
 		request.setAttribute("nextStartWeek", nextStartWeek);
 		
 		//스케줄에 등록되어 있는 일정들을 db에서 가져오기
 		HttpSession session = request.getSession();
 		String mid = (String) session.getAttribute("sMid");
 		int level = (int) session.getAttribute("sLevel");
 		
 		String ym = "";
 		int intMM = mm + 1;
 		if(intMM >= 1 && intMM <=9) ym = yy + "-0"+ (mm + 1);
 		else ym = yy + "-" + (mm + 1);
 		
 		List<ScheduleVO> vos = scheduleDAO.getScheduleList(mid, ym, level);
 		
 		request.setAttribute("vos", vos);
	}

	@Override
	public List<ScheduleVO> getScheduleMenu(String mid, String ymd) {
		return scheduleDAO.getScheduleMenu(mid, ymd);
	}

	@Override
	public int setScheduleInputOk(ScheduleVO vo) {
		return scheduleDAO.setScheduleInputOk(vo);
	}

	@Override
	public int setScheduleDelete(int idx) {
		return scheduleDAO.setScheduleDelete(idx);
	}

	@Override
	public int setScheduleUpdate(ScheduleVO vo) {
		return scheduleDAO.setScheduleUpdate(vo);
	}
	
	
}
