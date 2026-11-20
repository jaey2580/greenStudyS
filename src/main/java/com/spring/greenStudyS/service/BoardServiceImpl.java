package com.spring.greenStudyS.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.dao.BoardDAO;
import com.spring.greenStudyS.vo.BoardReplyVO;
import com.spring.greenStudyS.vo.BoardVO;

@Service
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	ProjectProvide projectProvide;


	@Override
	public List<BoardVO> getBoardList(int startIndexNo, int pageSize) {
		return boardDAO.getBoardList(startIndexNo, pageSize);
	}

	@Override
	public int setBoardInput(BoardVO vo) {
		return boardDAO.setBoardInput(vo);
	}

	@Override
	public BoardVO getBoardContent(int idx) {
		return boardDAO.getBoardContent(idx);
	}

	@Override
	public void imageCheck(String content) {
		//        012345678901234567890123456789
		//<p><img src="/greenStudyS/ckImage/261116164349_12.jpg"
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/");
		
		int position = 26;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		boolean sw = true;
		
		while(sw) {
			String imgfile = nextImg.substring(0 , nextImg.indexOf("\""));
			String originFilePath = realPath + "ckImage/" + imgfile;
			String copyFilePath = realPath + "board/" + imgfile;
			
			fileCopyCheck(originFilePath, copyFilePath);
			
			if(nextImg.indexOf("src=\"/") == -1) sw = false;
			else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
			
		}
	}
	
	//파일복사 처리
	private void fileCopyCheck(String originFilePath, String copyFilePath) {
		try {
			FileInputStream fis = new FileInputStream(new File(originFilePath));
			FileOutputStream fos = new FileOutputStream(new File(copyFilePath));
			
			byte[] bytes = new byte[2048];
			
			while(fis.read(bytes) != -1) {
				fos.write(bytes);
			}
			fos.flush(); //찌꺼기 청소
			fos.close();
			fis.close();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@Override
	public int setBoardDelete(int idx) {
		return boardDAO.setBoardDelete(idx);
	}

	@Override
	public void imageDelete(String content) {
		//        012345678901234567890123456789
		//<p><img src="/greenStudyS/board/261116164349_12.jpg"
		//<p><img src="/greenStudyS/ckImage/261116164349_12.jpg"
		
		int position = 24;
		String nextImg = content.substring(content.indexOf("src=\"/")+position);
		System.out.println("nextImg: " + nextImg);
		boolean sw = true;
		
		while(sw) {
		String imgfile = nextImg.substring(0 , nextImg.indexOf("\""));
		System.out.println("imgfile:" + imgfile);
		projectProvide.deleteFile(imgfile, "board");
		
		if(nextImg.indexOf("src=\"/") == -1) sw = false;
		else nextImg = nextImg.substring(nextImg.indexOf("src=\"/")+position);
		}
	}

	@Override
	public int setBoardUpdate(BoardVO vo) {
		return boardDAO.setBoardUpdate(vo);
	}

	@Override
	public void setReadNumPlus(int idx) {
		boardDAO.setReadNumPlus(idx);
	}

	@Override
	public void setBoardGoodCheck(int idx, int sw) {
		boardDAO.setBoardGoodCheck(idx, sw);
	}

	@Override
	public BoardVO getPreNextSearch(int idx, String str) {
		return boardDAO.getPreNextSearch(idx, str);
	}

	@Override
	public BoardReplyVO getBoardParentReplyCheck(int boardIdx) {
		return boardDAO.getBoardParentReplyCheck(boardIdx);
	}

	@Override
	public int setBoardReplyInput(BoardReplyVO replyVO) {
		return boardDAO.setBoardReplyInput(replyVO);
	}

	@Override
	public List<BoardReplyVO> getBoardReply(int idx) {
		return boardDAO.getBoardReply(idx);
	}

	@Override
	public void setReplyOrderUpdate(int boardIdx, int re_order) {
		boardDAO.setReplyOrderUpdate(boardIdx, re_order);
	}


	
}
