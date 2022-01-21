<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="<%=request.getContextPath() %>" />
<style>
	i.fa-magnifying-glass:hover {
		cursor: pointer;
	}
</style>
<div id="title_search" class="row">
    <h4 class="col"><a href="${ctp }/today">DD Music</a></h4>
    <div id="main_srch" class="col-1"><i class="fa-solid fa-magnifying-glass"></i></div>
</div>