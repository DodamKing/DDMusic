<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<% pageContext.setAttribute("chart", "<jsp:include page='/WEB-INF/views/main/chart.jsp' />"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<link rel="stylesheet" href="${ctp }/resources/css/loader.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<jsp:include page="/WEB-INF/views/include/addlist.jsp" />
<button id="hiden_btn" type="button" data-toggle="modal" data-target="#addlist" style="display: none;" onclick=""></button>
<div class="loader"></div>
<div id="mainBody">
	<c:if test="${flag == 'today'}">
		<jsp:include page="/WEB-INF/views/main/today.jsp" />
	</c:if>
	<c:if test="${flag == 'chart'}">
		<!-- <div class="loader"></div>
		<script>
			$.ajax({
				type : "post",
				url : "${ctp}/song/getchart",
				success : () => {
			        $('.loader').fadeOut();
			         mainBody.innerHTML = "${chart}";
				}
			});
		</script> -->
		<jsp:include page="/WEB-INF/views/main/chart.jsp" />
	</c:if>
	<c:if test="${flag == 'srch'}">
		<jsp:include page="/WEB-INF/views/song/songsrch.jsp" />
	</c:if>
	<c:if test="${flag == 'infor'}">
		<jsp:include page="/WEB-INF/views/song/songinfor.jsp" />
	</c:if>
	<c:if test="${flag == 'rank'}">
		<jsp:include page="/WEB-INF/views/song/songrank.jsp" />
	</c:if>
	<c:if test="${flag == 'comming'}">
		<jsp:include page="/WEB-INF/views/main/comming.jsp" />
	</c:if>
	<c:if test="${flag == 'content'}">
		<jsp:include page="/WEB-INF/views/review/content.jsp" />
	</c:if>
	<c:if test="${flag == 'intro'}">
		<jsp:include page="/WEB-INF/views/main/intro.jsp" />
	</c:if>
	<c:if test="${flag == 'myranking'}">
		<jsp:include page="/WEB-INF/views/main/myranking.jsp" />
	</c:if>
	<c:if test="${flag == 'temp'}">
		<jsp:include page="/WEB-INF/views/main/temp.jsp" />
	</c:if>
</div>

<script>
	let sw;
	let player;
	
	 $(document).ready(() => {
        $('.loader').fadeOut();
	 });
		
	function addf(idx, isFile) {
		if (idx == 0 || isFile == 0) {
			alert("아직 준비 중인 곡입니다.");
			return;
		}
		
		<c:if test="${!empty player}">
			if (${player}) {
				player = window.open("", "player", "width=1100px, height=800px, left=50px, top=150px");
				$.ajax({
					type : "post",
					url : "${ctp}/song/player",
					data : {idx : idx},
					success : (data) => {
						player.addList(data);
						player.setList();
					}
				});
				return;
			}
		</c:if>
		
		if (!sw) {
			let url = "${ctp}/song/player?idx=" + idx;
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			sw = true;
		}
		else {
			if (!player.closed && sw) {
				$.ajax({
					type : "post",
					url : "${ctp}/song/player",
					data : {idx : idx},
					success : (data) => {
						player.addList(data);
						player.setList();
					}
				});
			} 
			else {
				let url = "${ctp}/song/player?idx=" + idx;
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
	}
	
	$("button[name='add_btn']").click(() => {
		$('#hiden_btn').click();
	});
	
	function senddata(idx, isFile) {
		idx_box.innerHTML = idx;
		isFile_box.innerHTML = isFile;
	}
	
	function godata() {
		let idx = idx_box.innerHTML;
		let isFile = isFile_box.innerHTML;
		addf(idx, isFile);
	}
	
</script>