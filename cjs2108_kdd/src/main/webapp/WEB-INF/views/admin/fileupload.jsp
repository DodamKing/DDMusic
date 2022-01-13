<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>file</title>
</head>
<body>
	<div class="container mt-5 ml-5">
		<h2>음원파일</h2>
		<div class="sticky">
			<ul class="pagination">
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=3&pageNo=1">First</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=3&pageNo=<c:if test="${pageNo != 1 }">${pageNo - 1 }</c:if><c:if test="${pageNo == 1 }">1</c:if> ">Previous</a></li>
			    <li class="page-item"><a class="page-link bg-secondary text-danger">${pageNo }</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=3&pageNo=<c:if test="${pageNo + 1 > lastPageNo }">${pageNo }</c:if><c:if test="${pageNo + 1 <= lastPageNo }">${pageNo + 1}</c:if>">Next</a></li>
			    <li class="page-item"><a class="page-link bg-dark text-warning" href="${ctp }/admin/main?sw=3&pageNo=${lastPageNo }">Last</a></li>
 	 		</ul>
		</div>
		<div class="mt-5">
			<audio id="player" src="" controls="controls"></audio>
			<table class="table text-center">
				<tr>
					<th>#</th>
					<th>제목</th>
					<th>가수</th>
					<th></th>
					<th>
						<button class="btn btn-warning" type="button" onclick="$('#fup').click()">파일 선택</button>
						<button class="btn btn-warning" type="button" onclick="play2()">미리 듣기</button>
					</th>
				</tr>
				<c:forEach var="vo" items="${vos}">
					<tr>
						<td>${vo.idx }</td>
						<td title="${vo.title }">
							<c:if test="${fn:length(vo.title) >= 20 }">${fn:substring(vo.title, 0, 20) }...</c:if>
							<c:if test="${fn:length(vo.title) < 20 }">${vo.title }</c:if>
						</td>
						<td>${vo.artist }</td>
						<td>
							<c:if test="${vo.isFile == 0}">음원 파일 없음</c:if>
						</td>
						<td>
							<button class="btn btn-warning" type="button" onclick="play1(`${vo.title}`, `${vo.artist }`)">재생</button>
							<button class="btn btn-warning" type="button" onclick="fileupload(${vo.idx})">파일 업로드</button>
							<input type="file" id="fup" style="display: none;">
						</td>
					</tr>
				</c:forEach>
			</table>
		</div>
	</div>
</body>
</html>