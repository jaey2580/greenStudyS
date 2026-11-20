package com.spring.greenStudyS.service;

import java.util.List;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.greenStudyS.vo.PdsVO;

public interface PdsService {

	List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part);

	int setPdsInput(MultipartHttpServletRequest mFile, PdsVO vo);

	int setPdsDownNumCheck(int idx);

	int setPdsDeleteCheck(int idx, String fSName);

	PdsVO getPdsContent(int idx);

}
