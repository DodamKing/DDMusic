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
    	
    	.profileImg {
    		width: 150px;
    		height: 150px;
    		overflow: hidden;
    		border-radius: 100%;
    	}
    </style>
</head>
<body>
	<c:if test="${sVO == null }"><script>location.href="${ctp}/today"</script></c:if>
	<jsp:include page="/WEB-INF/views/include/title.jsp" />
	<div class="container p-5">
		<h2 class="mb-5">DD Music 프로필 수정</h2>
		<form method="post" name="form">
			<div class="input-group mb-3">
				<div class="input-group-prepend">
					<span class="input-group-text bg-warning">프로필사진</span>
				</div>
				<div class="ml-5">
					<c:if test="${empty vo.profileImg}">
						<div class="profileImg"><img id="thum" style="width: 100%; height: 100%;" src="${ctp }/resources/img/noimage.jpg" /></div>
					</c:if>
					<c:if test="${!empty vo.profileImg}">
						<div class="profileImg"><img id="thum" style="width: 100%; height: 100%;" src="${ctp }/resources/img/${vo.profileImg}" /></div>
					</c:if>
					<div class="mt-3">
						<input class="btn btn-dark" type="file" id="imgUpdate" name="img" value="사진변경" >
						<input class="btn btn-dark" type="button" value="삭제" onclick="imgDelete()" >
					</div>
				</div>
			</div>
			<div class="btn-group mt-5 text-right">
				<input type="button" value="적용" class="btn btn-warning" onclick="smit()" />
				<input type="button" value="돌아가기" class="btn btn-warning" onclick="cancle()" />
			</div>
		</form>
	</div>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script>
    	let origin = $("#thum").attr("src");
    
		$("#imgUpdate").change((e) => {
			let reader = new FileReader();
			reader.readAsDataURL(e.target.files[0]);
			
			reader.onload = (e) => {
				$("#thum").attr("src", e.target.result);
			}
		})
    	
    	function imgDelete() {
			$("#imgUpdate").val("");
			$("#thum").attr("src", "${ctp}/resources/img/noimage.jpg");
		}
		
		function smit() {
			if (confirm("변경 사항을 적용 할까요?")) {
				form.submit();
			}
		}
		
		function cancle() {
			if (origin != $("#thum").attr("src")) {
				if (confirm("변경 사항이 저장 하지 않고 돌아가시겠습니까?")) {
					location.href="${ctp}/user/profile/${vo.idx }";
				}
				return;
			}
			location.href="${ctp}/user/profile/${vo.idx }";
		}
    	
    </script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>