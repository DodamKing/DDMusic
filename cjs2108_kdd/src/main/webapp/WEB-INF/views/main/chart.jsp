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
	
	<section>
        <div class="container">
            <div class="card-body">
                <h2 class="mt-5 mb-5">DD Music Top 100</h2>
                <div id="top_btn" class="btn btn-dark" style="position: fixed; right: 30px; bottom: 100px;">top</div>
                <div id="add_btn" class="btn btn-dark btn-sm" style="position: sticky; right: 30px; top: 50px; float: right;">선택추가</div>
                <table class="table">
                	<tr>
                		<td style="border-top: none;"><input id="allch" type="checkbox" ></td>
                		<td colspan="2" style="vertical-align: middle; border-top: none;">전체선택</td>
                		<!-- <td colspan="2" class="text-right" style="border-top: none;"><div id="add_btn" class="btn btn-dark btn-sm" style="position: sticky; position: -webkit-sticky; right: 30px; top: 50px;">선택추가</div></td> -->
            		</tr>
                    <c:forEach var="vo" items="${vos }" varStatus="st">
	                    <tr>
	                    	<td><input name="tch" type="checkbox" value="${vo.idx }"></td>
	                        <td style="text-align: center; vertical-align: middle;">${st.index + 1}</td>
	                        <td><div class="imgBox"><a href="${fn:replace(vo.img, 50, 800) }" target="_blank"><img name="top100Img" src="${vo.img }" alt=""></a></div></td>
	                        <td>
	                            <div name="top100Title"><a href="${ctp }/infor?idx=${vo.idx }">${vo.title }</a></div>
	                            <div name="top100Artist">${vo.artist }</div>
	                        </td>
	                        <td class="align-middle"><button name="add_btn" type="button" class="btn" onclick="addf(${vo.idx}, ${vo.isFile })"><i title="곡 추가" class="fas fa-plus"></i></button></td>
	                    </tr>
                    </c:forEach>
                </table>
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
		//전체선택
		allch.addEventListener("click", () => {
			if (allch.checked) {
				$("input:checkbox[name='tch']").prop("checked", true);
			}
			else {
				$("input:checkbox[name='tch']").prop("checked", false);
			}
		});
		
		//전체선택 해제
		$("input:checkbox[name='tch']").click(() => {
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
			
			if (!sw) {
				let url = "${ctp}/song/player?idxs=" + idxs;
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
			else {
				if (!player.closed && sw) {
					let idx_list = idxs.split("/");
					for (let i=0; i<idx_list.length - 1; i++) {
						$.ajax({
							type : "post",
							url : "${ctp}/song/player",
							data : {idx : idx_list[i]},
							success : (data) => {
								player.addList(data);
								player.setList();
							}
						});
					}
				}
				else {
					let url = "${ctp}/song/player?idxs=" + idxs;
					player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
					sw = true;
				}
			}
		});
		
		top_btn.addEventListener("click", () => {
			window.scrollTo({top: 0, behavior: 'smooth'});
		});
		
	</script>
	
</body>
</html>