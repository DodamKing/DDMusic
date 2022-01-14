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
	<title>사용자 리뷰</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 300px; background: #222;">
				<h2 class="mt-5 mb-5">사용자 리뷰</h2>
				<table class="table table-borderless">
					<tr>
						<td colspan="3" style="font-size: 32px;">${vo.title }</td>
					</tr>
					<tr style="border-bottom: 1px solid;">
						<td>
							<c:if test="${!empty vo.profileImg }"><img style="width: 30px; border-radius: 100%;" src="${ctp }/resources/img/${vo.profileImg}"></c:if>
							<c:if test="${empty vo.profileImg }"><i class="fa-solid fa-user"></i></c:if>
							${vo.nickNm }
						</td>
						<td>${fn:substring(vo.date, 0, 10) }</td>
						<td>${vo.hostIp }</td>
						<td class="text-right">
							<c:if test="${sVO.membership == -1 || sVO.idx == vo.userIdx}"><a onclick="return confirm('정말 삭제 하시겠습니까?')" href="${ctp }/bbs/reviewdel?idx=${vo.idx}" class="btn btn-dark">삭제</a></c:if>
							<c:if test="${sVO.idx == vo.userIdx}"><a onclick="alert('빠른 시일 내로 추가 하겠습니다.')" href="" class="btn btn-dark">수정</a></c:if>
						</td>
					</tr>
				</table>
				<div class="mt-5">${vo.content }</div>
				<div class="row mt-5">
					<div class="col"></div>
					<div class="col-2"><a href="${ctp }/review" class="btn btn-dark">돌아가기</a></div>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
	</script>
	
</body>
</html>