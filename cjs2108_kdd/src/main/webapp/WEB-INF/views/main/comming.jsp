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
	<title>커밍쑨 DDMusic</title>
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
			<div class="card-body" style="padding-bottom: 300px;">
				<h2 class="mt-5 mb-5">커밍쑨 DDMusic</h2>
				<c:forEach var="vo" items="${vos }">
					<div>
						<p>${fn:replace(fn:split(vo.date, " ")[0], "-", ".") } 업데이트</p>
						<p>${vo.title } - ${vo.artist } </p>
					</div>
				</c:forEach>
				<div class="mt-5">
					<p>2022.01.14 업데이트</p>
					<p>뿌리 (Feat. JUSTHIS) (Prod. GroovyRoom) - 쿤디판다(Khundi Panda) </p>
					<p>개똥벌레 - 신형원</p>
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