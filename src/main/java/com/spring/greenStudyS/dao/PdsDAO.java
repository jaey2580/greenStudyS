package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.PdsVO;
import com.spring.greenStudyS.vo.ReviewVO;

public interface PdsDAO {

	int getTotRecCnt(@Param("part") String part);

	List<PdsVO> getPdsList(@Param("startIndexNo") int startIndexNo, @Param("pageSize") int pageSize, @Param("part") String part);

	int setPdsInput(@Param("vo") PdsVO vo);

	int setPdsDownNumCheck(@Param("idx") int idx);

	int setPdsDeleteCheck(@Param("idx") int idx);

	PdsVO getPdsContent(@Param("idx") int idx);

	List<ReviewVO> getReviewList(@Param("idx") int idx, @Param("part") String part);

	double getReviewTotal(@Param("idx") int idx, @Param("part") String part);


}
