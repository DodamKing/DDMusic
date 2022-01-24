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
	<title>글쓰기</title>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta2/css/all.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <link rel="stylesheet" href="${ctp }/resources/css/main.css?v=2">
    <script src="${ctp}/resources/ckeditor/ckeditor.js"></script>
</head>
<body>
	<jsp:include page="/WEB-INF/views/include/searchBar.jsp" />
	<jsp:include page="/WEB-INF/views/include/nav.jsp" />
	<jsp:include page="/WEB-INF/views/include/header_NV.jsp" />
	
	<section>
		<div class="container">
			<div class="card-body" style="padding-bottom: 100px;">
				<h2 class="mt-5 mb-5">사용자 리뷰 글쓰기</h2>
				<form method="post" name="myform">
					<select id="kategorie" name="kategorie" class="custom-select">
						<option value="자유">-- 분류 --</option>
						<c:if test="${sVO.membership == -1}"><option value="공지">공지</option></c:if>
						<option value="자유">자유</option>
						<option value="건의">건의</option>
						<option value="버그">버그</option>
						<option value="신청곡">신청곡</option>
					</select>
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<tr>
						</tr>
						<tr>
							<td><input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title" maxlength="50"></td>
						</tr>
						<tr>
							<td>
								<textarea class="form-control" placeholder="내용을 입력하세요" id="CKEDITOR" name="content" maxlength="2048" style="height: 400px;"></textarea>
								<script>
									CKEDITOR.replace("content", {
								  		uploadUrl: "${ctp}/review/imageUpload",
								  		filebrowserUploadUrl : "${ctp}/review/imageUpload",
								  		disallowedContent : 'img{width,height}',
								  		height: 400
									});
								</script>
							</td>
						</tr>
					</table>
					<input type="hidden" name="userIdx" value="${sVO.idx }">
					<input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>">
					<div class="row">
						<input type="button" class="btn btn-dark col-2 ml-3" value="등록" onclick="submitfn()">
						<div class="col"></div>
						<a onclick="return confirm('작성하던 게시글은 저장 되지 않습니다.\n정말 이동하시겠습니까?')" href="${ctp }/review/list" class="btn btn-dark col-2 mr-3">돌아가기</a>
					</div>
				</form>
			</div>
		</div>
		<jsp:include page="/WEB-INF/views/include/sFooter.jsp" />
    </section>
    

	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="${ctp }/resources/js/main.js?v=1"></script>
	
	<script>
		function submitfn() {
			if (confirm("작성 내용을 등록 하시겠습니까?")) {
				if (title.value.trim() == "") {
					alert("제목을 입력해 주세요.");
					return;
				}

				if (CKEDITOR.instances.CKEDITOR.getData() == "") {
					alert("내용을 입력해 주세요.");
					return;
				}
				
				$("form[name='myform']").submit();
			}
		}
		
		$("#title").keydown((e) => {
			if (e.keyCode == 13) {
				e.preventDefault();
			}
		});
		
		
	</script>
	
</body>
</html>