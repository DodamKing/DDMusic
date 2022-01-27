<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>dbupload</title>
</head>
<body>
	<div class="container mt-5 ml-5">
		<h2>업데이트</h2>
		<div class="mt-5">
			<c:set var="ok" value="0" />
			<P class="h4">업데이트 필요한 곡</p>
				<table class="table">
						<tr>
							<td><div type="button" class="btn btn-outline-warning" title="현재 시각 차트로 업데이트 합니다" onclick="chartUpdate()">차트 업데이트</div></td>
							<td><button class="btn btn-warning" type="button" title="아래 내용 모두를 데이터베이스에 추가 합니다" onclick="addall()">모두 추가</button></td>
						</tr>
					<c:forEach var="vo" items="${vos }" varStatus="st">
						<c:if test="${vo.songIdx == 0 }">
							<tr>
								<td>
									<c:if test="${fn:length(vo.title) < 20 }">${vo.title }</c:if> 
									<c:if test="${fn:length(vo.title) >= 20 }">${fn:substring(vo.title, 0, 20) }...</c:if> 
									- 
									<c:if test="${fn:length(vo.artist) < 20 }">${vo.artist }</c:if> 
									<c:if test="${fn:length(vo.artist) >= 20 }">${fn:substring(vo.artist, 0, 20) }...</c:if> 
								</td>
								<td>
									<button class="btn btn-warning" type="button" onclick="adddb('${vo.img}', `${vo.title }`, `${vo.artist }`)">디비에 추가</button>
								</td>
								<c:set var="ok" value="${ok + 1 }" />
							</tr>
						</c:if>
					</c:forEach>
				</table>
			<c:if test="${ok == 0 }">업데이트가 필요한 곡이 없습니다.</c:if>
		</div>
	</div>
</body>
</html>