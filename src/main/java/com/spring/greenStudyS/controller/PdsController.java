package com.spring.greenStudyS.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.greenStudyS.common.PageVO;
import com.spring.greenStudyS.common.PagiNation;
import com.spring.greenStudyS.service.PdsService;
import com.spring.greenStudyS.vo.PdsVO;

@Controller
@RequestMapping("/pds")
public class PdsController {
	
	@Autowired
	PdsService pdsService;
	
	@Autowired
	PagiNation pagiNation;
	
	@GetMapping("/pdsList")
	public String pdsListGet(PageVO pageVO, Model model, 
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part
		) {
		pageVO.setPart(part);
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("pds");
		pageVO = pagiNation.getTotRecCnt(pageVO);
		
		List<PdsVO> vos = pdsService.getPdsList(pageVO.getStartIndexNo(), pageSize, part);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		return "pds/pdsList";
	}
	
	@GetMapping("/pdsInput")
	public String pdsInputGet() {
		return "pds/pdsInput";
	}
	
	@PostMapping("/pdsInput")
	public String pdsInputPost(MultipartHttpServletRequest mFile , PdsVO vo) {
		int res = pdsService.setPdsInput(mFile, vo);
		
  	if(res != 0)	return "redirect:/message/pdsInputOk";
  	else	return "redirect:/message/pdsInputNo";
	}
	
	@ResponseBody
	@PostMapping("/pdsDownNumCheck")
	public String pdsDownNumCheckPost(int idx) {
		return pdsService.setPdsDownNumCheck(idx) + "";
	}
	
	@ResponseBody
	@PostMapping("/pdsDeleteCheck")
	public String pdsDeleteCheckPost(int idx, String fSName) {
		return pdsService.setPdsDeleteCheck(idx, fSName) + "";
	}
	
	@GetMapping("/pdsContent")
	public String pdsContentGet(Model model, int idx,
			@RequestParam(name="pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name="pageSize", defaultValue = "5", required = false) int pageSize,
			@RequestParam(name="part", defaultValue = "전체", required = false) String part
		) {
		PdsVO vo = pdsService.getPdsContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		model.addAttribute("part", part);
		
		return "pds/pdsContent";
	}
	
	@SuppressWarnings("deprecation")
	@GetMapping("/pdsTotalDown")
	public String pdsContentGet(HttpServletRequest request , int idx) throws IOException {
		//다운로드 수 증가
		pdsService.setPdsDownNumCheck(idx);
		
		//여러개의 파일을 하나의 파일(zip)로 압축(통합)하여 다운로드 시켜준다. 압축파일의 제목은 '제목.zip'으로 처리한다.
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/pds/");
		
		PdsVO vo = pdsService.getPdsContent(idx);
		
		String[] fNames = vo.getFName().split("/");
		String[] fSNames = vo.getFSName().split("/");
		
		String zipPath = realPath + "temp/";
		String zipName = vo.getTitle() + ".zip";
		
		FileInputStream fis = null;
		FileOutputStream fos = null;
		
		ZipOutputStream zout = new ZipOutputStream(new FileOutputStream(zipPath + zipName));
		
		byte[] bytes = new byte[2048];
		
		for(int i=0; i<fNames.length; i++) {
			fis = new FileInputStream(realPath+fSNames[i]);
			fos = new FileOutputStream(zipPath+fNames[i]);
			
			File copyFile = new File(zipPath + fNames[i]);
			
			while((fis.read(bytes, 0, bytes.length)) != -1)	{
				fos.write(bytes);
			}
			fos.flush();
			fos.close();
			fis.close();
			
			//temp 폴더에 존재하는 파일을 zip 파일에 담아준다.
			fis = new FileInputStream(copyFile);
			zout.putNextEntry(new ZipEntry(fNames[i]));
			while((fis.read(bytes, 0, bytes.length)) != -1) {
				zout.write(bytes);
			}
			zout.flush();
			zout.closeEntry();
			fis.close();
		}
		zout.close();
		
		return "redirect:/fileDownAction?path=pds&file=" + java.net.URLEncoder.encode(zipName);
	}
	
}
