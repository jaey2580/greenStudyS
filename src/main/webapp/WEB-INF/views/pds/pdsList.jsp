<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>pdsList.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<script>
	 'use strict';
	 
	 function downNumCheck(idx) {
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
	 
	 function partCheck() {
		 let part = $("#part").val();
		 location.href= "pdsList?pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part="+part;
	 }
	 
	 function pdsDeleteCheck(idx, fSName){
		 let ans = confirm("선택하신 자료를 삭제하시겠습니까?");
		 if(!ans) return false;
		 
		 $.ajax({
			 url : "${ctp}/pds/pdsDeleteCheck",
			 type : "post",
			 data : {
				 idx : idx,
				 fSName: fSName
			 },
			 success : (res) => {
				 if(res != '0') {
					 alert("자료가 삭제되었습니다.");
					 location.reload();
				 }
				 else alert("삭제실패");
			 },
			 error: () => {"전송오류"}
		 });
	 }
	 
	 // 닉네임을 클릭하면 모달로 정보를 출력한다.
	 function modalView(title, nickName, fDate, fName, fSName) {
		 fDate = fDate.substring(0, 10);
		 let fSNames = fSName.split("/");
		 
		 $(".modal-title").html(title);
		 $(".modal-body #nickName").html(nickName);
		 $(".modal-body #fDate").html(fDate);
		 $(".modal-body #fName").html(fName);
		 /* $(".modal-body #fSName").html(fSName); */
		
		 let str = '';
		 for (let i = 0; i < fSNames.length; i++) {
			 let imgExt = fSNames[i].substring(fSNames[i].lastIndexOf(".")+1).toLowerCase();
			 if(imgExt=='jpg' || imgExt=='gif' || imgExt=='png') {
				//$(".modal-body #imgsrc").attr("src", "${ctp}/pds/"+fSNames[i]);
			 	str += '<div><img src="${ctp}/pds/'+fSNames[i]+'" width="150px" /></div><br/>';
			 } else $(".modal-body #imgSrc").attr("src","");
		 }
		 imgDemo.innerHTML = str;
	 }
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2 class="text-center">자 료 실 리 스 트(${pageVO.part})</h2>
  <br/>
  <table class="table table-borderless m-0 p-0">
    <tr>
      <td>
        <form name="partForm">
          <select name="part" id="part" onchange="partCheck()" class="form-select w-auto">
            <option ${pageVO.part == '전체' ? 'selected' : ''}>전체</option>
            <option ${pageVO.part == '학습' ? 'selected' : ''}>학습</option>
            <option ${pageVO.part == '여행' ? 'selected' : ''}>여행</option>
            <option ${pageVO.part == '음식' ? 'selected' : ''}>음식</option>
            <option ${pageVO.part == '기타' ? 'selected' : ''}>기타</option>
          </select>
        </form>
      </td>
      <td class="text-end">
        <a href="pdsInput?part=${pageVO.part}" class="btn btn-success">자료올리기</a>
      </td>
    </tr>
  </table> 
  <table class="table table-hover text-center">
    <tr class="table-secondary">
      <th>번호</th>
      <th>자료제목</th>
      <th>올린이</th>
      <th>올린날짜</th>
      <th>분류</th>
      <th>파일명(크기)</th>
      <th>다운수</th>
      <th>비고</th>
    </tr>
    <c:set var="curScrStartNo" value="${pageVO.curScrStartNo}"/>
    <c:forEach var="vo" items="${vos}" varStatus="st">
      <tr>
        <td>${curScrStartNo}</td>
        <td>
          <a href="pdsContent?idx=${vo.idx}&pag=${pageVO.pag}&pageSize=${pageVO.pageSize}&part=${pageVO.part}">${vo.title}</a>
        	<c:if test="${vo.hour_diff <= 24}"><img src="${ctp}/images/new.gif" /></c:if>
        </td>
        <td>
          <a href="#" onclick="modalView('${vo.title}', '${vo.nickName}', '${vo.FDate}', '${vo.FName}', '${vo.FSName}')" data-bs-toggle="modal" data-bs-target="#myModal">${vo.nickName}</a>
        </td>
        <td>
          ${fn:substring(vo.FDate, 0, 10)}
        </td>
        <td>${vo.part}</td>
        <td>
			  	<c:set var="fNames" value="${fn:split(vo.FName, '/')}" />
			  	<c:set var="fSNames" value="${fn:split(vo.FSName, '/')}" />
        	<c:forEach var="fName" items="${fNames}" varStatus="st">
          	<a href="${ctp}/pds/${fSNames[st.index]}" download="${fName}" onclick="downNumCheck(${vo.idx})">${fName}</a><br/>
          </c:forEach>
        </td>
        <td>${vo.downNum}</td>
        <td>
        	<c:if test="${sMid == vo.mid || sLevel == 0}">
        		<a href="javascript:pdsDeleteCheck('${vo.idx}', '${vo.FSName}')" class="badge bg-danger">삭제</a> <!-- 앞에 따옴표가 없고 뒤에 따옴표가 있으면 자바스크립트가 에러를 발생시킴. 자바스크립트는 문자 안에 있는 숫자는 숫자로 봄. -->
        	</c:if>
      		<a href="pdsTotalDown?idx=${vo.idx}">📁</a> <!-- 앞에 따옴표가 없고 뒤에 따옴표가 있으면 자바스크립트가 에러를 발생시킴. 자바스크립트는 문자 안에 있는 숫자는 숫자로 봄. -->
        </td>
      </tr>
     <c:set var="curScrStartNo" value="${curScrStartNo-1}"/>
    </c:forEach>
  </table>
  <!-- 페이징처리(블록페이지 시작) -->
  <div class="text-center">
    <ul class="pagination justify-content-center">
      <c:if test="${pageVO.pag > 1}"><li class="page-item"><a href="pdsList?pag=1&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link text-secondary">첫페이지</a></li></c:if>
      <c:if test="${pageVO.curBlock > 0}"><li class="page-item"><a href="pdsList?pag=${(pageVO.curBlock-1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link text-secondary">이전블록</a></li></c:if>
      <c:forEach var="i" begin="${(pageVO.curBlock*pageVO.blockSize) + 1}" end="${(pageVO.curBlock*pageVO.blockSize) + pageVO.blockSize}" varStatus="st">
        <c:if test="${i <= pageVO.totPage && pageVO.pag != i}"><li class="page-item"><a href="pdsList?pag=${i}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link text-secondary">${i}</a></li></c:if>
        <c:if test="${i <= pageVO.totPage && pageVO.pag == i}"><li class="page-item"><a href="pdsList?pag=${i}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link active bg-secondary border-secondary"><b>${i}</b></a></li></c:if>
      </c:forEach>
      <c:if test="${pageVO.curBlock < pageVO.lastBlock}"><li class="page-item"><a href="pdsList?pag=${(pageVO.curBlock+1)*pageVO.blockSize + 1}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link text-secondary">다음블록</a></li></c:if>
      <c:if test="${pageVO.pag < pageVO.totPage}"><li class="page-item"><a href="pdsList?pag=${pageVO.totPage}&pageSize=${pageVO.pageSize}&part=${pageVO.part}" class="page-link text-secondary">마지막페이지</a></li></c:if>
	    </ul>
	  </div>
	  <!-- 페이징처리(블록페이지 끝) -->
	  
	  <!-- The Modal -->
		<div class="modal fade" id="myModal">
		  <div class="modal-dialog modal-dialog-centered">
		    <div class="modal-content">
		
		      <!-- Modal Header -->
		      <div class="modal-header">
		        <h4 class="modal-title">정보</h4>
		        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
		      </div>
		
		      <!-- Modal body -->
		      <div class="modal-body">
		        <div id="nickName"></div>
		        <div id="fDate"></div>
		        <div id="fName"></div>
		        <div id="imgDemo"></div>
		      </div>
		
		      <!-- Modal footer -->
		      <div class="modal-footer">
		        <button type="button" class="btn btn-danger" data-bs-dismiss="modal">닫기</button>
		      </div>
		
		  </div>
		</div>
	</div>	
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>