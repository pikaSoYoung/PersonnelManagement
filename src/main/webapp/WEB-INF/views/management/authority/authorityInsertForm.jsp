<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="panel-heading">
	<h3 class="panel-title">${menuData.mnName}</h3>
</div>
<!-- 권한 상제 정보 등록  폼 시작-->
<div class="panel-body"> 
	<form id="insertForm" method="post">
		<input type="hidden" name="mnNo" value="${menuData.mnNo}"/>
		<input type="hidden" name="empEmno" value="${empEmno}"/>
		<table class="table table-bordered" style="width:100%;">
			<colgroup>
				<col width="16%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
				<col width="21%"/>
			</colgroup>
			<thead>
				<tr>
					<th class="text-center">권한 유형</th>
					<th class="text-center">적용 시작일</th>
					<th class="text-center">적용 종료일</th>
					<th class="text-center">수정가능 시작일</th>
					<th class="text-center">수정가능 종료일</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>
						<c:choose>
							<c:when test="${menuData.mnAttr=='view'}">
							<input type="checkbox" name="atrAttr" value="view" />
							<span>
								조회
							</c:when>
							<c:when test="${menuData.mnAttr=='insert'}">
							<input type="checkbox" name="atrAttr" value="insert" />
							<span>
								등록
							</c:when>
							<c:when test="${menuData.mnAttr=='update'}">
							<input type="checkbox" name="atrAttr" value="update" />
							<span>
								수정
							</c:when>
							<c:when test="${menuData.mnAttr=='delete'}">
							<input type="checkbox" name="atrAttr" value="delete" />
							<span>
								삭제
							</c:when>
							<c:otherwise>
          					<input type="checkbox" name="atrAttr" value="all" />
							<span>
								all
       						</c:otherwise>
						</c:choose>
						</span>
					</td>
					<td>
						<div class="input-group date datepicker strt">
							<input type="text" class="form-control" name="atrAplyStrt">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
					<td>
						<div class="input-group date datepicker fini">
							<input type="text" class="form-control" name="atrAplyFini">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
					<td>
						<div class="input-group date datepicker strt">
							<input type="text" class="form-control" name="atrUpdtStrt">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>
					<td>
						<div class="input-group date datepicker fini">
							<input type="text" class="form-control"  name="atrUpdtFini">
							<span class="input-group-addon">
								<span class="glyphicon glyphicon-calendar"></span> <!-- 달력 아이콘 -->
							</span>
						</div>
					</td>	
				</tr>		
			</tbody>
		</table>	
	</form> 
<!-- 권한 상제 정보 등록  폼 끝-->
<!-- 권한 상세 정보 등록 버튼 시작 -->	 
	<div class="text-right">
		<button type="button" name="authoInsertSubmit" class="btn btn-info">적용</button>
		<button type="button" name="authoEsc" class="btn btn-danger">취소</button> 
	</div>
<!-- 권한 상세 정보 등록 버튼 끝 -->	 
</div>
<form action="authorityDetail.do" id="hiddenForm" method="post">
	<input type="hidden" name="mnNo" value="${menuData.mnNo}"/>
	<input type="hidden" name="empEmno" value="${empEmno}"/>
</form>