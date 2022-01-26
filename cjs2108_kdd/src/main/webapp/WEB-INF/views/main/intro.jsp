<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>DD Music 서비스 소개</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 300px;">
				<h2 class="mt-5 mb-5">서비스 소개</h2>
				<div>
					<p style="font-size: 24px;"><span style="font-size: 32px;"><b>2022년 1월 14일</b></span> 서비스를 시작 합니다.</p>
					<p style="font-size: 20px;">드디어 차트 로직 수정했습니다!!! <font color="blue;">기다려 주셔서 감사합니다.</font> 이제 빠르게 확인 하 실 수 있습니다.</p>
					<p>계정 설정에서 썸네일 추가 하실 수 있습니다.</p>
					<p>음악은 1분 미리 듣기만 가능하며, My 맴버십에서 맴버십 변경시 전체 듣기 가능합니다.</p>
					<p>사용자 리뷰에 글쓰기 가능합니다.</p>
					<p>서버 데이터가 삭제 되었습니다. 썸네일 이미지 올리셨던 분들은 다시 올려 주세요 죄송합니다. (01.19)</p>
				</div>
				<div>
					<a href="${ctp }/comming" class="btn btn-dark">업데이트 확인 바로가기</a>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
</body>
</html>