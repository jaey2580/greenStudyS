package com.spring.greenStudyS.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.dao.PdsDAO;
import com.spring.greenStudyS.vo.PdsVO;
import com.spring.greenStudyS.vo.ReviewVO;

@Service
public class PdsServiceImpl implements PdsService {
	
	@Autowired
	PdsDAO pdsDAO;
	
	@Autowired
	ProjectProvide projectProvide;

	@Override
	public List<PdsVO> getPdsList(int startIndexNo, int pageSize, String part) {
		return pdsDAO.getPdsList(startIndexNo, pageSize, part);
	}

	@Override
	public int setPdsInput(MultipartHttpServletRequest mFile, PdsVO vo) {
		List<MultipartFile> fileList = mFile.getFiles("file");
		
		String oFileNames = "";
		String sFileNames = "";
		int fileSize = 0;
		
		for(MultipartFile file : fileList) {
			String oFileName = file.getOriginalFilename();
			String extName = oFileName.substring(oFileName.lastIndexOf("."));
			String tempfile = oFileName.substring(0, oFileName.lastIndexOf("."))+ "_";
			String sFileName = tempfile + UUID.randomUUID().toString().substring(0, 8) + extName;

			projectProvide.writeFile(file, sFileName, "pds");
			
			oFileNames += oFileName + "/";
			sFileNames += sFileName + "/";
			fileSize += file.getSize();
		}
		oFileNames = oFileNames.substring(0, oFileNames.length()-1);
		sFileNames = sFileNames.substring(0, sFileNames.length()-1);
		
		vo.setFName(oFileNames);
		vo.setFSName(sFileNames);
		vo.setFSize(fileSize);
		
		return pdsDAO.setPdsInput(vo);
	}

	@Override
	public int setPdsDownNumCheck(int idx) {
		return pdsDAO.setPdsDownNumCheck(idx);
	}

	@Override
	public int setPdsDeleteCheck(int idx, String fSName) {
		String[] fSNames = fSName.split("/");
		for(String f : fSNames) {
			projectProvide.deleteFile(f, "pds");
		}
		
		return pdsDAO.setPdsDeleteCheck(idx);
	}

	@Override
	public PdsVO getPdsContent(int idx) {
		return pdsDAO.getPdsContent(idx);
	}

	@Override
	public List<ReviewVO> getReviewList(int idx, String part) {
		return pdsDAO.getReviewList(idx, part);
	}

	@Override
	public double getReviewTotal(int idx, String part) {
		return pdsDAO.getReviewTotal(idx, part);
	}

}
