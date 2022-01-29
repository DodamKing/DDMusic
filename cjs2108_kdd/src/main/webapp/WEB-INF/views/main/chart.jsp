<%@page import="java.util.Date"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>DD Music Chart Top 100</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <link rel="stylesheet" href="${ctp }/resources/css/top100.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<c:set var="today"><fmt:formatDate value="<%=new Date() %>" pattern="yyyy-MM-dd"/></c:set>
	
	<section>
        <div class="container">
            <div class="card-body">
                <h2 class="mt-5 mb-5">DD Music Top 100</h2>
                <div>
	                <input type="date" id="calendar" min="${minDate }" max="${today }">
	                <div id="go_btn" class="btn btn-dark btn-sm">go</div>
                </div>
                <div id="top_btn" class="btn btn-dark" style="position: fixed; right: 30px; bottom: 100px;">top</div>
                <c:if test="${!empty vos }"><div id="add_btn" class="btn btn-dark btn-sm" style="position: sticky; right: 30px; top: 50px; float: right;" onclick="">선택추가</div></c:if>
                <div class="text-center h4">
                	${fn:replace(fn:split(vos[0].date, " ")[0], "-", ".") }
            	</div>
            	<c:if test="${empty vos }"><p class="h5 mt-5" style="padding-bottom: 400px;">아직 차트가 업데이트 되지 않았습니다. 잠시 기다려 주세요!</p></c:if>
            	<c:if test="${!empty vos }">
	                <table class="table">
	                	<tr>
	                		<td style="border-top: none;"><input id="allch" type="checkbox" ></td>
	                		<td id="cnt_box" colspan="2" style="vertical-align: middle; border-top: none;">0 곡 선택 됨</td>
	                		<!-- <td colspan="2" class="text-right" style="border-top: none;"><div id="add_btn" class="btn btn-dark btn-sm" style="position: sticky; position: -webkit-sticky; right: 30px; top: 50px;">선택추가</div></td> -->
	            		</tr>
	                    <c:forEach var="vo" items="${vos }" varStatus="st">
		                    <tr>
		                    	<td><input name="tch" type="checkbox" value="${vo.songIdx }" <c:if test="${vo.isFile == 0 }">disabled</c:if>></td>
		                        <%-- <td style="text-align: center; vertical-align: middle;">${st.index + 1}</td> --%>
		                        <td style="text-align: center; vertical-align: middle;">${vo.rank}</td>
		                        <td><div class="imgBox ho" onclick="oneplay(${vo.songIdx}, ${vo.isFile })"><img name="top100Img" src="${vo.img }"></div></td>
		                        <td class="align-middle">
		                            <div name="top100Title"><a href="${ctp }/infor?idx=${vo.songIdx }">${vo.title }</a></div>
		                            <div name="top100Artist">${vo.artist }</div>
		                        </td>
		                        <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="senddata(${vo.songIdx}, ${vo.isFile })"><i title="곡 추가" class="fas fa-plus"></i></button></td>
		                        <%-- <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="addf(${vo.idx}, ${vo.isFile })"><i title="곡 추가" class="fas fa-plus"></i></button></td> --%>
		                    </tr>
	                    </c:forEach>
	                </table>
                </c:if>
            </div>
        </div>
        <!-- <div id="demo" style="display: none;">0</div> -->
        <jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
		top_btn.addEventListener("click", () => {
			window.scrollTo({top: 0, behavior: 'smooth'});
		});
	
		//전체선택
		allch.addEventListener("click", () => {
			if (allch.checked) {
				$("input:checkbox[name='tch']:not(:disabled)").prop("checked", true);
			}
			else {
				$("input:checkbox[name='tch']").prop("checked", false);
			}
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + " 곡 선택 됨"
		});
		
		//전체선택 해제
		$("input:checkbox[name='tch']").click(() => {
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + " 곡 선택 됨"
			for (let i=0; i<100; i++) {
				if (!$("input:checkbox[name='tch']")[i].checked) {
					$("#allch").prop("checked", false);
					return;
				}
			}
		});
		
		//선택 추가 버튼
		add_btn.addEventListener("click", () => {
			let idxs = "";
			
			for (let i=0; i<100; i++) {
				if($("input:checkbox[name='tch']")[i].checked) {
					if ($("input:checkbox[name='tch']")[i].value != 0) {
						idxs += $("input:checkbox[name='tch']")[i].value + "/";
					}
				}
			}
			
			$('#hiden_btn_many').click();
			idx_box_many.innerHTML = idxs;
		});
		
		go_btn.addEventListener("click", () => {
			let date1 = new Date(calendar.value);
			let date2 = new Date("${minDate}");
			let date3 = new Date("${today}");
			
			if (date1 < date2 || date1 > date3) {
				return;
			}
			
			location.href = "${ctp}/chart?date=" + calendar.value;
		});
		
	</script>
	
</body>
</html>