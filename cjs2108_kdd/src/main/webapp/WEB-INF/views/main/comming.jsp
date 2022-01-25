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
				<c:forEach var="vo" items="${vos }" varStatus="st">
					<div>
						<c:if test="${date != fn:split(vo.date, ' ')[0]}"><br><p style="font-size: 28px;">${fn:replace(fn:split(vo.date, " ")[0], "-", ".") } 업데이트 <i onclick="more_i('${fn:split(vo.date, ' ')[0]}')" class="fas fa-caret-down ho"></i></p></c:if>
						<p <c:if test="${date != fn:split(vo.date, ' ')[0]}">name="more_box${fn:split(vo.date, ' ')[0] }"</c:if>
						<c:set var="Nm" value="more_box${fn:split(vo.date, ' ')[0] }" />
						<c:if test="${date == fn:split(vo.date, ' ')[0]}">name="${Nm }"</c:if>
						 style="color: #bbb; display: none;">${vo.title } - ${vo.artist } </p>
					</div>
					<c:set var="date" value="${fn:split(vo.date, ' ')[0] }" />
				</c:forEach>
				<div class="mt-5">
					<p style="font-size: 28px;">2022.01.14 업데이트 <i onclick="$('#0114').toggle();" class="fas fa-caret-down ho"></i></p>
					<div id="0114" style="display: none;">
						<p style="color: #bbb;">뿌리 (Feat. JUSTHIS) (Prod. GroovyRoom) - 쿤디판다(Khundi Panda) </p>
						<p style="color: #bbb;">개똥벌레 - 신형원</p>
					</div>
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
		function more_i(date) {
			$("p[name='more_box" + date + "']").toggle();
		}
	</script>
	
</body>
</html>