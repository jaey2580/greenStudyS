package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.ScheduleVO;

public interface ScheduleDAO {

	List<ScheduleVO> getScheduleList(@Param("mid") String mid, @Param("ym") String ym, @Param("level") int level);

	List<ScheduleVO> getScheduleMenu(@Param("mid") String mid, @Param("ymd") String ymd);

	int setScheduleInputOk(@Param("vo") ScheduleVO vo);

	int setScheduleDelete(@Param("idx") int idx);

	int setScheduleUpdate(@Param("vo") ScheduleVO vo);



}
