<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>DD Music</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=1">
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
	            <h2 class="mt-5 mb-5">DD Music 이달의 노래</h2>
				<div style="width: 350px; margin: auto;" class="mb-5 text-center ho" onclick="javascript:location.href='infor?idx=${vos[0].idx }'">
					<div><img src="${vos[0].img }"></div>
					<div>${vos[0].title }</div>
					<div>${vos[0].artist }</div>
					<div>재생수 : ${vos[0].playCntSum }</div>
				</div>
				<div class="row mb-5">
					<div class="col text-center" onclick="javascript:location.href='infor?idx=${vos[1].idx }'">
						<div><img src="${vos[1].img }"></div>
						<div>${vos[1].title }</div>
						<div>${vos[1].artist }</div>
						<div>재생수 : ${vos[1].playCntSum }</div>
					</div>
					<div class="col text-center" onclick="javascript:location.href='infor?idx=${vos[2].idx }'">
						<div><img src="${vos[2].img }"></div>
						<div>${vos[2].title }</div>
						<div>${vos[2].artist }</div>
						<div>재생수 : ${vos[2].playCntSum }</div>
					</div>
				</div>
				<table class="table">
					<tr style="border-top: none;">
						<td class="text-right" colspan="7"><button id="add_btn" class="btn btn-dark" type="button">선택추가</button></td>
					</tr>
					<tr>
						<th class="text-center align-middle"><input id="allch" type="checkbox"></th>
						<th class="text-center align-middle">순위</th>
						<th></th>
						<th></th>
						<th></th>
						<th class="text-center align-middle">재생수</th>
					</tr>
					<c:forEach var="vo" items="${vos}" varStatus="st">
						<tr>
							<td class="text-center align-middle"><input name="tch" type="checkbox"></td>
							<td class="text-center align-middle">${st.count }</td>
							<c:if test="${st.index <= 2}"><td class="align-middle"><img style="width: 50px;" src="${vo.img }"></td></c:if>
							<c:if test="${st.index > 2}"><td class="align-middle"><img src="${vo.img }"></td></c:if>
							<td class="align-middle" title="${vo.title }">
								<a href="infor?idx=${vo.idx }">
									<c:if test="${fn:length(vo.title) < 20 }">${vo.title }</c:if>
									<c:if test="${fn:length(vo.title) >= 20 }">${fn:substring(vo.title, 0, 20) }...</c:if>
								</a>
							</td>
							<td class="align-middle" title="${vo.artist }">
								<c:if test="${fn:length(vo.artist) < 20 }">${vo.artist }</c:if>
								<c:if test="${fn:length(vo.artist) >= 20 }">${fn:substring(vo.artist, 0, 20) }...</c:if>
							</td>
							<td class="align-middle text-center">${vo.playCntSum }</td>
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
		
		add_btn.addEventListener("click", () => {
			let idxs = "";
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if($("input:checkbox[name='tch']")[${st.index}].checked) {
					idxs += ${vo.idx} + "/";
				}
			</c:forEach>
			
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
		
    </script>
</body>

</html>