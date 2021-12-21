<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<footer>
    <input id="play_bar" type="range" value="0">
    <div class="d-flex ml-4">
        <div class="pt-3">
        	<c:if test="${empty sPlaylist }">
	            <div class="row">
	                <div class="imgBox"><img id="controls_img" src="${ctp }/resources/img/music.png" alt=""></div>
	                <div class="controls-song ml-2 mt-2">
	                    <div id="controls_title" title="오늘 뭐 듣지?">오늘 뭐 듣지?</div>
	                    <div id="controls_artist" title="재생 버튼을 클릭 해 보세요">재생 버튼을 클릭 해 보세요</div>
	                </div>
	            </div>
            </c:if>
        	<c:if test="${!empty sPlaylist }">
	            <div class="row">
	                <div class="imgBox"><img id="controls_img" src="${sPlaylist[0].img }" alt=""></div>
	                <div class="controls-song ml-2 mt-2">
	                    <div id="controls_title" title="${sPlaylist[0].title }">${sPlaylist[0].title }</div>
	                    <div id="controls_artist" title="${sPlaylist[0].artist }">${sPlaylist[0].artist }</div>
	                </div>
	            </div>
            </c:if>
        </div>
        <div class="ml-3 mt-4">
        	<c:if test="${empty sMid }">
	            <button id="like_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
	            <button id="like_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
        	</c:if>
        	<c:if test="${fn:contains(sPlaylist[0].likeList, sMid) && !empty sMid }">
	            <button id="like_btn1" style="display: none;" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
	            <button id="like_btn2" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
        	</c:if>
        	<c:if test="${!fn:contains(sPlaylist[0].likeList, sMid) && !empty sMid }">
	            <button id="like_btn1" class="btn" type="button" title="좋아요"><i class="fa-regular fa-heart"></i></button>
	            <button id="like_btn2" style="display: none;" class="btn" type="button"><i class="fa-solid fa-heart text-danger"></i></button>
        	</c:if>
            <button id="lyrics_btn" class="btn" type="button" title="가사" data-toggle="modal" data-target="#myModal"><i class="fa-solid fa-music"></i></button>
            <button class="btn" type="button" title="더보기"><i class="fa-solid fa-ellipsis"></i></button>
        </div>
        <div class="ml-auto mr-auto mt-2">
            <button id="suffle_btn" class="btn" type="button" title="재생 방법 변경"><i
                    class="fa-solid fa-shuffle"></i></button>
            <button id="back_btn" class="btn" type="button"><i class="fa-solid fa-backward-step fa-2x"></i></button>
            <button id="play_btn" class="btn" type="button" title="재생/일시정지 선택"><i
                    class="fa-regular fa-circle-play fa-3x"></i></button>
            <button id="pause_btn" style="display: none;" class="btn" type="button"><i
                    class="fa-regular fa-circle-pause fa-3x"></i></button>
            <button id="next_btn" class="btn" type="button"><i class="fa-solid fa-forward-step fa-2x"></i></button>
            <button id="repeat_btn" class="btn" type="button" title="반복 재생 설정"><i
                    class="fa-solid fa-repeat"></i></button>
        </div>
        <div class="ml-auto d-flex mt-4">
            <div id="controls_time" class="mt-2">00:00 / 00:00</div>
            <div id="mute_btn1" class="ml-2"><button class="btn" type="button"><i
                        class="fa-solid fa-volume-high"></i></button></div>
            <div id="mute_btn2" class="ml-2" style="display: none;"><button class="btn" type="button"><i
                        class="fa-solid fa-volume-xmark"></i></button></div>
            <div class="ml-1 mt-1"><input id="volume_bar" type="range" min="0" max="100" ></div>
        </div>
        <div class="ml-3 pt-3 mr-3">
            <button id="playlistUp_btn" class="btn" type="button"><i class="fa-solid fa-arrow-down-short-wide fa-2x fa-flip-vertical"></i></button>
            <button style="display: none;" id="playlistDown_btn" class="btn" type="button"><i class="fa-solid fa-arrow-down-wide-short fa-2x"></i></button>
        </div>
    </div>
    <audio id="player" src="" ></audio>
</footer>