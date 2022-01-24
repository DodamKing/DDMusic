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
    <title>${vo.title } 곡정보</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=1">
	<style>
	    #srch_bar {
    		position: fixed;
    		top: 0;
	    }
	    
	    #lyrics_div {
	    	height: 200px;
	    	overflow: hidden;
	    }
    </style>
</head>
		
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />

	<section>
		<div class="container mt-5 mb-5 pb-3 bg-dark" style="width: 70%; border-radius: 5px;">
			<div>
				<c:if test="${empty vo.idx }">	
					<h3 class="text-white pl-3 pt-4">준비중입니다.<span style="float: right;" class="text-rigth btn btn-secondary"><a href="javascript:history.back()">돌아가기</a></span></h3>
				</c:if>
				<c:if test="${!empty vo.idx }">
					<h3 class="text-white pl-3 pt-4">${vo.title }<span style="float: right;" class="text-rigth btn btn-secondary"><a href="javascript:history.back()">돌아가기</a></span></h3>
					<p class="text-white pl-3">
						노래 | ${vo.artist } | ${vo.releaseDate }
						<c:if test="${empty sMid }">
				            <button id="songlike_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<c:if test="${fn:contains(vo.likeList, sMid) && !empty sMid }">
				            <button id="songlike_btn1" style="display: none;" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<c:if test="${!fn:contains(vo.likeList, sMid) && !empty sMid }">
				            <button id="songlike_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
				            <button id="songlike_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			        	</c:if>
			        	<span id="songLikeCnt">${vo.likeCnt }</span>
		        	</p>
				</c:if>
				<div class="p-3 mb-3" style="border-radius: 15px; background-color: rgb(35, 35, 35);">
					<h5><b>곡정보</b></h5>
					<c:if test="${!empty vo.idx }">
						<table class="table table-borderless text-mute">
							<tr>
								<th width="100px">아티스트</th>
								<td>${vo.artist }</td>
								<td rowspan="7"><div style="width: 300px; float: right;"><img style="border-radius: 100%" src="${vo.img }"></div></td>
							</tr>
							<tr>
								<th>앨범</th>
								<td>${vo.album }</td>
							</tr>
							<tr>
								<th>발매</th>
								<td>${vo.releaseDate }</td>
							</tr>
							<tr>
								<th>장르</th>
								<td>${vo.genre }</td>
							</tr>
							<tr>
								<th>작곡</th>
								<td>${vo.music }</td>
							</tr>
							<tr>
								<th>작사</th>
								<td>${vo.words }</td>
							</tr>
							<tr>
								<th>편곡</th>
								<td>${vo.arranger }</td>
							</tr>
						</table>
					</c:if>
				</div>
			</div>
			<div class="p-3" style="border-radius: 15px; background-color: rgb(35, 35, 35);">
				<h5><b>가사정보</b></h5>
				<div class="text-light text-center">
					<div id="lyrics_div">${fn:replace(vo.lyrics, enter, "<br>") }</div>
					<button id="lyrics_more_btn" type="button" class="btn btn-dark form-control mt-5" onclick="moerLyrics()">더보기</button>
				</div>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
	</section>
	        
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js"></script>
    <script>
    	let lyricssw = 0;
    
    	$("#songlike_btn1").click(() => {
    		$("#songlike_btn1").hide();
    		$("#songlike_btn2").show();
    		
    		if (${empty sMid}) return;

    		$.ajax({
    			type : "post",
    			url : "${ctp}/song/like",
    			data : {idx : ${vo.idx}},
    			success : () => {
    				$("#songLikeCnt").load(window.location.href + " #songLikeCnt");
    			}
    		});
    	}); 
    	
    	$("#songlike_btn2").click(() => {
    		$("#songlike_btn2").hide();
    		$("#songlike_btn1").show();
    		
    		if (${empty sMid}) return;
    		
			$.ajax({
				type : "post",
				url : "${ctp}/song/unlike",
				data : {idx : ${vo.idx}},
				success : () => {
    				$("#songLikeCnt").load(window.location.href + " #songLikeCnt");
    			}
			});    		
    	}); 
    		
    	function moerLyrics() {
    		if (lyricssw == 0) {
	    		lyrics_div.style.height = "auto";
	    		lyrics_div.style.overflow = "auto";
	    		lyricssw = 1;
	    		lyrics_more_btn.innerHTML = "접기";
    		}
    		
    		else {
	    		lyrics_div.style.height = "200px";
	    		lyrics_div.style.overflow = "hidden";
	    		lyricssw = 0;    			
	    		lyrics_more_btn.innerHTML = "더보기";
    		}
		}
    	
    </script>
</body>

</html>