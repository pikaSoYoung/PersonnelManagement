<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.3.4/css/bootstrap2/bootstrap-switch.min.css"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-switch/3.3.4/js/bootstrap-switch.min.js"></script>
</head>
<body>
	<!-- Main -->
	<div class="main">
		<!-- Main Content -->
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">증명서 신청</h3>
				<!-- OverView -->
				<div class="row" id="crtfRequestEmpInfo">
					<div class="col-md-10">
						<div class="panel">
							<div class="panel-heading" style="padding-bottom:0px">
								<h4 class="panel-title" style="font-size:18px; padding-left:15px;">증명서 신청</h4>
							</div>
							<div class="panel-body">
								<form action="/spring/certificateInsert.do" id="crtfRequestForm">
									<table class="table" style="margin-bottom:0px">
										<tbody>
											<tr>
												<th>신청번호</th>
												<td><input type="text" name="crtfSeq" class="form-control" style="width:120px" disabled="disabled"></td>
												<th>증명서 구분</th>
												<td>
													<select name="crtfSelect" class="form-control" style="width:120px">
														<option value="default" selected>선택</option>
														<option value="재직증명서">재직증명서</option>
														<option value="경력증명서">경력증명서</option>
														<option value="퇴직증명서">퇴직증명서</option>
													</select>
												</td>
												<th>신청일자</th>
												<td><input type="text" name="crtfRequestDate" class="form-control" style="width:120px" readOnly></td>
											</tr>
											<tr>
												<th>사원번호</th>
												<td><input type="text" name="empEmno" class="form-control" style="width:120px" readOnly></td>
												<th>성명</th>
												<td><input type="text" name="empName" class="form-control" style="width:120px" readOnly></td>
												<th>발행일자</th>
												<td><input type="text" name="crtfInssueDate" class="form-control" style="width:120px" disabled="disabled"></td>
											</tr>
											<tr>
												<th>부서</th>
												<td><input type="text" name="deptName" class="form-control" style="width:120px" readOnly></td>
												<th>직급</th>
												<td><input type="text" name="rankName" class="form-control" style="width:120px" readOnly></td>
												<th>전자결제상태</th>
												<td><input type="text" name="crtfProgressSituation" class="form-control" style="width:120px" disabled="disabled"></td>
											</tr>
											<tr>
												<th>용도</th>
												<td colspan="5" style="padding-left:8px">
													<input type="text" name="crtfUse" class="form-control" style="width:700px" placeholder="해당 증명서의 용도를 반드시 기입하여 주십시오.">
												</td>
											</tr>
										</tbody>
									</table>
								</form>
								<div class="row">
									<div class="col-md-12 text-right">
										<button type="button" id="crtfRequestBtn" class="btn btn-primary">신청하기</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
						<div class="panel" id="crtfSearch">
							<div class="panel-heading" style="padding-bottom:0px">
								<h4 class="panel-title" style="font-size:18px; padding-left:15px;">증명서 신청내역 검색</h4>
							</div>
							<div class="panel-body">
								<div class="col-md-2">
									<select name="crtfSearchSelectLg" class="form-control" onChange="crtfSearchSelectChangeFunc()">
										<option value="default">선택</option>
										<option value="certificate">증명서</option>
										<option value="crtfProgressSituation">전자결제상태</option>
									</select>
								</div>
								<div class="col-md-2" id="crtfSearchSelectDiv2">
									<select name="crtfSearchSelectMd" class="form-control">
										<option value="default">선택</option>
									</select>
									
								</div>
								<div class="col-md-2">
									<button type="button" class="btn btn-primary" id="crtfSearchBtn">검색</button>
									<input type="checkbox" id="chk" data-toggle="toggle" data-on="승인완료" data-off="승인대기" data-size="small">
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="row">
					<div class="col-md-10">
						<div class="panel" id="crtfRequestList">
							<div class="panel-heading" style="padding-bottom:0px">
								<h4 class="panel-title" style="font-size:18px; padding-left:15px;">증명서 신청내역</h4>
							</div>
							<div class="panel-body">
								<table class="table table-hover">
									<thead>
										<tr>
											<th>신청번호</th>
											<th>사원번호</th>
											<th>성명</th>
											<th>증명서구분</th>
											<th>용도</th>
											<th>신청일자</th>
											<th>발행일자</th>
											<th>전자결제상태</th>
										</tr>
									</thead>
									<tbody>
										<!-- 증명서 신청내역 목록 -->
									</tbody>
								</table>
							</div>
						</div>					
					</div>
				</div>
				<!-- View Modal -->
				<div id="viewModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
  					<div class="modal-dialog">
    					<div class="modal-content">
     						<div class="modal-header">
								<h4 class="modal-title">증명서 상세보기</h4>
							</div>
							<div class="modal-body">
								<div class="row">
									<div class="col-md-10" style="padding-top:20px;">
										<form id="viewForm">
											<input type="hidden" name="crtfSeq" value="">
										<table class="table table-hover">
											<tbody>
												<tr>
													<th>증명서구분</th>
													<td>
														<select name="crtfSelect" class="form-control" style="width:120px" disabled="disabled">
															<option value="증명서종류">증명서종류</option>
															<option value="재직증명서">재직증명서</option>
															<option value="경력증명서">경력증명서</option>
															<option value="퇴직증명서">퇴직증명서</option>
														</select>
													</td>
												</tr>
												<tr>
													<th>사원번호</th>
													<td><input type="text" name="empEmno" value="" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>성명</th>
													<td><input type="text" name="empName" value="" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>부서명</th>
													<td><input type="text" name="deptName" value="" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>직위/직급</th>
													<td><input type="text" name="rankName" value="" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>용도</th>
													<td><input type="text" value="" name="use" class="form-control" size="20" readonly></td>
												</tr>
												<tr>
													<th>신청일자</th>
													<td><input type="text" name="requestDate" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>발행일자</th>
													<td><input type="text" name="issueDate" class="form-control" style="width:120px" readonly></td>
												</tr>
												<tr>
													<th>결제상태</th>
													<td><input type="text" name="progressSituation" class="form-control" style="width:120px" readonly></td>
												</tr>
											</tbody>
										</form>
									</table>
									<div class="modal-footer">
										<button type="button" id="viewBtn" class="btn btn-default">미리보기</button>
										<button type="button" id="deleteBtn" class="btn btn-default">삭제</button>
										<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
									</div>
									</div>
								</div>
							</div>	
    					</div>
  					</div>
				</div><!-- view Modal -->
			</div><!-- container-fluid -->
		</div><!-- Main Content -->
	</div><!-- Main -->
</body>
</html>