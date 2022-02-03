<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<nav>
	<div class="card-body nav-w">
	    <div>
            <c:if test="${sVO == null }">
	            <div class="text-center"><a href="${ctp }/user/login">로그인</a></div>
            </c:if>
	        <div class="row">
	            <c:if test="${sVO != null }">
	            	<c:if test="${empty sVO.profileImg }">
		           		<div class="col-2"><i class="fa-solid fa-user"></i></div>
	            	</c:if>
	            	<c:if test="${!empty sVO.profileImg }">
		           		<div class="col-2 mr-2" style="margin-top: -2px;"><img src="${ctp }/resources/img/${sVO.profileImg}"></div>
	            	</c:if>
		            <div class="col ho" id="dropMenu" >
		            	<c:if test="${!empty sVO.nickNm }">${sVO.nickNm }</c:if>
		            	<c:if test="${empty sVO.nickNm }">${sMid}</c:if>
		            	<i class="fa-solid fa-caret-down"></i>
		            </div>
	            </c:if>
	        </div>
	        <div class="list-group my-group">
	            <ul>
                	<c:if test="${sVO != null }">
		                <li class="list-group-item list-group-item-light"><a href="${ctp }/user/membership/${sVO.idx}">My 멤버십</a></li>
		                <li class="list-group-item list-group-item-light"><a href="${ctp }/review/list?kategorie=공지">공지사항</a></li>
		                <li class="list-group-item list-group-item-light"><a href="${ctp }/user/profile/${sVO.idx}">계정설정</a></li>
		                <c:if test="${sVO.membership == -1}">
			                <li class="list-group-item list-group-item-light"><a href="${ctp }/admin/main" target="_blank">관리자</a></li>
		                </c:if>
		                <li class="list-group-item list-group-item-light"><a onclick="return confirm('로그아웃 하시겠습니까?')" href="${ctp }/user/logout">로그아웃</a></li>
                	</c:if>
	            </ul>
	        </div>
	    </div>
	    <div>
	        <ul>
	            <li><a href="${ctp }/today">투데이</a></li>
                <li><a href="${ctp }/chart">차트</a></li>
                <li><a href="${ctp }/temp">DJ 스테이션</a></li>
                <li><a href="${ctp }/rank">이달의 노래</a></li>
            </ul>
            <c:if test="${sVO != null }">
	            <ul>
	                <div>보관함</div>
	                <li><a href="${ctp }/temp">믹스테잎</a></li>
	                <li><a href="${ctp }/artisttape">아티스트</a></li>
	                <li><a href="${ctp }/user/playlist">플레이리스트</a></li>
	                <li><a href="${ctp }/gift">받은노래</a></li>
	                <li><a href="${ctp }/song/mp3">구매한 MP3</a></li>
	            </ul>
            </c:if>
            <ul>
                <li><a href="${ctp }/myranking">#내돈내듣</a></li>
                <li><a href="${ctp }/intro">서비스 소개</a></li>
                <li><a href="${ctp }/review/list">사용자 리뷰</a></li>
                <li><a href="${ctp }/comming">커밍쑨 DDMusic</a></li>
            </ul>
        </div>
    </div>
</nav>