<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<% pageContext.setAttribute("newLine", "\n"); %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsContent.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
  <script>
  	'use strict';
  	
  	// 처음 접속시는 '리뷰보이기' 처리하기 위해 '리뷰보이기' 버튼을 가림
  	$(function(){
  		$("#reviewShowBtn").hide();
  		$("#reviewHideBtn").show();
  		$("#reviewBox").show();
  	});
		
  	// 리뷰보이기 버튼 클릭시 수행
  	function reviewShow(){
  		$("#reviewShowBtn").hide();
  		$("#reviewHideBtn").show();
  		$("#reviewBox").show();
  	};
		
  	// 리뷰가리기 버튼 클릭시 수행
  	function reviewHide(){
  		$("#reviewShowBtn").show();
  		$("#reviewHideBtn").hide();
  		$("#reviewBox").hide();
  	};
  	
  	function downNumCheck(idx){
  		 $.ajax({
  			 url : "${ctp}/pds/pdsDownNumCheck",
  			 type: "post",
  			 data : {idx : idx},
  			 success : () => {
  				 location.reload();
  			 },
  			 error : () => alert("전송오류")
  		 });
  	}
  	
  	// 별점/ 리뷰 평가 사항 등록하기
  	function reviewCheck() {
  		let star = starForm.star.value;
  		let review = $("#review").val();
  		
  		if(star == "") {
  			alert("별점을 등록해주세요");
  			return false;
  		}
  		
  		let query = {
					part : 'pds',
					partIdx : ${vo.idx},
					mid : '${sMid}',
					nickName : '${sNickName}',
					star : star,
					content : review
  		}
  		
  		$.ajax({
  			url : '${ctp}/review/reviewInput',
  			type : 'post',
  			data : query,
  			success : (res) => {
  				if(res != 0) {
  					alert("리뷰가 등록되었습니다."),
  					location.reload(); 
  				}
  				else alert("리뷰 등록 실패");
  			},
  			error : () => alert("전송오류") 
  		});
  		
  	}
  	
  	//리뷰댓글 달기 폼 보여주기
    function reviewReply(idx, nickName, content) {
    	$("#reviewIdx").val(idx);
    	$("#reviewReplyNickName").text(nickName);
    	$("#reviewReplyContent").html(content);
    }
  	
  	//리뷰 댓글 등록하기
  	function reviewReplyCheck() {
  		let replyContent = $("#replyContent").val();
  		let reviewIdx = $("#reviewIdx").val();
  		
  		if(replyContent.trim() == "" ) {
  			alert("리뷰 댓글을 입력하세요");
  			return false;
  		}
  		
  		let query = {
  				reviewIdx : reviewIdx,
  				replyMid : '${sMid}',
  				replyNickName : '${sNickName}',
  				replyContent : replyContent
  		}
  		
  		$.ajax({
  			url : '${ctp}/review/reviewReplyInputOk',
  			type : 'post',
  			data : query,
  			success : (res) => {
  				if(res != 0) {
  					alert("댓글이 등록되었습니다.");
  					location.reload();
  				}	
  				else alert("댓글 등록 실패")
  			},
  			error : () => alert("전송오류")
  			
  		});
  	}
  	
  	// 리뷰댓글 삭제하기
  	function reviewReplyDelete(replyIdx) {
  		let ans = confirm("댓글을 삭제하시겠습니까?");
  		if(!ans) return false;
  		
  		$.ajax({
  			url: "${ctp}/review/reviewReplyDelete",
  			type: "post",
  			data : {replyIdx : replyIdx},
  			success : (res) => {
  				if(res != 0) {
  					alert("삭제 성공")
  					location.reload();
  				}
  				else alert("삭제 실패")
  			},
  			error : () => alert("전송에러")
  		});
  		
  	}
  </script>
  <style>
  	th {
  		text-align: center;
  		background-color: #eee !important;
  	}
  	
    #starForm fieldset {
      direction: rtl; /* 진행방향을 반대로 바꾸겠다 */
    }
    /* 라디오 버튼(○)은 화면에 보이지 않게 숨긴다. 대신 별 모양(label)을 클릭해서 라디오 버튼이 선택되도록 하는 방식이다. */
    #starForm input[type=radio] {
      display: none;
    }
    /* 1:별 크기, 2:실제 글자색(별)은 투명하게 설정, 3:그림자를 이용해 연한 회색 별(기본 상태)을 표시 */
    #starForm label {
      font-size: 1.6em;
      color: transparent;
      text-shadow: 0 0 0 #f0f0f0;
    }
    /* 마우스를 별 하나에 올리면, 그 별은 노란색(rgba(250, 200, 0, 0.98))으로 바뀐다. */
    #starForm label:hover {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    /* ~는 CSS의 일반 형제 선택자이다. 현재 hover된 label 앞에 있는 형제 label들도 같이 노란색으로 바뀌게 합니다. */
    #starForm label:hover ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
    /* 라디오 버튼이 선택된 상태(checked)이면, 해당 별과 그 앞의 별들이 노란색으로 유지됩니다. 즉, 사용자가 별점을 클릭하면 선택한 개수만큼 별이 노란색으로 고정 */
    #starForm input[type=radio]:checked ~ label {
      text-shadow: 0 0 0 rgba(250, 200, 0, 0.98);
    }
  </style>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>자료 내용 상세보기</h2>
  <br/>
  <table class="table table-bordered text-center">
    <tr>
      <th>올린이</th>
      <td>${vo.nickName}</td>
      <th>올린날짜</th>
      <td>${fn:substring(vo.FDate,0,fn:length(vo.FDate)-2)}</td>
    </tr>
    <tr>
      <th>파일명</th>
      <td>
        <c:set var="fNames" value="${fn:split(vo.FName,'/')}"/>
        <c:set var="fSNames" value="${fn:split(vo.FSName,'/')}"/>
        <c:forEach var="fName" items="${fNames}" varStatus="st">
          <a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
        </c:forEach>
        (<fmt:formatNumber value="${vo.FSize/1024}" pattern="#,##0" />KByte)
      </td>
      <th>다운횟수</th>
      <td>${vo.downNum}</td>
    </tr>
     <tr>
      <th>분류</th>
      <td>${vo.part}</td>
      <th>접속IP</th>
      <td>${vo.hostIp}</td>
    </tr>
    <tr>
      <th>제목</th>
      <td colspan="3" class="text-start">${vo.title}</td>
    </tr>
    <tr>
      <th>상세내역</th>
      <td colspan="3" class="text-start" style="height:150px">${fn:replace(vo.content,newLine,'<br/>')}</td>
    </tr>
    <tr>
      <td colspan="4">
        <input type="button" value="돌아가기" onclick="location.href='pdsList?pag=${pag}&pageSize=${pageSize}&part=${part}';" class="btn btn-primary"/>
      </td>
    </tr>
  </table>
  <hr class="border-dark boarder-1" />
  <!-- 리뷰(평점) 작성하기 -->
  <div>
  	<form name="starForm" id="starForm">
  		<fieldset style="border:0px">
  			<div class="text-start m-0 p-0">
  				<input type="radio" name="star" id="star1" value="5" /><label for="star1">★</label>
  				<input type="radio" name="star" id="star2" value="4" /><label for="star2">★</label>
  				<input type="radio" name="star" id="star3" value="3" /><label for="star3">★</label>
  				<input type="radio" name="star" id="star4" value="2" /><label for="star4">★</label>
  				<input type="radio" name="star" id="star5" value="1" /><label for="star5">★</label>
  				: 별점을 선택해주세요 ■
  			</div>
  		</fieldset>
  		<div class="input-group m-0 p-0">
  			<textarea rows="3" name="review" id="review" class="form-control" placeholder="별점·후기를 작성해주시면 10포인트를 드립니다."></textarea>
  			<input type="button" value="별점/리뷰등록" onclick="reviewCheck()" class="btn btn-primary" /> 
  		</div>
  	</form>
  </div>
	<div class="row mt-3">
		<div class="col">
			<input type="button" value="리뷰보이기" id="reviewShowBtn" onclick="reviewShow()" class="btn btn-success" />
			<input type="button" value="리뷰가리기" id="reviewHideBtn" onclick="reviewHide()" class="btn btn-warning" />
		</div>
	</div>
  <hr class="border-dark boarder-1" />
 	<div class="text-end">
 		<b>평균 평점 : <fmt:formatNumber value="${reviewAvg}" pattern="0.0" /></b>
 	</div>
	<div id="reviewBox">
	  <hr class="border-dark boarder-1" />
		<c:set var="imsiIdx" value="0" />
		<c:forEach var="vo" items="${reviewVos}" varStatus="st">
			<c:if test="${imsiIdx != vo.idx}">
			  <hr class="border-dark boarder-1" />
				<div class="row">
					<div class="col"> 닉네임 : ${vo.nickName} | ${fn:substring(vo.RDate, 0, 16)}
						<c:if test="${sMid == vo.mid || sLevel == 0}">
							<a href="" class="badge bg-danger" title="리뷰 삭제">X</a>
						</c:if>
							<a href="#" onclick="reviewReply('${vo.idx}','${vo.nickName}','${fn:replace(vo.content,newLine,'<br/>')}')" title="댓글달기" data-bs-toggle="modal" data-bs-target="#reviewModal" class="badge bg-secondary">▤</a>
							<%-- <a href="#" onclick="reviewReply('${vo.idx}', '${vo.nickName}','${vo.content}')" class="badge bg-success" data-bs-toggle="modal" data-bs-target="#myModal" title="댓글달기">댓글</a> --%>
					</div>
					<div class="col-auto">	별점 : <c:forEach var="i" begin="1" end="${vo.star}"><font color="gold">★</font></c:forEach></div>
				</div>
				<div class="row">
					<div class="col">	${fn:replace(vo.content,newLine,'<br/>')}</div>
				</div>
			</c:if>
			<hr class="border-dark" />
			<!-- 다음 리뷰글과의 비교를 위해서 현재글의 idx를 imsiIdx에 기억시켜둔다. -->
			<c:set var="imsiIdx" value="${vo.idx}" />
			<!-- 현재 리뷰글의 댓글이 존재한다면 댓글을 출력시켜준다. -->
			<c:if test="${!empty vo.replyContent}">
				<div class="d-flex text-secondary">
				<div>└─</div>
					<div class="ms-2">${vo.replyNickName}</div>
					<div class="ms-2">${fn:substring(vo.replyDate, 0, 19)}
					<c:if test="${vo.replyMid == sMid || sLevel == 0}"> 
						<a href="javascript:reviewReplyDelete(${vo.replyIdx})" class="text-danger" title="댓글 삭제">X</a>
					</c:if> 
					<br/>${fn:replace(vo.replyContent,newLine,'<br/>')}</div>				
				</div>			
			</c:if>
		</c:forEach>
	</div>  
  <hr class="border-dark boarder-1" />
  <!-- 자료실에 등록된 자료가 사진자료라면, 아래쪽으로 이미지 보여주기 -->
  <div class="text-center">
		<c:forEach  var="fSName" items="${fSNames}" varStatus="st">
			${fSNames[st.index]}<br/>
			<c:set var="len" value="${fn:length(fSName)}" />
			<c:set var="ext" value="${fn:substring(fSName, len-3, len)}" />
			<c:set var="extLower" value="${fn:toLowerCase(ext)}" />
			<c:if test="${extLower == 'jpg' || extLower == 'png' || extLower == 'gif'}">
				<img src="${ctp}/pds/${fSName}" width="30%"	><br/>		
			</c:if>
		</c:forEach>  
  </div>
</div>
<!-- The Modal -->
<div class="modal fade" id="reviewModal">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">>> 리뷰에 댓글달기</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <form name="reviewReplyForm" id="reviewReplyForm" class="was-vilidated">
            <table class="table table-bordered">
              <tr>
                <th style="width:25%">원본글작성자</th>
              <td style="width:75%"><span id="reviewReplyNickName"></span></td>
            </tr>
            <tr>
              <th>원본글</th>
              <td><span id="reviewReplyContent"></span></td>
            </tr>
          </table>
          <hr/>
          댓글 작성자 : ${sNickName}<br/>
          댓글 내용 : <textarea rows="3" name="replyContent" id="replyContent" class="form-control" required></textarea><br/>
          <input type="button" value="리뷰댓글등록" onclick="reviewReplyCheck()" class="btn btn-success form-control"/>
          <input type="hidden" name="reviewIdx" id="reviewIdx"/>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>