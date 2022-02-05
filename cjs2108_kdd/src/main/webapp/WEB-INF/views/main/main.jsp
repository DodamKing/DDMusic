<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<link rel="stylesheet" href="${ctp }/resources/css/loader.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="shortcut icon" href="https://i1.sndcdn.com/avatars-000606604806-j6ghpm-t500x500.jpg" />

<jsp:include page="/WEB-INF/views/include/addlist.jsp" />
<jsp:include page="/WEB-INF/views/include/addlist_many.jsp" />
<button id="hiden_btn" type="button" data-toggle="modal" data-target="#addlist" style="display: none;" onclick=""></button>
<button id="hiden_btn_many" type="button" data-toggle="modal" data-target="#addlist_many" style="display: none;" onclick=""></button>
<div class="loader"></div>
<div id="mainBody">
	<c:if test="${flag == 'today'}">
		<jsp:include page="/WEB-INF/views/main/today.jsp" />
	</c:if>
	<c:if test="${flag == 'chart'}">
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
	<c:if test="${flag == 'artisttape'}">
		<jsp:include page="/WEB-INF/views/user/artisttape.jsp" />
	</c:if>
	<c:if test="${flag == 'artist'}">
		<jsp:include page="/WEB-INF/views/user/artist.jsp" />
	</c:if>
	<c:if test="${flag == 'gift'}">
		<jsp:include page="/WEB-INF/views/user/gift.jsp" />
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
	 
	 function oneplay(idx, isFile) {
		 	if (isFile == 0) {
		 		alert("준비중입니다.");
		 		return;
		 	}
			let url = "${ctp}/song/player?idx=" + idx + "&play=1";
			player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
			sw = true;
	 }
		
	function addf(idx, isFile, autoplay) {
		<c:if test="${!empty sPlayer}">
			<% 
			   	boolean sPlayer = (boolean) session.getAttribute("sPlayer");
				pageContext.setAttribute("player1", sPlayer); 
			%>
			if (${player1}) {
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
			let url = "${ctp}/song/player?idx=" + idx + "&play=0";
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
				let url = "${ctp}/song/player?idx=" + idx + "&play=0";
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
	}
	
	function senddata(idx, isFile) {
		if (idx == 0 || isFile == 0) {
			alert("아직 준비 중인 곡입니다.");
			return;
		}
		
		$('#hiden_btn').click();
		idx_box.innerHTML = idx;
		isFile_box.innerHTML = isFile;
	}
	
	function godata() {
		let idx = idx_box.innerHTML;
		let isFile = isFile_box.innerHTML;
		addf(idx, isFile);
	}
	
	function godata_many() {
		let idxs = idx_box_many.innerHTML;
		
		<c:if test="${!empty sPlayer}">
			<% 
			   	boolean sPlayer = (boolean) session.getAttribute("sPlayer");
				pageContext.setAttribute("player1", sPlayer); 
			%>
			if (${player1} && player) {
				player = window.open("", "player", "width=1100px, height=800px, left=50px, top=150px");
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
				return;
			}
		</c:if>
		
		if (!sw) {
			let url = "${ctp}/song/player?idxs=" + idxs + "&play=0";
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
							
							$("#message_box_many").slideDown(300);
							setTimeout(() => $("#message_box_many").slideUp(), 1000);
						}
					});
				}
			}
			else {
				let url = "${ctp}/song/player?idxs=" + idxs + "&play=0";
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
	}
	
	function action(idx) {
		let data = {
			idx : idx,
			songIdx : idx_box.innerHTML
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/user/addmylist",
			data : data,
			success : (data) => {
				if (data == 1) {
					$("#message_box1").slideDown(300);
					setTimeout(() => $("#message_box1").slideUp(), 1000);
					return;
				}
				$("#message_box2").slideDown(300);
				setTimeout(() => $("#message_box2").slideUp(), 1000);
			}
		});
	}
	
	function download() {
		let idx = idx_box.innerHTML;
		$.ajax({
			type : "post",
			url : "${ctp}/song/download",
			data : {idx : idx},
			success : (data) => {
				if (data == 0) {
					$("#message_box3").html("로그인이 필요합니다");
				}
				
				else if (data == 1) {
					$("#message_box3").html("권한이 없습니다. 관리자에게 권한을 요청해 보세요.");
				}
				
				else {
					$("#message_box3").html("해당곡이 저장되었습니다. 보관함에 구매한 MP3에서 확인하세요.");
				}
				
				$("#message_box3").slideDown(300);
				setTimeout(() => $("#message_box3").slideUp(), 1000);
			}
		});
	}
	
	function gift() {
		$("#message_box3").html("준비중인 서비스 입니다.");
		$("#message_box3").slideDown(300);
		setTimeout(() => $("#message_box3").slideUp(), 1000);
	}
	
	function player_close() {
		$.ajax({
			type : "post",
			url : "${ctp}/song/close",
			success : () => {
				location.reload();
			}
		});
	}
	
</script>