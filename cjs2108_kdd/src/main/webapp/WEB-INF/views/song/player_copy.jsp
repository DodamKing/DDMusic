<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>DDMusic</title>
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
	body {
		background: #222;
		color: white;
	}
	
	#play_bar {
	    -webkit-appearance: none;
	    overflow: hidden;
	    height: 5px;
	    width: 100%;
	    cursor: pointer;
	    position: absolute;
	}
	
	#play_bar::-webkit-slider-thumb {
	    -webkit-appearance: none;
	    width: 0px;
	    height: 5px;
	    box-shadow: -8000px 0 0 8000px red;
	}
	
	button[type="button"] {
	    color: inherit;
	    opacity: 0.7;
	}

	button[type="button"]:hover {
	    color: inherit;
	    opacity: 1;
	}
	
	.imgBox {
	    width: 50px;
	}
	
	.playlist_a {
		font-size: 13px;
		opacity: 0.7;
	}
	
	.imgcon {
		width: 500px;
		height: 300px;
		text-align: center;
		vertical-align: middle;
		background-image: url('${ctp }/resources/img/11.png');
	}
	
	
	
</style>
</head>
<body>
	<div style="width: 500px; margin: auto;">
		<div class="imgcon"><img style="width: 200px" src='${ctp }/resources/img/11.png'></div>
		<div  style="width: 500px;"><input style="width: 100%;" id="play_bar" type="range" value="50"></div>
		<div class="row mt-3">
			<div class="col-1">
		        <button id="like_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
	        	<button id="like_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
			</div>
	    	<div class="col text-center">
	    		<div>제목</div>
	    		<div class="playlist_a">가수</div>
	    	</div>
	    	<div class="col-2"><button class="btn" type="button" title="더보기"><i class="fa-solid fa-ellipsis"></i></button></div>
		</div>
		<div class="row mt-3">
			<div class="col">
				<button id="mute_btn1" class="btn" type="button"><i class="fa-solid fa-volume-high"></i></button>
				<button id="mute_btn2" class="btn" type="button" style="display: none;"><i class="fa-solid fa-volume-xmark"></i></button>
			</div>	
			<div class="col">
				<button id="suffle_btn" class="btn" type="button" title="재생 방법 변경"><i class="fa-solid fa-shuffle"></i></button>
			</div>
			<div class="col">
	            <button id="back_btn" class="btn" type="button"><i class="fa-solid fa-backward-step"></i></button>
			</div>
			<div class="col">
            	<button id="play_btn" class="btn" type="button" title="재생/일시정지 선택"><i class="fa-regular fa-circle-play fa-2x"></i></button>
            	<button id="pause_btn" style="display: none;" class="btn" type="button" title="재생/일시정지 선택"><i class="fa-regular fa-circle-pause fa-2x"></i></button>
			</div>
			<div class="col">
	            <button id="next_btn" class="btn" type="button"><i class="fa-solid fa-forward-step"></i></button>
			</div>
			<div class="col">
            	<button id="repeat_btn" class="btn" type="button" title="반복 재생 설정"><i class="fa-solid fa-repeat"></i></button>
			</div>
			<div class="col">
				<button id="lyrics_btn" class="btn" type="button" title="가사" data-toggle="modal" data-target="#myModal"><i class="fa-solid fa-music"></i></button>
			</div>
		</div>
		<div style="border-top: 1px solid gray;"></div>
		<div class="container mt-3">
			<div class='d-flex p-1'>
        		<div class='imgBox mr-4'>
        			<img style="width: 100%" src='${ctp }/resources/img/11.png'>
    			</div>
    			<div>
    				<div class='playlist_t' title="${vo.title }">제목</div>
    				<div class='playlist_a' title="${vo.artist }">가수</div>
    			</div>
    			<div class='ml-auto'>
    				<button name='delete_btn' type='button' class='btn' onclick='delList(${st.index })' ><i title="플레이리스트에서 제거" class='fa-regular fa-trash-can'></i></button>
				</div>
			</div>
		</div>
	</div>
	<audio id="player" src="" ></audio>
</body>
</html>