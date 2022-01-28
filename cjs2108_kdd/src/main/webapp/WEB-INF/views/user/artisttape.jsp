<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>플레이리스트 DDMusic</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css">
    <link rel="shortcut icon" href="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg" />
</head>

	<jsp:include page="/WEB-INF/views/include/addsonglist.jsp" />
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
    <section>
    	<div class="container">
    		<div class="card-body" style="padding-bottom: 300px;">
	    		<h2 class="mt-5 mb-5"><font color="yellow">${sVO.nickNm }</font>님을 위한 추천 아티스트!</h2>
	    		<div class="row">
		    		<c:forEach var="vo" items="${vos }">
		    			<div class="p-3 ho" title="${vo.artist }" onclick="javacript:location.href=''">
			    		<div style="width: 200px; height: 200px;">
		    				<div><img src="${vo.img}" style="width: 100%;"></div>
			    			</div>
			    			<div style="width: 200px;" class="mt-3 text-center">${vo.artist }</div>
		    			</div>
		    		</c:forEach>
	    		</div>
    		</div>
    	</div>
    	
        <jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js"></script>
</body>

</html>