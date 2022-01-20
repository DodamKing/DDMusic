<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />

<style>
	#addSongModal {
		color: white;
	}
</style>

<div class="modal" id="addSonglist">
	<div class="modal-dialog modal-dialog-scrollable">
  		<div class="modal-content" style="background: #444;">
      
	        <!-- Modal Header -->
	        <div class="container mt-3">
	        	<h2>새 플레이리스트 추가</h2>
	        </div>
      		<div class="modal-header">
      			공개설정
	        </div>
	        
	        <!-- Modal body -->
	        <div class="modal-body">
		        <div class="form-group">
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="listNm" class="form-control" type="text" placeholder="title1"></div>
		        </div>
		        <div class="form-group">
		          	<div id="modal_c" class="mt-3" style="color: gray;"><input id="comment" class="form-control" type="text" placeholder="플레이리스트 설명을 입력해 주세요."></div>
		        </div>
		        <div class="text-danger ho" onclick="alert('구현중')">
		        	<div class="btn btn-danger btn-sm"><i title="새로운 곡 추가" class="fas fa-plus"></i></div>
		        	<span class="ml-2">새로운 곡 추가</span>
	        	</div>
	        	<div class="mt-3">
	        		<div>
	        			<i class="fa-solid fa-magnifying-glass"></i> 검색기를 넣고
	        		</div>
		        	<div class="form-group">
		        		<div>여기에 표시해주고</div>
		        		<input type="hidden" id="content">
		        	</div>
	        	</div>
	        </div>
	        
	        <!-- Modal footer -->
	        <div class="modal-footer">
	      		<button type="button" class="btn btn-danger" onclick="saveList()">저장</button>
	      		<button type="button" class="btn btn-danger" onclick="goClose()">Close</button>
	      		<button id="close_btn" type="button" class="btn btn-danger" data-dismiss="modal" style="display: none;">Close</button>
	        </div>
        
  		</div>
	</div>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script>
	function goClose() {
		if (confirm("변경사항을 저장하지 않고 편집을 종료합니다. 정말 나가시겠어요?")) {
			$("#close_btn").click();
		}
	}

	function saveList() {
		if (listNm.value == "") {
			alert("플레이 리스트 제목을 입력하세요.");
			return;
		}
		
		let data = {
			userIdx : ${sVO.idx},
			listNm : listNm.value,
			comment : comment.value,
			content : content.value
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/savelist",
			data : data,
			success : () => {
				location.reload();
			}
		});
	}
	
	$("#close_btn").click(() => {
		listNm.value = "";
		comment.value = "";
	});
</script>