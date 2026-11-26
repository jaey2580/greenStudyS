package com.spring.greenStudyS.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.greenStudyS.common.PagiNation;
import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.service.AdminService;
import com.spring.greenStudyS.service.GuestService;
import com.spring.greenStudyS.service.MemberService;
import com.spring.greenStudyS.service.ScheduleService;
import com.spring.greenStudyS.vo.ScheduleVO;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

	@Autowired
	ScheduleService scheduleService;

	@GetMapping("/schedule")
	public String scheduleGet(HttpServletRequest request) {
		scheduleService.getSchedule(request);
		
		return "schedule/schedule";
	}
	
	@GetMapping("/scheduleMenu")
	public String scheduleMenuGet(Model model, String ymd, String mid) {
		String mm = "", dd = "";
		String[] ymds = ymd.split("-"); //=> ymd => 2027-1-6
		if(ymd.length() != 10) {
			if(ymds[1].length() == 1) mm = "0" + ymds[1];
			else mm = ymds[1];

			if(ymds[2].length() == 1) dd = "0" + ymds[2];
			else dd = ymds[2];
			
			ymd = ymds[0] + "-" + mm + "-" + dd; //ymd => 2027-01-06
		}
		
		List<ScheduleVO> vos = scheduleService.getScheduleMenu(mid, ymd);
		
		model.addAttribute("vos", vos);
		model.addAttribute("ymd", ymd);
		model.addAttribute("scheduleCnt", vos.size());
		
		return "schedule/scheduleMenu";
	}
	
	@ResponseBody
	@PostMapping("/scheduleInputOk")
	public int scheduleInputOkPost(ScheduleVO vo) {
		return scheduleService.setScheduleInputOk(vo);
	}
	
	@ResponseBody
	@PostMapping("/scheduleDelete")
	public int scheduleDeletePost(int idx) {
		return scheduleService.setScheduleDelete(idx);
	}
	
	@ResponseBody
	@PostMapping("/scheduleUpdateOk")
	public int scheduleUpdatePost(ScheduleVO vo) {
		return scheduleService.setScheduleUpdate(vo);
	}
	
	
	
	
}

