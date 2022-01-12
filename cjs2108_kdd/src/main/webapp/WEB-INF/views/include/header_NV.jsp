<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<header>
    <div id="srch_bar">
        <%-- <form class="form-inline" action="${ctp}/song/srch" method="post"> --%>
        <form class="form-inline" action="${ctp}/srch" method="get">
	        <input class="form-control mr-2 col" type="text" id="srchKwd" name="srchKwd" value="${srchKwd}" placeholder="DD Music 검색" autofocus>
	        <button id="srch_btn" class="btn btn-secondary col-1" type="button">Search</button>
        </form>
    </div>
</header>

<!-- <script>
		srch_btn.addEventListener("click", () => {
			$.ajax({
				type : "post",
				url : "${ctp}/srch",
				data : {srchKwd : srchKwd.value},
				success : () => {
					<c:set var="flag" value="srch" />
    				$("#mainBody").load(window.location.href + " #mainBody");
    			}
			});
		});
</script> -->