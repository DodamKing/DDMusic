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
    <link rel="shortcut icon" href="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg" />
    <style>
    	.ho:hover {
    		cursor: pointer;
    		opacity: 0.7;
    	}
    	
    	th {
    		border-top: none;
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
				<h2 class="mt-5 mb-5"><font color="yellow">${sVO.nickNm }</font>님을 위한 추천 아티스트!</h2>
				<div class="row">
					<button type="button" class="btn btn-dark ml-3" onclick="javascript:location.href='${ctp}/artisttape'">목록</button>
					<div class="col"></div>
				</div>
				<div class="p-3 row">
					<div style="width: 200px; height: 200px;">
	    				<div><img src="${thum }"></div>
	    			</div>
	    			<div class="ml-5">
						<h4 id="listNm_box">${vos[0].artist } 모음</h4>
						<div id="comment_box">DDMusic</div>
	    			</div>
	    			
    			</div>
				<div class="d-flex justify-content-around p-3 mt-5">
					<button type="button" class="btn btn-dark col" onclick="listplay(${vo.idx})"><i class="fas fa-play fa-2x"></i><span class="ml-5" style="font-size: 28px;">play</span></button>
					<div class="col"></div>
					<button type="button" class="btn btn-dark col" onclick="shuffle(${vo.idx})"><i class="fas fa-random fa-2x"></i><span class="ml-5" style="font-size: 28px;">shuffle</span></button>
				</div>
				<c:if test="${!empty vos }">
					<table class="table">
						<tr>
							<th class="text-center align-middle"><input id="allch" type="checkbox" checked></th>
							<th id="cnt_box">${fn:length(vos) } 곡 선택됨</th>
							<th></th>
							<th></th>
						</tr>
						<c:forEach var="vo" items="${vos}" varStatus="st">
							<tr>
								<td class="text-center align-middle"><input name="tch" type="checkbox" checked></td>
								<td class="align-middle"><img src="${vo.img }"></td>
								<td class="align-middle" title="${vo.title }">
									<a href="${ctp }/infor?idx=${vo.idx }">
										<c:if test="${fn:length(vo.title) < 20 }">${vo.title }</c:if>
										<c:if test="${fn:length(vo.title) >= 20 }">${fn:substring(vo.title, 0, 20) }...</c:if>
									</a>
								</td>
								<td class="align-middle" title="${vo.artist }">
									<c:if test="${fn:length(vo.artist) < 20 }">${vo.artist }</c:if>
									<c:if test="${fn:length(vo.artist) >= 20 }">${fn:substring(vo.artist, 0, 20) }...</c:if>
								</td>
							</tr>
						</c:forEach>
					</table>
				</c:if>
			</div>
		</div>
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
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + "곡 선택됨";
		});
		
		//전체선택 해제
		$("input:checkbox[name='tch']").click(() => {
			cnt_box.innerHTML = $("input:checkbox[name='tch']:checked").length + "곡 선택됨";
			for (let i=0; i<$("input:checkbox[name='tch']").length; i++) {
				if (!$("input:checkbox[name='tch']")[i].checked) {
					$("#allch").prop("checked", false);
					return;
				}
			}
		});
		
		function listplay(idx) {
			let idxs = "";
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if($("input:checkbox[name='tch']")[${st.index}].checked) {
					idxs += ${vo.idx} + "/";
				}
			</c:forEach>
			
			if (idxs == "") return;
			
			let url = "${ctp}/song/player?idxs=" + idxs + "&listIdx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			
			/* if (!sw) {
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
			} */
		};
		
		function shuffle(idx) {
			let idxs = "";
			let idx_list = [];
			
			<c:forEach var="vo" items="${vos}" varStatus="st">
				if ($("input:checkbox[name='tch']")[${st.index}].checked) {
					idx_list.push(${vo.idx});
				}
			</c:forEach>

			idx_list.sort(() => Math.random() - 0.5);
			idx_list.forEach((e) => {
				idxs += e + "/";
			});
			
			if (idxs == "") return;
			
			let url = "${ctp}/song/player?idxs=" + idxs + "&listIdx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
		}
		
    </script>
	
</body>
</html>