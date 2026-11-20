package com.spring.greenStudyS.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.greenStudyS.common.PageVO;
import com.spring.greenStudyS.common.PagiNation;
import com.spring.greenStudyS.common.ProjectProvide;
import com.spring.greenStudyS.service.BoardService;
import com.spring.greenStudyS.vo.BoardReplyVO;
import com.spring.greenStudyS.vo.BoardVO;
import com.spring.greenStudyS.vo.GuestVO;
import com.spring.greenStudyS.vo.User2VO;

//@Slf4j
@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	BoardService boardService; 
	
	@Autowired
	PagiNation pagiNation;
		
	@Autowired
	ProjectProvide projectProvide;
	
	@GetMapping("/boardList")
	public String boardListGet(Model model, PageVO pageVO,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize
		) {
		pageVO.setPag(pag);
		pageVO.setPageSize(pageSize);
		pageVO.setSection("board");
		pageVO = pagiNation.getTotRecCnt(pageVO);
		
		List<BoardVO> vos = boardService.getBoardList(pageVO.getStartIndexNo(), pageSize);
		
		model.addAttribute("vos", vos);
		model.addAttribute("pageVO", pageVO);
		
		return "board/boardList";
	}
	
	@GetMapping("/boardInput")
	public String boardInputGet() {
		return "board/boardInput";
	}
	
	@PostMapping("/boardInput")
	public String boardInputPost(BoardVO vo) {
		// 1. 글을 DB에 올리기 전에, 글안에 이미지가 포함되어 있는지를 판별하기
		// 이미지가 있다면 저장된 이미지만 골라서 (ckeditor폴더) board폴더로 복사처리(/ckImage 폴더에서 /board폴더로 파일들 복사)
		if(vo.getContent().indexOf("src=\"/") != -1) {
			boardService.imageCheck(vo.getContent());
		};
		
		// 2. 이미지 작업을 완료했다면, DB안의 ckImage폴더경로를 board폴더 경로로 변경한다. 
		vo.setContent(vo.getContent().replace("/ckImage", "/board"));
		
		// 3. 2번 작업을 마치면 작업처리된 내용들을 모두 vo에 담아서 DB에 저장처리한다.
		int res = boardService.setBoardInput(vo);
		
		if(res != 0) return "redirect:/message/boardInputOk";
		else return "redirect:/message/boardInputNo";
	}
	
	@SuppressWarnings("unchecked")
	@GetMapping("/boardContent")
	public String boardContentGet(Model model, PageVO pageVO, 
			HttpSession session,
			@RequestParam(name = "pag", defaultValue = "1", required = false) int pag,
			@RequestParam(name = "pageSize", defaultValue = "10", required = false) int pageSize,
			int idx
		) {
		
		//조회수 증가처리(중복불허)
		List<String> contentReadNum  = (List<String>) session.getAttribute("sContentIdx");
		if(contentReadNum == null) contentReadNum = new ArrayList<String>();
		String imsiContentReadNum = "board" + idx;
		if(!contentReadNum .contains(imsiContentReadNum)) {
			boardService.setReadNumPlus(idx);
			contentReadNum.add(imsiContentReadNum);
		}
		session.setAttribute("sContentIdx", contentReadNum);
		
		// 이전글/다음글 처리
		BoardVO preVO = boardService.getPreNextSearch(idx,"preVO");
		BoardVO nextVO = boardService.getPreNextSearch(idx,"nextVO");
		model.addAttribute("preVO",preVO);
		model.addAttribute("nextVO",nextVO);
		
		BoardVO vo = boardService.getBoardContent(idx);

		model.addAttribute("vo", vo);
		model.addAttribute("pag", pag);
		model.addAttribute("pageSize", pageSize);
		
		// 댓글(대댓글) 추가 입력처리
		List<BoardReplyVO> replyVos = boardService.getBoardReply(idx);
		model.addAttribute("replyVos", replyVos);
		return "board/boardContent";
	}
	
	@ResponseBody
	@PostMapping("/boardGoodCheck")
	public void boardGoodCheckPost(int idx, int sw) {
		boardService.setBoardGoodCheck(idx, sw);
	}
	
	@GetMapping("/boardDelete")
	public String boardDeleteGet(int idx) {
		// 1. 내용물에 사진이 있을경우에만 사진 삭제 처리한다.
		BoardVO vo = boardService.getBoardContent(idx);
		if(vo.getContent().indexOf("src=\"/") != -1) boardService.imageDelete(vo.getContent());
		
		// 2. 사진작업이 끝나면 DB에 저장된 실제 정보를 삭제시킨다.
		int res = boardService.setBoardDelete(idx);
		
		if(res != 0) return "redirect:/message/boardDeleteOk";
		else return "redirect:/message/boardDeleteNo?idx="+idx;
	}
	
	@GetMapping("/boardUpdate")
	public String boardUpdateGet(int idx, Model model) {
		BoardVO vo = boardService.getBoardContent(idx);
		model.addAttribute("vo",vo);
		return "board/boardUpdate";
	}
	
	@PostMapping("/boardUpdate")
	public String boardUpdatePost(int idx, Model model, BoardVO vo) {
		BoardVO oldVO = boardService.getBoardContent(idx);
		String oldContent = oldVO.getContent();
		System.out.println("oldContent: "+oldContent);
		int res = 0;
		// 기존 사진과 새로운 사진 모두 비워둘때
		if(vo.getContent().indexOf("src=\"/") == -1) {
			System.out.println("첫번쨰 조건");
			res = boardService.setBoardUpdate(vo);
		}
		//기존 사진을 그대로 유지할때
		else if(vo.getContent().equals(oldContent)) {
			boardService.imageCheck(oldContent);
			vo.setContent(vo.getContent().replace("/ckImage", "/board"));
			res = boardService.setBoardUpdate(vo);
			System.out.println("두번쨰 조건");
		}
		// 기존 사진을 삭제하고 새로운 사진을 등록할때 
		else if(vo.getContent().indexOf("src=\"/") != -1) {
			//기존 사진을 삭제하기
			if((oldContent.indexOf("/board") != -1)) {
				boardService.imageDelete(oldContent);
			}	
			// 새로운 사진 등록하기
				boardService.imageCheck(vo.getContent());
				vo.setContent(vo.getContent().replace("/ckImage", "/board"));
			
				res = boardService.setBoardUpdate(vo);
				System.out.println("세번쨰 조건");
		}
		
		if(res != 0) return "redirect:/message/boardboardUpdateOk?idx="+idx;
		else return "redirect:/message/boardboardUpdateNo?idx="+idx;
	}
	
	@ResponseBody
	@PostMapping("/boardReplyInput")
	public String boardReplyInputPost(BoardReplyVO replyVO) {
		BoardReplyVO replyParentVO = boardService.getBoardParentReplyCheck(replyVO.getBoardIdx());
		
		if(replyParentVO == null) {
			replyVO.setRe_order(1);
		}
		else {
			replyVO.setRe_order((replyParentVO.getRe_order()+1))         ;
		}
		replyVO.setRe_step(0);
		
		int res = boardService.setBoardReplyInput(replyVO);
		
		return res+"";
	}
	
	@ResponseBody
	@PostMapping("/boardReplyInputRe")
	public String boardReplyInputRePost(BoardReplyVO replyVO) {
		replyVO.setRe_step(replyVO.getRe_step() +1); // 부모 step + 1
		boardService.setReplyOrderUpdate(replyVO.getBoardIdx(), replyVO.getRe_order()); //부모보다 큰 re_order 자료들은 모두 +1 시킨다.
		replyVO.setRe_order(replyVO.getRe_order() + 1); //부모의 re_order + 1
		
		int res = boardService.setBoardReplyInput(replyVO);
		
		return res+"";
	}
	
	
}
