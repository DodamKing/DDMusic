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
    <title>DD Music Search Result</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css">
    <link rel="stylesheet" href="${ctp }/resources/css/top100.css">
</head>

<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
    <section>
    	<jsp:include page="/WEB-INF/views/include/modal.jsp" />
    	<%
    		String srchKwd = request.getParameter("srchKwd");
    		String srchKwdU = srchKwd.toUpperCase();
    		String srchKwdL = srchKwd.toLowerCase();
    	  	pageContext.setAttribute("srchKwdU", srchKwd.toUpperCase());
    	  	pageContext.setAttribute("srchKwdL", srchKwd.toLowerCase());
    	  	pageContext.setAttribute("active", "<span class='bg-warning'>" + srchKwd + "</span>");
    	  	pageContext.setAttribute("activeU", "<span class='bg-warning'>" + srchKwdU + "</span>");
    	  	pageContext.setAttribute("activeL", "<span class='bg-warning'>" + srchKwdL + "</span>");
    	%>
        <div class="container">
            <div class="card-body" style="padding-bottom: 300px;">
                <h2 class="mt-5 mb-5">DD Music '${srchKwd }' 검색결과</h2>
                <c:if test="${empty vos }">검색 결과가 없습니다.</c:if>
                <table class="table" style="width: 80%; margin: auto;">
                    <c:forEach var="vo" items="${vos }" varStatus="st">
	                    <tr>
	                        <td><div class="imgBox"><img name="top100Img" src="${vo.img }" alt=""></div></td>
	                        <td>
	                            <div name="top100Title">
	                            	<a href="${ctp }/infor?idx=${vo.idx }">
	                            		${fn:replace(vo.title, srchKwd, active) }
	                            		<%-- <c:if test="${fn:contains(vo.title, srchKwdU) }">
			                            	${fn:replace(vo.title, srchKwdU, activeU) }
	                            		</c:if>
	                            		<c:if test="${fn:contains(vo.title, srchKwdL) }">
		                            		${fn:replace(vo.title, srchKwdL, activeL) }
		                            	</c:if>
		                            	<c:if test="${!fn:contains(vo.title, srchKwdU) && !fn:contains(vo.title, srchKwdL) }">
	                            			${vo.title }
	                            		</c:if> --%>
	                            	</a>
                            	</div>
	                            <div name="top100Artist">
	                           		${fn:replace(vo.artist, srchKwd, active) }
	                            	<%-- <c:if test="${fn:contains(vo.artist, srchKwdU) }">
	                            		${fn:replace(vo.artist, srchKwdU, activeU) }
	                            	</c:if>
	                            	<c:if test="${fn:contains(vo.artist, srchKwdL) }">
	                            		${fn:replace(vo.artist, srchKwdL, activeL) }
	                            	</c:if>
	                            	<c:if test="${!fn:contains(vo.artist, srchKwdU) && !fn:contains(vo.artist, srchKwdL) }">
	                            		${vo.artist }
	                            	</c:if> --%>
	                            </div>
	                        </td> 
	                        <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="senddata(${vo.idx}, ${vo.isFile })"><i title="곡 추가" class="fas fa-plus"></i></button></td>
	                        <%-- <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="addf(${vo.idx}, ${vo.isFile })"><i title="곡 추가" class="fas fa-plus"></i></button></td> --%>
	                    </tr>
                    </c:forEach>
                </table>
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