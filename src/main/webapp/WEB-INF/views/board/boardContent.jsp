<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
	<jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <title>boardContent.jsp</title>
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script>
    'use strict';
    
    $(function() {
	    $(".replyInnerContent").hide();
	    $(".replyCloseBtn").hide();
    });
    
    function deleteCheck() {
    	let ans = confirm("현재 자료를 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	location.href = 'boardDelete?idx=${vo.idx}';
    }
    
    // 좋아요수 증가처리(중복허용)
 /*  
    function goodCheck() {
    	$.ajax({
    		url  : "boardGoodCheck",
    		type : "post",
    		data : {idx : ${vo.idx}},
    		success: () => {
    			$("#boardContent").load(location.href + ' #boardContent');
    		},
    		error : () => alert("전송오류!!!")
    	});
    }
     */
    
    // 좋아요수/싫어요수 자동 증가처리
    let sw = -1;
    function goodCheckOk() {
    	if(sw == -1) sw = 1;
    	else sw = -1;
    	
    	$.ajax({
    		url  : "boardGoodCheck",
    		type : "post",
    		data : {
    			idx : ${vo.idx},
    			sw : sw
    		},
    		success: (res) => {
    			$("#boardContent").load(location.href + ' #boardContent');
    		},
    		error : () => alert("전송오류!!!")
    	});
    }
    
    // 댓글달기
    function replyCheck() {
    	let content = $("#content").val();
    	if(content.trim() == "") {
    		alert("댓글을 입력하세요");
    		return false;
    	}
    	let query = {
    			boardIdx : ${vo.idx},
    			mid : '${sMid}',
    			nickName : '${sNickName}',
    			hostIp : '${pageContext.request.remoteAddr}',
	    		content : content
    	}
    	
    	$.ajax({
    		url  : "${ctp}/board/boardReplyInput",
    		type : "post",
    		data : query,
    		success: (res) => {
    			if(res != '0') {
    				alert("댓글이 입력되었습니다.");
    				location.reload();
    			}
    			else alert('댓글 입력 실패');
    		},
    		error : () => alert("전송오류~")
    	});
    }
    
    // 댓글 삭제
    function replyDelete(idx) {
    	let ans = confirm("선택한 댓글을 삭제하시겠습니까?");
    	if(!ans) return false;
    	
    	$.ajax({
    		url  : 'boardReplyDelete.bo',
    		type : 'post',
    		data : {idx : idx},
    		success: (res) => {
    			if(res != '0') {
    				alert("댓글이 삭제 되었습니다.");
    				location.reload();
    			}
    			else alert("삭제 실패~~");
    		},
    		error : () => alert("전송오류")
    	});
    }
    
    // 댓글 수정 동적폼 보여주기
    function replyUpdate(idx) {
    	$(".replyInnerContent").hide();
    	$("#demo"+idx).show();
    }
    
    // 댓글 수정 처리
    function replyUpdateOk(idx) {
    	let content = $("#replyUpdateContent"+idx).val();
    	
    	$.ajax({
    		url  : 'boardReplyUpdateOk.bo',
    		type : 'post',
    		data : {
    			idx : idx,
    			content : content
    		},
    		success: (res) => {
    			if(res != '0') {
    				alert("댓글이 수정 되었습니다.");
    				location.reload();
    			}
    			else alert("수정 실패~~");
    		},
    		error : () => alert("전송오류")
    	});
    }
    
    // 대댓글 입력버튼 클릭시 입력박스 보여주기 
    function replyShow(idx) {
    	$("#replyShowBtn"+idx).hide();
    	$("#replyCloseBtn"+idx).show();
    	$("#replyDemo"+idx).show();
    	$(".replyDemo").hide();
    }
    
    // 대댓글 닫기버튼 클릭시 처리내용 
    function replyClose(idx) {
    	$("#replyShowBtn"+idx).show();
    	$("#replyCloseBtn"+idx).hide();
    	$("#replyDemo"+idx).hide();
    }
    
    // 대댓글 입력버튼 클릭시 대댓글의 내용처리
    function replyCheckRe(idx, re_step, re_order) {
    	let content = $("#contentRe"+idx).val();
    	if(content.trim() == "") {
    		alert("답변을 작성하세요.");
    		$("#contentRe"+idx).focus();
    		return false;
    	}
    	
    	let query = {
    		boardIdx	: ${vo.idx},
    		re_step	: re_step,
    		re_order : re_order,
    		mid : '${sMid}',
    		nickName : '${sNickName}',
    		hostIp : '${pageContext.request.remoteAddr}',
    		content : content
    	}
    	
    	$.ajax({
    		url : "${ctp}/board/boardReplyInputRe",
    		type : "post",
    		data : query,
    		success : (res) => {
    			if(res != '0') {
    				alert("답글이 정상적으로 입력되었습니다.");
    				location.reload();
    			} else alert("입력오류");
    		},
    		error : () => alert("전송오류")
    	});
    	
    }
  </script>
  <style>
    th {
      background-color: #eee !important;
      text-align: center;
    }
    .body-content p{
    	margin-bottom: 0;
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center mb-4">글 내 용 보 기</h2>
  <table class="table table-bordered">
    <tr>
      <th>글쓴이</th>
      <td>${vo.nickName}</td>
      <th>글쓴날짜</th>
      <td>${fn:substring(vo.WDate, 0, 16)}</td>
    </tr>
    <tr>
      <th>글조회수</th>
      <td>${vo.readNum}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>글제목</th>
      <td colspan="3">
        ${vo.title} 
        (
          <%-- <a href="javascript:goodCheck()" title="좋아요수 증가">👍</a> : ${vo.good} / --%>
          <span  id="boardContent"><a href="javascript:goodCheckOk()" title="좋아요" >❤️</a> : ${vo.good}</span>
        )
      </td>
    </tr>
    <tr>
      <th>글내용</th>
      <td colspan="3" style="height:220px" class="body-content">${vo.content}</td>
    </tr>
  </table>
  <div class="row text-center">
    <c:if test="${sMid == vo.mid || sLevel == 0}">
    	<div class="col">
    	  <c:if test="${sMid == vo.mid}"><a href="boardUpdate?idx=${vo.idx}" class="btn btn-info">수정</a></c:if>
    	  <a href="javascript:deleteCheck()" class="btn btn-danger">삭제</a>
    	</div>
    </c:if>
    <div class="col">
      <c:if test="${empty flag}"><a href="boardList?pag=${pag}&pageSize=${pageSize}" class="btn btn-warning">돌아가기</a></c:if>
      <c:if test="${flag == 'S'}"><a href="boardSearchList?search=${search}&searchString=${searchString}" class="btn btn-warning">돌아가기</a></c:if>
    </div>
    <br/><br/>
    <hr/>
    <!-- 이전글/다음글 시작 -->
    <table class="table table-borderless">
      <tr>
        <td class="text-start">
          <c:if test="${!empty nextVO.title}">
          	👆 : <a href="boardContent?idx=${nextVO.idx}&pag=${pag}&pageSize=${pageSize}">${nextVO.title}</a><br/>
          </c:if>
          <c:if test="${!empty preVO.title}">
          	👇 : <a href="boardContent?idx=${preVO.idx}&pag=${pag}&pageSize=${pageSize}">${preVO.title}</a><br/>
          </c:if>
        </td>
      </tr>
    </table>
    <!-- 이전글/다음글 끝 -->
  </div>
</div>
  
<!-- 댓글처리(리스트/입력) 시작 -->
<div class="container">
  <!-- 댓글 리스트 보여주기 -->
  <table class="table table-hover text-center">
    <tr class="table-secondary">
      <th>작성자</th>
      <th class="text-start ms-5"> &nbsp; &nbsp; &nbsp; 댓글내용</th>
      <th>댓글일자</th>
      <th>접속IP</th>
      <th>답글</th>
    </tr>
    <c:forEach var="replyVo" items="${replyVos}" varStatus="st">
      <tr>
        <td class="text-start">
        	<c:if test="${replyVo.re_step >= 1}">
        		<c:forEach var="i" begin="1" end="${replyVo.re_step}">&nbsp;</c:forEach>
          </c:if>
	          ${replyVo.nickName}
	          	<c:if test="${sMid == replyVo.mid || sLevel == 0}">
		          (
		          <c:if test="${sMid == replyVo.mid}"><a href="javascript:replyUpdate(${replyVo.idx})" title="댓글수정">✓</a>,</c:if>
		          <a href="javascript:replyDelete(${replyVo.idx})" title="댓글삭제" class="text-danger">x</a>
		          )
	          </c:if>
        </td>
        <td class="text-start">${fn:replace(replyVo.content, newLine, "<br/>")}</td>
        <td>${fn:substring(replyVo.WDate,0,16)}</td>
        <td>${replyVo.hostIp}</td>
        <td>
        	<a href="javascript:replyShow(${replyVo.idx})" id="replyShowBtn${replyVo.idx}" class="badge bg-success">답글</a>
        	<a href="javascript:replyClose(${replyVo.idx})" id="replyCloseBtn${replyVo.idx}" class="badge bg-warning replyCloseBtn">닫기</a>
        </td>
      </tr>
      <%-- <tr id="demo${replyVo.idx}" style="display:none"> --%>
      <tr id="demo${replyVo.idx}" class="replyInnerContent">
        <td colspan="4" class="text-center p-2">
          <form>
            <div class="input-group">
	            <textarea rows="4" name="replyUpdateContent" id="replyUpdateContent${replyVo.idx}" class="form-control">${replyVo.content}</textarea>
	            <input type="button" value="댓글수정" onclick="replyUpdateOk(${replyVo.idx})" class="btn btn-secondary btn-sm" />
	          </div>
          </form>
        </td>
      </tr>
      <tr>
        <td colspan="5" class="m-0 p-0 text-center">
        	<div id="replyDemo${replyVo.idx}" style="display: none" class="">
        		<table class="table table-center">
        			<tr class="ms-4">
        				<td style="85%">답글내용
        					<textarea rows="4" name="contentRe" id="contentRe${replyVo.idx}" class="form-control">@${replyVo.nickName} </textarea>
        				</td>
        				<td><br/>
        					<p>작성자 : ${sNickName}</p>
        					<input type="button" value="답글달기" onclick="replyCheckRe(${replyVo.idx},${replyVo.re_step},${replyVo.re_order})" class="btn btn-secondary"/>
        				</td>
        			</tr>
        		</table>
        	</div>
        </td>
      </tr>
    </c:forEach>
  </table>
  <hr/>
  <!-- 댓글 입력창 -->
  <form name="replyForm">
    <table class="table table-borderless text-center">
      <tr class="text-end">
        <td>작성자 : ${sNickName}</td>
      </tr>
      <tr>
        <td class="text-start m-0 p-0">
          <div class="input-group">
            <textarea rows="4" name="content" id="content" class="form-control" placeholder="댓글을 입력하세요"></textarea>
            <input type="button" value="댓글달기" onclick="replyCheck()" class="btn btn-secondary btn-sm" />
          </div>
        </td>
      </tr>
    </table>
  </form>
</div>
<!-- 댓글처리(리스트/입력) 끝 -->
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>