<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="${pageContext.request.contextPath}"/>
<% pageContext.setAttribute("newLine", "\n"); %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>scheduleMenu.jsp</title>
  <jsp:include page="/WEB-INF/views/include/bs5.jsp" />
  <link rel="stylesheet" type="text/css" href="${ctp}/css/linkOrange.css"/>
	<script>
		'use strict';
		
		$(function() {
			$("#scheduleInputViewBtn").click(function(){
			$("#scheduleInputView").toggle();
			});
		});
		
		// 일정등록을 동적폼을 이용하여 출력
		function scheduleInputView() {
			let str = '<hr class="border"><div id="scheduleForm"><form name="scheduleForm2">';
			str += '<table class="table table-bordered">';
			str += '<tr>';
			str += '<th style="width:25%">분류</th>';
			str += '<td style="width:75%">';
			str += '<select name="part" id="part" class="form-select w-auto">';
			str += '<option>모임</option>';
			str += '<option>업무</option>';
			str += '<option>학습</option>';
			str += '<option>여행</option>';
			str += '<c:if test="${sLevel == 0}"><option>공지사항</option></c:if>';
			str += '<option>기타</option>';
			str += '</select>';
			str += '</td>';
			str += '</tr>';
			str += '<tr>';
			str += '<th>내용</th>';
			str += '<td>';
			str += '<textarea name="content" id="content" rows="4" class="form-control" placeholder="일정을 등록하세요." required></textarea>';
			str += '</td>';
			str += '</tr>';
			str += '<tr>';
			str += '<td colspan="2" class="text-center" >';
			str += '<input type="button" value="일정등록" onclick="scheduleInput()" class="btn btn-success form-control"/>';
			str += '</td>';
			str += '</tr>';
			str += '</table>';
			str += '</form></div>';
			
			$("#scheduleInputView").html(str);
						
		}
		
		//일정등록하기(ajax 처리)
		function scheduleInput() {
			let content = scheduleForm2.content.value;
			if(content.trim() == "") {
				alert("내용을 입력하세요.");
				return false;
			}
			
			let query = {
					mid : '${sMid}',
					sDate : '${ymd}',
					part : scheduleForm2.part.value,
					content : content
			}
			
			$.ajax({
				url : '${ctp}/schedule/scheduleInputOk',
				type : 'post',
				data : query,
				success : (res) => {
					if(res != 0) {
						alert("일정이 등록되었습니다.");
						location.reload();
					}					
					else alert("일정 등록 실패");
				},
				error : () => alert("전송오류")
			});
		}
		
		function scheduleDelete(idx) {
			let ans = confirm("정말로 삭제하시겠습니까?");
			if(!ans) return false;
			
			$.ajax({
				url : '${ctp}/schedule/scheduleDelete',
				type : 'post',
				data : {idx : idx},
				success : (res) => {
					if(res != 0) {
						alert("일정이 삭제되었습니다.");
						location.reload();
					}
				},
				error : () => alert("전송오류")
			});
		}
		
		$(function() {
			$("#myModalUpdate").on("show.bs.modal", function(e){ /* on : 이벤트 감지/ show.bs.modal : 모달이 열리기 직전 이벤트 */
				let obj = e.relatedTarget; /*relatedTarget : 모달을 열게 한 수정 버튼 / 모달을 열게 한 HTML 요소(수정 버튼)를 obj에 저장  */
				
				$("#updateIdx").val($(obj).attr("data-idx")); /* 속성값을 가져오기 */
				$("#updatePart").val($(obj).attr("data-part"));
				$("#updateContent").val($(obj).attr("data-content"));
			});
			
		});
		
		function scheduleUpdateOk() {
			let query = {
					idx : scheduleUpdateFrom.idx.value,
					mid : '${sMid}',
					sDate : scheduleUpdateFrom.sDate.value,
					part : scheduleUpdateFrom.part.value,
					content : scheduleUpdateFrom.content.value
			} 
			
			$.ajax({
				url : '${ctp}/schedule/scheduleUpdateOk',
				type : 'post',
				data : query,
				success : (res) => {
					if(res != 0) {
						alert("일정이 수정되었습니다.");
						location.reload();
					}
					else alert("수정실패");
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
  <h4>${ymd} 일정입니다.</h4>
  <p>오늘의 일정은 총 ${scheduleCnt}건이 있습니다.</p>
  <hr/>
  <div>
		<input type="button" value="일정등록(동적폼)"	 onclick="scheduleInputView()" id="scheduleInputViewBtn" class="btn btn-light" />  
  	<a href="#" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#myModalInput">일정등록(모달)</a>
		<input type="button" value="돌아가기" onclick="location.href='schedule?yy=${fn:split(ymd,'-')[0]}&mm=${fn:split(ymd,'-')[1]-1}'" class="btn btn-dark"/>  
  </div>
  <div id="scheduleInputView"></div>
	
	<c:if test="${scheduleCnt != 0}">
		<div id="scheduleList" class="mt-3">
			<table class="table table-hover text-center">
				<tr class="table-secondary">
					<th>번호</th>
					<th>분류</th>
					<th>간단 내역</th>
					<th>비고</th>
				</tr>
				<c:forEach var="vo" items="${vos}" varStatus="st">
					<tr>
						<td>${st.count}</td>
						<td>${vo.part}</td>
						<td>${fn:substring(vo.content, 0, 20)}</td>
						<td>
							<a href="#" data-bs-toggle="modal" data-bs-target="#myModalUpdate" data-idx="${vo.idx}" data-part="${vo.part}" data-content="<c:out value='${vo.content}'></c:out>" class="badge bg-warning">수정</a>
							<a href="javascript:scheduleDelete(${vo.idx})" class="badge bg-danger">삭제</a>
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</c:if>
</div>

<!-- The Modal -->
<div class="modal fade" id="myModalInput">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">▶일정 등록</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <form name="scheduleForm1" id="scheduleForm1" class="was-vilidated">
            <table class="table table-bordered">
              <tr>
                <th style="width:25%">분류</th>
              	<td style="width:75%">
              		<select name="part" id="part" class="form-select w-auto">
              			<option>모임</option>
              			<option>업무</option>
              			<option>학습</option>
              			<option>여행</option>
              			<c:if test="${sLevel == 0}"><option>공지사항</option></c:if>
              			<option>기타</option>
              		</select>
	             	</td>
            </tr>
            <tr>
              <th>내용</th>
              <td>
              	<textarea name="content" rows="4" class="form-control" placeholder="일정을 등록하세요." required></textarea>
              </td>
            </tr>
            <tr>
            	<td colspan="2" class="text-center" >
			          <input type="button" value="일정등록" onclick="scheduleInput()" class="btn btn-success form-control"/>
            	</td>
            </tr>
          </table>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
      </div>
    </div>
  </div>
</div>

<!-- 모달 수정 -->
<div class="modal fade" id="myModalUpdate">
    <div class="modal-dialog modal-dialog-centered">
      <div class="modal-content">
        <div class="modal-header">
          <h4 class="modal-title">▶일정 수정</h4>
          <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
        </div>
        <div class="modal-body">
          <form name="scheduleUpdateFrom" id="scheduleUpdateFrom" class="was-vilidated">
	            <table class="table table-bordered">
	              <tr>
	              	<th>날짜</th>
	              	<td>
	              		<input type="date" name="sDate" id="sDate" value="${ymd}" class="form-control"/>
	              	</td>
	              </tr>
	              <tr>
	                <th style="width:25%">분류</th>
	              	<td style="width:75%">
	              		<select name="part" id="updatePart" class="form-select w-auto">
	              			<option>모임</option>
	              			<option>업무</option>
	              			<option>학습</option>
	              			<option>여행</option>
	              			<c:if test="${sLevel == 0}"><option>공지사항</option></c:if>
	              			<option>기타</option>
	              		</select>
		             	</td>
	            </tr>
	            <tr>
	              <th>내용</th>
	              <td>
	              	<textarea name="content" id="updateContent" rows="4" class="form-control" placeholder="일정을 등록하세요." required></textarea>
	              </td>
	            </tr>
	            <tr>
	            	<td colspan="2" class="text-center" >
				          <input type="hidden" id="updateIdx" name="idx" />
				          <input type="button" value="수정" onclick="scheduleUpdateOk()" class="btn btn-success form-control"/>
	            	</td>
	            </tr>
	          </table>
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