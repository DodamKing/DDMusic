<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<style>
	.imgBox:hover {
		opacity: 0.7;
		cursor: pointer;
	}
</style>
<div id="play_listContainer">
	<img id="play_listbg" src="${img2000 }">
	<div id="play_listImg">
		<div>
			<c:if test="${empty sPlaylist }"><img id="play_listImg_img" style="width: 100%;" src="${img1000}"></c:if>
			<c:if test="${!empty sPlaylist }"><img id="play_listImg_img" src="${fn:replace(sPlaylist[0].img, '50', '400') }"></c:if>
		</div>
	</div>
	<div id="play_listBox">
	    <div class="mt-3">
	        <div id="play_list" class="pfc" >
				<c:if test="${!empty vo }">
		        	<div class='d-flex p-3'>
		        		<div class='imgBox mr-3'>
		        			<img src='${vo.img}' title="재생" onclick="startThis(${vo.idx})">
	        			</div>
		    			<div>
		    				<div class='playlist_t' title="${vo.title }">
		    					<c:if test="${fn:length(vo.title) > 14 }">${fn:substring(vo.title, 0, 14) }...</c:if>
		    					<c:if test="${fn:length(vo.title) <= 14 }">${vo.title }</c:if>
		    				</div>
		    				<div class='playlist_a' title="${vo.artist }">
		    					<c:if test="${fn:length(vo.artist) > 14 }">${fn:substring(vo.artist, 0, 14) }...</c:if>
		    					<c:if test="${fn:length(vo.artist) <= 14 }">${vo.artist }</c:if>
	    					</div>
		    			</div>
		    			<div class='ml-auto'>
		    				<button name='delete_btn' type='button' class='btn' onclick='delList(${vo.idx})' ><i title="플레이리스트에서 제거" class='fa-regular fa-trash-can'></i></button>
						</div>
					</div>
				</c:if>
				<c:if test="${!empty sPlaylist }">
					<c:forEach var="vo" items="${sPlaylist }" varStatus="st">
			        	<div class='d-flex p-3'>
			        		<div class='imgBox mr-3'>
			        			<img src='${vo.img}'>
		        			</div>
			    			<div>
			    				<div class='playlist_t' title="${vo.title }">${vo.title }</div>
			    				<div class='playlist_a' title="${vo.artist }">${vo.artist }</div>
			    			</div>
			    			<div class='ml-auto'>
			    				<button name='delete_btn' type='button' class='btn' onclick='delList(${st.index })' ><i title="플레이리스트에서 제거" class='fa-regular fa-trash-can'></i></button>
							</div>
						</div>
					</c:forEach>
				</c:if>
	        </div>
	    </div>
	</div>
</div>
