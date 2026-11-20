package com.spring.greenStudyS.service;

import java.util.List;

import com.spring.greenStudyS.vo.BoardReplyVO;
import com.spring.greenStudyS.vo.BoardVO;

public interface BoardService {

	List<BoardVO> getBoardList(int startIndexNo, int pageSize);

	int setBoardInput(BoardVO vo);

	BoardVO getBoardContent(int idx);

	void imageCheck(String content);

	int setBoardDelete(int idx);

	void imageDelete(String content);

	int setBoardUpdate(BoardVO vo);

	void setReadNumPlus(int idx);

	void setBoardGoodCheck(int idx, int sw);

	BoardVO getPreNextSearch(int idx, String str);

	BoardReplyVO getBoardParentReplyCheck(int boardIdx);

	int setBoardReplyInput(BoardReplyVO replyVO);

	List<BoardReplyVO> getBoardReply(int idx);

	void setReplyOrderUpdate(int boardIdx, int re_order);



}
