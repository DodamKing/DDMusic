<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>My Information Update</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    	div.input-group-prepend > span {
    		width: 150px;
    		font-weight: 900;
    	}
    </style>
</head>
<body>
	<c:if test="${sVO == null }"><script>location.href="${ctp}/today"</script></c:if>
	<jsp:include page="/WEB-INF/views/include/title.jsp" />
	<div class="container p-5">
		<h2 class="mb-5">DD Music 프로필 수정</h2>
		<form action="">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">프로필사진</span>
				</div>
				<div>
				<c:if test="${!empty vo.profileImg}">
					<div><img src="${ctp }/resources/img/${vo.profileImg}" /></div>
				</c:if>
					<input type="button" value="사진변경" >
					<input type="button" value="삭제" >
				</div>
			</div>
		</form>
		<form method="post" name="form">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">아이디</span>
				</div>
				<span class="form-control input-group-text">${vo.userId }</span>
				<input name="userId" type="hidden" value="${vo.userId }">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">이메일 주소</span>
				</div>
				<input class="form-control" id="email" name="email" type="text" value="${vo.email }">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">통신사</span>
				</div>
				<select class="form-control" id="telecom" name="telecom">
					<option value="">선택</option>
					<option value="SKT" <c:if test="${vo.telecom == 'SKT' }">selected</c:if> >SKT</option>
					<option value="KT" <c:if test="${vo.telecom == 'KT' }">selected</c:if>>KT</option>
					<option value="LGU+" <c:if test="${vo.telecom == 'LGU+' }">selected</c:if>>LGU+</option>
					<option value="알뜰폰" <c:if test="${vo.telecom == '알뜰폰' }">selected</c:if>>알뜰폰</option>
				</select>
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">휴대폰 번호</span>
				</div>
				<input class="form-control" id="phoneNb" name="phoneNb" type="text" value="${vo.phoneNb }">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">이름</span>
				</div>
				<input class="form-control" id="userNm" name="userNm" type="text" value="${vo.userNm }">
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">별명</span>
				</div>
				<input class="form-control" id="nickNm" name="nickNm" type="text" value="${vo.nickNm }">
			</div>
			<div class="text-right">
				<div class="btn-group mt-5 text-right">
					<input type="button" value="적용" class="btn btn-warning" onclick="smit()" />
					<input type="button" value="돌아가기" class="btn btn-warning" onclick="location.href='${ctp}/user/profile/${vo.idx }'" />
				</div>
			</div>
		</form>
	</div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
		var idPattern = /[^a-zA-Z0-9]$/;
		var emailPattern = /^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/;
		var phonePattern = /01[016789][1-9][0-9]{3}\d{4}$/;
		var namePattern = /[^가-힣]/;
		var nickPattern = /[^가-힣a-zA-Z1-9]/;
    
    	function smit() {
			if (confirm('변경 사항을 적용 할까요?')) {
				if ($("#email").val() == "") {
					alert("이메일 주소를 입력하세요.");
					$("#email").focus();
					return
				}
				
				if ($("#telecom").val() == "") {
					alert("통신사를 선택하세요.");
					return
				}
					
				if ($("#phoneNb").val() == "") {
					alert("휴대폰 번호를 입력하세요.");
					$("#phoneNb").focus();
					return
				}
					
				if ($("#userNm").val() == "") {
					alert("이름을 입력하세요.");
					$("#userNm").focus();
					return
				}
					
				if ($("#nickNm").val() == "") {
					alert("별명을 입력하세요.");
					$("#nickNm").focus();
					return
				}
				
				if (!emailPattern.test(email.value)) {
			        alert("이메일 형식을 지켜 주세요.");
			        $("#email").focus();
			        return;
				}
				
				if (!phonePattern.test(phoneNb.value)) {
			        alert("휴대폰 번호를 확인해 주세요 (-) 없이 숫자만 입력해야 합니다.");
			        $("#phoneNb").focus();
			        return;
				}
				
				if (namePattern.test(userNm.value)) {
			        alert("이름은 한글만 가능합니다.");
			        $("#userNm").focus();
			        return;
				}
				
				form.submit();
			}
		}
    </script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>