<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<% pageContext.setAttribute("enter", "\n"); %>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>DD Music MemberShip</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <style>
    	#footer {
	 		background-color: lightgray;
    		text-align: center;
		    padding: 20px;
		    border-top: 1px solid rgb(179, 179, 179);
    	}
    
    	#title_search {
    		background: black;
    		color: white;
    		height: 60px;
    	}
    	
    	a {
		    text-decoration: none;
		    color: inherit;
		    opacity: 1;
		}

		a:hover {
		    text-decoration: none;
		    color: inherit;
		    opacity: 0.7;
		}
		
		h4{
			padding-top: 15px;
			margin-left: 20px;
		}
		
		.table {
			border-top: solid 2px;
		}
		
		#url {
			padding: 20px;
			border: 1px solid red;
			border-radius: 2px;
			color: red;
			background: white;
			margin: 15px 0;
			font-weight: 900;
		}
    	
    </style>
</head>
<body>
	<div id="title_search" >
	    <h4><a href="">DD Music</a></h4>
	</div>
    <div class="container mt-5">
    	<table class="table" style="margin-top: 100px;">
    		<tr style="height: 100px;">
    			<td style="font-size: 24px;"><b>My 멤버십</b></td>
    			<td colspan="2">
    				<div class="row">
    					<div class="col"></div>
	    				<div class="col"><button type="button" class="btn btn-secondary">결제(해지) 관리</button></div>
	    				<div class="col"><button type="button" class="btn btn-secondary" onclick="mebershipChage()">멤버십 변경</button></div>
	    				<div class="col"><button type="button" class="btn btn-secondary">구매내역</button></div>
    				</div>
    			</td>
    		</tr>
    		<tr>
    			<td>멤버십명</td>
    			<td>멤버십 혜택 기간</td>
    			<td>다음 결제일</td>
    		</tr>
    		<tr>
    			<td><c:if test="${vo.membership != 0}">DD Music 무제한 듣기 (${vo.membershipCnt }회차)</c:if></td>
    			<td><c:if test="${vo.membership != 0 }">${fn:substring(vo.membershipDate, 0, 10) } ~ ${fn:substring(vo.nextMembershipDate, 0, 10) }</c:if></td>
    			<td><c:if test="${vo.membership != 0 }">${fn:substring(vo.nextMembershipDate, 0, 10) }</c:if></td>
    		</tr>
    		<tr>
    			<td colspan="3">
    				<p>결제 수단의 문제로 정기결제가 ‘보류 중’인 경우, 결제 수단을 변경하시면 기존 이용하시던 모든 혜택이 그대로 유지됩니다.</p>
    				<p>멤버십을 변경 예약 하신 경우 ‘멤버십 변경 예약 중’으로 표기되며, 결제 예정일 전일까지 변경 취소가 가능합니다.</p>
    				<p>현재 보유한 멤버십의 사용 종료 후 ‘멤버십 변경 예약’이 이어서 반영되며, 예약은 1건만 가능합니다.</p>
    				&ensp;
    				<div class="jumbotron text-center mt-3">
    					<div style="font-size: 24px;"><b>DD Music 무료 혜택을 소문 내주세요!</b></div>
    					<div style="font-size: 20px;" class="mt-5">친구에게 추천하면 친구도 나도 <font color="red">네이버페이 3,000원씩 총 45,000원까지 적립</font>됩니다.</div>
    					<div id="url" class="container mt-5"><a href="">이 곳을 클릭하면 초대 URL이 생성됩니다.</a></div>
    					<div class="mt-5"><a href="">이벤트 자세히 보기></a></div>
    				</div>
				</td>
    		</tr>
    	</table>
    	<table class="table">
    		<tr style="height: 100px;"><td style="font-size: 24px;"><b>멤버십 혜택</b></td></tr>
    		<tr><td>혜택명</td></tr>
    		<tr><td>네이버 NOW. 다시보기 <span style="border: 1px solid red; color: red; border-radius: 1px; padding: 3px 5px;">Exclusive</span></td></tr>
    		<tr><td>노래방 모드 <span style="border: 1px solid red; color: red; border-radius: 1px; padding: 3px 5px;">Exclusive</span></td></tr>
    		<tr><td>MP3 구매 시 곡 당 100원 할인 <span style="border: 1px solid red; color: red; border-radius: 1px; padding: 3px 5px;">Exclusive</span></td></tr>
    	</table>
    </div>
 	<div id="footer"><jsp:include page="/WEB-INF/views/include/sFooter.jsp" /></div>	
    
    <script>
    	function mebershipChage() {
			if (confirm("무제한 듣기 월 6,900원(부가세 포함)에\n가입하시겠습니까?")) {
				
				$.ajax({
					type : "post",
					url : "${ctp}/user/membership/${vo.idx}",
					success : (data) => {
						if (data == "ok") {
							alert("결제했다 치고\n환영합니다 ${vo.nickNm}님\n가입 되셨습니다!");
							location.reload();
						}
					}
				});
			}
		}
    </script>

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>