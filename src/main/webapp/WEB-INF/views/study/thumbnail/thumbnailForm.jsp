<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>thumbnailForm.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <script>
  	'use strict';
  	
  	function fCheck(){
  		let file = $("#file").val();
  		let ext = file.substring(file.lastIndexOf(".")+1).toLowerCase();
  		let maxSize = 1024 * 1024 * 20;
  		
  		if(file.trim() == "") {
  			alert("업로드할 파일을 선택하세요.");
  			return false;
  		}
  		
  		let fileSize = document.getElementById("file").files[0].size;
  		if(ext != 'jpg' && ext != 'gif' && ext != 'png') {
  			alert("그림파일만 업로드 가능합니다(jpg/gif/png)")
  			return false;
  		}
  		if(fileSize > maxSize) {
  			alert("업로드할 파일의 최대 용량은 20MByte 입니다.");
  			return false;
  		}
  		
  		// ajax를 이용한 파일 처리
  		let formData = new FormData();
  		formData.append("file", document.getElementById("file").files[0]);
  		
  		$.ajax({
  			url : '${ctp}/study/thumbnailForm',
				type : 'post',
				data : formData,
				processData : false,
				contentType : false,
				success : (res) => {
					if(res != "") {
						alert("썸네일이 생성되었습니다." + res);
						let str = '<p>썸네일 이미지 : <br/><img src="${ctp}/thumbnail/s_'+res+'" /></p>';
						str += '<p>원본 이미지 : <br/><img src="${ctp}/thumbnail/'+res+'" /></p>';
						$("#demo").html(str);
					}					
					else alert("썸네일 생성 실패");
				},
				error : () => alert("전송오류")
  		});
  		
  	}
  </script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/nav.jsp" />
<jsp:include page="/WEB-INF/views/include/slide2.jsp" />
<p><br/></p>
<div class="container">
  <h2>썸네일 연습</h2>
  <form name="myform" method="post" enctype="multpart/form-data">
  	<div class="input-group">
  		<input type="file" name="file" id="file" class="form-control" accept=".jpg,.gif,.png" />
	  	<input type="button" value="썸네일만들기" onclick="fCheck()" class="btn btn-success" />
	  	<input type="reset" value="다시선택" class="btn btn-warning" />
	  	<input type="button" value="썸네일리스트" onclick="location.href='thumbnailList'" class="btn btn-success" />
  	</div>
  </form>
  <br/>
  <div id="demo"></div>
</div>
<p><br/></p>
<jsp:include page="/WEB-INF/views/include/footer.jsp" />
</body>
</html>