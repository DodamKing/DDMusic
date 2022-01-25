<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<link rel="stylesheet" href="${ctp }/resources/css/loader.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

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
		<c:if test="${!empty player}">
			<% 
			   	boolean player = (boolean) session.getAttribute("player");
				pageContext.setAttribute("player1", player); 
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
						
						$("#message_box1").slideDown(300);
						setTimeout(() => $("#message_box1").slideUp(), 1000);
					}
				});
				$.ajax({
					type : "post",
					url : "${ctp}/song/open"
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
						
						$("#message_box1").slideDown(300);
						setTimeout(() => $("#message_box1").slideUp(), 1000);
					}
				});
			} 
			else {
				let url = "${ctp}/song/player?idx=" + idx + "&play=0";
				player = window.open(url, "player", "width=1100px, height=800px, left=50px, top=150px");
				sw = true;
			}
		}
		
		$.ajax({
			type : "post",
			url : "${ctp}/song/open"
		});
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
		
		<c:if test="${!empty player}">
			<% 
			   	boolean player = (boolean) session.getAttribute("player");
				pageContext.setAttribute("player1", player); 
			%>
			if (${player1}) {
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
							
							$("#message_box_many").slideDown(300);
							setTimeout(() => $("#message_box_many").slideUp(), 1000);
						}
					});
				}
				$.ajax({
					type : "post",
					url : "${ctp}/song/open"
				});
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
		
		$.ajax({
			type : "post",
			url : "${ctp}/song/open"
		});
	}
	
</script>