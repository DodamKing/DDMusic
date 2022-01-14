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
	<title>DD Music 사용자 리뷰</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    	
    	.sticky {
			position: fixed;
			top: 0px;
			right: 10px;
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
				<h2 class="mt-5 mb-5">사용자 리뷰</h2>
				<table class="table">
					<tr class="text-right">
						<td colspan="4"><button type="button" class="btn btn-dark" onclick="goWrite()">글쓰기</button></td>
					</tr>
					<tr>
						<td class="text-center">번호</td>
						<td class="text-center">제목</td>
						<td class="text-center">작성자</td>
						<td class="text-center">작성일</td>
					</tr>
					<c:set var="index" value="${fn:length(vos) }" />
					<c:forEach var="vo" items="${vos }">
						<tr>
							<td class="text-center">${index }</td>
							<td class="ho" onclick="location.href='${ctp}/review/${vo.idx }'">${vo.title }</td>
							<td class="text-center">${vo.nickNm }</td>
							<td class="text-center">${fn:substring(vo.date, 0, 10) }</td>
						</tr>
						<c:set var="index" value="${index - 1 }" />
					</c:forEach>
				</table>
				<div class="row">
					<div class="col"></div>
					<ul class="pagination col">
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review?pageNo=1">First</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review?pageNo=<c:if test="${pageNo != 1 }">${pageNo - 1 }</c:if><c:if test="${pageNo == 1 }">1</c:if> ">Previous</a></li>
					    <li class="page-item"><a class="page-link bg-secondary text-danger">${pageNo }</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review?pageNo=<c:if test="${pageNo + 1 > lastPageNo }">${pageNo }</c:if><c:if test="${pageNo + 1 <= lastPageNo }">${pageNo + 1}</c:if>">Next</a></li>
					    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/review?pageNo=${lastPageNo }">Last</a></li>
		 	 		</ul>
		 	 		<div class="col"></div>
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
		function goWrite() {
			if (${sVO == null}) {
				if (confirm("로그인이 필요합니다. \n로그인 페이지로 이동 하시겠습니까?")) {
					location.href="${ctp}/user/login?flag=write"
				}
				return;
			}
			location.href="${ctp}/write"
		}
	</script>
	
</body>
</html>