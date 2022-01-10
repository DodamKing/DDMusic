<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>userupdate</title>
</head>
<body>
	<div class="container mt-5 ml-5">
		<h2>회원관리</h2>
		<div class="mt-5">
			<table class="table text-center">
				<tr>
					<th>번호</th>
					<th>아이디</th>
					<th>이름</th>
					<th>별명</th>
					<th>이메일</th>
					<th>멤버십</th>
					<th>탈퇴신청</th>
				</tr>
				<c:set var="cnt" value="${fn:length(vos) }" />
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${cnt }</td>
						<td>${vo.userId }</td>
						<td>${vo.userNm }</td>
						<td>${vo.nickNm }</td>
						<td>${vo.email }</td>
						<td>
							<c:if test="${vo.membership == -1 }">관리자</c:if>
							<c:if test="${vo.membership == 0 }">없음</c:if>
							<c:if test="${vo.membership == 1 }">DDMusic 무제한 듣기</c:if>
						</td>
						<td>
							<c:if test="${vo.withdrawal == 0 }"></c:if>
							<c:if test="${vo.withdrawal == 1 }"><div class="ho" onclick="userdel(${vo.idx})">탈퇴</div></c:if>
						</td>
					</tr>
					<c:set var="cnt" value="${cnt -1 }" />
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>