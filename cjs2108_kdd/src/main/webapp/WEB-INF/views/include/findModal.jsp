<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>

 <div class="modal" id="myModal1">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">계정찾기</h4>
				<button type="button" class="close" data-dismiss="modal" onclick="vClear()">&times;</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text"> 이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;름</span>
					</div>
					<input id="userNm1" name="userNm1" type="text" class="form-control"/>
				</div>
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text">휴대폰 번호</span>
					</div>
					<input id="phoneNb1" name="phoneNb1" type="text" class="form-control"/>
				</div>
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text">이메일 주소</span>
					</div>
					<input id="email1" name="email1" type="text" class="form-control"/>
				</div>
				<div id="demo11" class="form-control"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="findUserId()" >확인</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="vClear()">Close</button>
			</div>
		</div>
	</div>
</div>

 <div class="modal" id="myModal2">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h4 class="modal-title">비밀번호 찾기</h4>
				<button type="button" class="close" data-dismiss="modal" onclick="vClear()">&times;</button>
			</div>
			<div class="modal-body">
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text"> 아&nbsp;&nbsp;&nbsp;&nbsp;이&nbsp;&nbsp;&nbsp;&nbsp;디</span>
					</div>
					<input id="userId2" name="userId2" type="text" class="form-control"/>
				</div>
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text">휴대폰 번호</span>
					</div>
					<input id="phoneNb2" name="phoneNb2" type="text" class="form-control"/>
				</div>
				<div class="input-group">
					<div class="input-group-prepend mb-3">
						<span class="input-group-text">이메일 주소</span>
					</div>
					<input id="email2" name="email2" type="text" class="form-control"/>
				</div>
				<div id="demo21" class="form-control"></div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-danger" onclick="findUserPwd()">확인</button>
				<button type="button" class="btn btn-danger" data-dismiss="modal" onclick="vClear()">Close</button>
			</div>
		</div>
	</div>
</div>

<script>
	function findUserId() {
		let data = {
			userNm : userNm1.value,
			phoneNb : phoneNb1.value,
			email : email1.value
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/finduserId",
			data : data,
			success : (mid) => {
				if (mid == "") {
					demo11.innerHTML = "찾는 아이디가 없습니다.";
				}
				else {
					demo11.innerHTML = "아이디는 <b>" + mid + "</b> 입니다.";	
				}
			}
		});
	}
	
	function findUserPwd() {
		let data = {
				userId : userId2.value,
				phoneNb : phoneNb2.value,
				email : email2.value
			}
			
			$.ajax({
				type : "post",
				url : "${ctp}/user/finduserPwd",
				data : data,
				success : (pwd) => {
					if (pwd == "1") {
						demo21.innerHTML = "이메일 작업 해야 함";
					}
					else if (pwd == "") {
						demo21.innerHTML = "일치하는 정보가 없습니다.";
					}
					else {
						demo21.innerHTML = "임시 비밀번호는 <b>" + pwd + "</b> 입니다.";	
					}
				}
			});	
	}
	
	function vClear() {
		userNm1.value = "";
		phoneNb1.value = "";
		email1.value = "";
		demo11.innerHTML = "";
		
		userId2.value = "";
		phoneNb2.value = "";
		email2.value = "";
		demo21.innerHTML = "";
	}
	
</script>