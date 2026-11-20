package com.spring.greenStudyS.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.greenStudyS.vo.BoardReplyVO;
import com.spring.greenStudyS.vo.BoardVO;

public interface BoardDAO {

	int getTotRecCnt();

	List<BoardVO> getBoardList(@Param("startIndexNo") int startIndexNo, @Param("pageSize")int pageSize);

	int setBoardInput(@Param("vo") BoardVO vo);

	BoardVO getBoardContent(@Param("idx") int idx);

	int setBoardDelete(@Param("idx") int idx);

	int setBoardUpdate(@Param("vo") BoardVO vo);

	void setReadNumPlus(@Param("idx") int idx);

	void setBoardGoodCheck(@Param("idx") int idx, @Param("sw") int sw);

	BoardVO getPreNextSearch(@Param("idx") int idx,@Param("str") String str);

	BoardReplyVO getBoardParentReplyCheck(@Param("boardIdx") int boardIdx);

	int setBoardReplyInput(@Param("replyVO") BoardReplyVO replyVO);

	List<BoardReplyVO> getBoardReply(@Param("idx") int idx);

	void setReplyOrderUpdate(@Param("boardIdx") int boardIdx, @Param("re_order") int re_order);


}
