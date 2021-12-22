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
	<title>비밀번호 변경</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
     <style>
    	div.input-group-prepend {
    		width: 150px;
    	}
    	
    	span.input-group-text {
    		width: 150px;
    	}
    </style>
</head>
<body>
	<c:if test="${sVO == null }"><script>location.href="${ctp}/today"</script></c:if>
	<jsp:include page="/WEB-INF/views/include/title.jsp" />
	<div class="container p-5">
		<h2 class="text-center mb-5">비밀번호 변경</h2>
		<form method="post" name="form">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">기존 비밀번호</span>
				</div>
				<input class="form-control" id="pwd1" name="pwd1" type="password" >
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">변경할 비밀번호</span>
				</div>
				<input class="form-control" id="pwd2" name="pwd2" type="password" >
			</div>
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">비밀번호 확인</span>
				</div>
				<input class="form-control" id="pwd3" name="pwd3" type="password" >
			</div>
			<div class="text-right">
				<div class="btn-group mt-5 text-right">
					<input type="button" value="비밀번호 변경" class="btn btn-warning" onclick="smit()" />
					<input type="button" value="돌아가기" class="btn btn-warning" onclick="location.href='${ctp}/user/profile/${idx}'" />
				</div>
			</div>
		</form>
	</div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	function smit() {
			if (confirm('변경 사항을 적용 할까요?')) {
				if (pwd1.value == "" || pwd2.value == "" || pwd3.value == "") {
					alert("입력란을 확인 하세요.");
					return;
				}
				
				if (pwd2.value != pwd3.value) {
					alert("변경할 비밀번호가 일치하시 않습니다.");
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