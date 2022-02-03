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
	<title>DD Music</title>
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
				<h2 class="mt-5 mb-5">구매한 MP3</h2>
				<c:if test="${empty vos }"><p>구매한 내역이 없습니다.</p></c:if>
				<c:if test="${!empty vos }">
					<div>
						<div class="row">
							<div class="col"></div>
							<div class="mr-5">${sVO.nickNm }님의 구매 내역</div>
						</div>
						<table class="table">
							<c:forEach var="vo" items="${vos}">
								<tr>
									<td><img src="${vo.img }"></td>
									<td>${vo.title }</td>
									<td>${vo.artist }</td>
									<td><div class="btn btn-outline-warning" onclick="download('${vo.idx}')">다운로드</div></td>
								</tr>
							</c:forEach>
						</table>
					</div>
				</c:if>
				<a id="downAction" style="display: none;" download target="_blank"></a>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
		function download(idx) {
			if (confirm("다운로드 하시겠습니까?")) {
				$.ajax({
					type : "post",
					url : "${ctp}/song/mp3/down",
					data : {idx : idx},
					contentType: "application/x-www-form-urlencoded; charset=UTF-8",
					success : (data) => {
						let url = "${ctp}/music/" + data
						$("#downAction").prop("href", url);
						$("#downAction").get(0).click();
					}
				});
			}
		}
	</script>
	
</body>
</html>