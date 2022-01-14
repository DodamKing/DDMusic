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
					<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
						<tbody>
							<tr>
								<td><input type="text" class="form-control" placeholder="제목을 입력하세요" id="title" name="title" maxlength="50"></td>
							</tr>
							<tr>
								<td>
									<textarea class="form-control" placeholder="내용을 입력하세요" id="CKEDITOR" name="content" maxlength="2048" style="height: 400px;"></textarea>
									<script>
										CKEDITOR.replace("content", {
											height : 460
									  		/* uploadUrl: "${ctp}/imageUpload",
									  		filebrowserUploadUrl : "${ctp}/imageUpload",
									  		height:460 */
									  	});
									</script>
								</td>
							</tr>
						</tbody>
					</table>
					<input type="hidden" name="userIdx" value="${sVO.idx }">
					<input type="hidden" name="hostIp" value="<%=request.getRemoteAddr()%>">
					<a onclick="return confirm('작성하던 게시글은 저장 되지 않습니다.\n정말 이동하시겠습니까?')" href="${ctp }/review" class="btn btn-dark">돌아가기</a>
					<input type="button" class="btn btn-dark pull-right" value="등록" onclick="submitfn()">
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
				
				
				
				myform.submit();
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