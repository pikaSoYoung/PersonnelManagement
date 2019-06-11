
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>휴일설정</title>
<!-- fullcalendar -->
<link href="/spring/resources/common/fullcalendar/css/fullcalendar.min.css" rel="stylesheet" />
<link href="/spring/resources/common/fullcalendar/css/fullcalendar.print.min.css" rel="stylesheet" media="print" />
<script src="/spring/resources/common/fullcalendar/js/moment.min.js"></script>
<script src="/spring/resources/common/fullcalendar/js/fullcalendar.min.js"></script>
<script src="/spring/resources/common/fullcalendar/js/ko.js"></script><!-- 한글패치 -->
<script src="/spring/resources/common/fullcalendar/js/gcal.js"></script><!-- 구글캘린더 -->
</head>
<body>
	<!-- MAIN -->
	<div class="main">
		<!-- MAIN CONTENT -->
		<div class="main-content">
			<div class="container-fluid">
				<h3 class="page-title">휴일설정</h3>
				<!-- OVERVIEW -->
				<div class="row">
					<div class="col-md-10">
						<div class="panel panel-headline">
							<div>
								<!-- Nav tabs -->
								<ul class="nav nav-tabs" role="tablist"
									id='fullcalrendar_vacMng'>
									<li role="presentation" class="active">
										<a class="calendar" href="#firstTab" aria-controls="home" role="tab" data-toggle="tab"> 달력</a>
									</li>
									<li role="presentation">
										<a class="tableCalendar" href="#secondTab" aria-controls="profile" role="tab" data-toggle="tab" >표</a>
									</li>
								</ul>


								<!-- Tab panes 탭 컨텐츠 -->
								<div class="tab-content">
									<!-- 첫번째 탭 시작(달력) -->
									<div role="tabpanel" class="tab-pane active" id="firstTab">
										<div class="row">
											<div class="col-md-10">
												<div class="panel">
													<div id="calendar"></div>
												</div>
											</div>
										</div>
										<!-- Date Insert Modal -->
										<div id="insertModal" class="modal fade">
											<div class="modal-dialog modal-md">
												<div class="modal-content">
													<div class="modal-header">
														<h4 class="modal-title">휴일 등록하기</h4>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="col-md-10" style="padding-top: 10px;">
																<form id="insertForm" method="post" class="form-inline">
																	<table class="table border-top separate">
																	<tr >
																		<td style="text-align: right" width="30%">날&emsp;&emsp;짜 :</td>
																		<td><div class="input-group date" id="crtDate">
																			<input type="text" class="form-control" id="startDate" name="startDate" value="" size="15">
																			<span class="input-group-addon">
																				<span class="glyphicon glyphicon-calendar"> </span> <!-- 달력 아이콘 -->
																			</span>
																		</div>
																		</td>
																	</tr>
																	<tr>
																		<td class="text-right" width="10%">일자 구분 :</td>
																		<td>
																		<select class="form-control" name="selectBox">
																			<option value="regualWork">정상근무</option>
																			<option value="unpaidDayoff">무급휴무일</option>
																			<option value="unpaidHoli">무급휴무</option>
																			<option value="paidHoli">유급휴일</option>
																		</select>
																		</td>
																	</tr>
																	<tr>
																		<td class="text-right"width="10%">휴일 구분 :</td>
																		<td>
																		<select class="form-control">
																			<option value="regualWork">선택</option>
																			<option value="regualWork">정기 공휴일</option>
																			<option value="unpaidDayoff">임시 공휴일</option>
																		</select>
																		</td>
																	</tr>
																	<tr>
																		<td class="text-right" width="10%">휴일 내용 :</td>
																		<td >
																			<div class="input-group">
						                                                         <input type="text" class="form-control w_100" name = "holiMemo" value="" size="15">
						                                                         <span class="input-group-addon"><i class="lnr lnr-cross" id="xbnt"></i></span>
						                                                      </div>
																		</td>
																	</tr>
																	</table>

																	<p>
																	<div class="ins-box mt10" >
																		<ul >
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 무급휴무일 : 근로의 의무, 출근할 의무가 없고 임금도 지급되지 않는 휴일</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> (취업규칙,단체협약등이 없다면 토요일은 무급휴무일)</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 무급휴일 : 근로의 의무가 있으나 취업규칙,단체협약 등을 통하여 무급으로 하고 쉬는 휴일</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 유급휴일 : 근로기준법 등에 의거 근로가 면제되는 날로 유급으로 하고 쉬는 휴일</li>
																		</ul>
																	</div>
																</form>

															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" id="insertBtn" class="btn btn-default" data-dismiss="modal">저장</button>
														<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
													</div>
												</div>
											</div>
										</div>
										<!-- Data View Modal -->
										<div id="viewModal" class="modal fade" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
											<div class="modal-dialog modal-md">
												<div class="modal-content">
													<div class="modal-header">
														<h4 class="modal-title">휴일 상세보기</h4>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="col-md-10" style="padding-top: 10px;">
																<form id="viewForm" method="post" class="form-inline">
																	<table class="table border-top separate">
																	<tr >
																		<td style="text-align: right" width="30%">날&emsp;&emsp;짜 :</td>
																		<td><div class="input-group date" id="crtDate">
																			<input type="text" class="form-control" id="startDate" name="startDate" value="" size="15">
																			<input type='hidden' id='aaa'>
																			<span class="input-group-addon">
																				<span class="glyphicon glyphicon-calendar"> </span> <!-- 달력 아이콘 -->
																			</span>
																		</div>
																		</td>
																	</tr>
																	<tr>
																		<td style="text-align: right"width="30%">일자 구분 :</td>
																		<td>
																		<select name="selectBox"class="form-control">
																			<option value="regualWork">정상근무</option>
																			<option value="unpaidDayoff">무급휴무일</option>
																			<option value="unpaidHoli">무급휴무</option>
																			<option value="paidHoli">유급휴일</option>
																		</select>
																		</td>
																	</tr>
																	<tr>
																		<td style="text-align: right"width="30%">휴일 구분 :</td>
																		<td>
																		<select class="form-control">
																			<option value="regualWork">선택</option>
																			<option value="regualWork">정기 공휴일</option>
																			<option value="unpaidDayoff">임시 공휴일</option>
																		</select>
																		</td>
																	</tr>
																	<tr>
																		<td style="text-align: right"width="30%">휴일 내용 :</td>
																		<td>
																			<div class="input-group">
						                                                         <input type="text" class="form-control w_100" name = "holiMemo" value="" size="15">
						                                                         <span class="input-group-addon"><i class="lnr lnr-cross" name="xbtn"></i></span>
						                                                      </div>
																		</td>
																	</tr>
																	</table>

																	<p>
																	<div class="ins-box mt10" >
																		<ul >
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 무급휴무일 : 근로의 의무, 출근할 의무가 없고 임금도 지급되지 않는 휴일</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> (취업규칙,단체협약등이 없다면 토요일은 무급휴무일)</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 무급휴일 : 근로의 의무가 있으나 취업규칙,단체협약 등을 통하여 무급으로 하고 쉬는 휴일</li>
																			<li style="font-size:10px"><i class="fa fa-exclamation-circle"></i> 유급휴일 : 근로기준법 등에 의거 근로가 면제되는 날로 유급으로 하고 쉬는 휴일</li>
																		</ul>
																	</div>
																</form>

															</div>
														</div>
													</div>
													<div class="modal-footer">
														<button type="button" id="updateBtn" class="btn btn-default" data-dismiss="modal">수정</button>
														<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
													</div>
												</div>
											</div>
										</div>
									</div>
									<!-- 두번째 탭 시작 -->
									<div role="tabpanel" class="tab-pane" id="secondTab">
										<div class="boxArea text-center"></div>
										<div class="panel-body mgu_15">
											<form class="form-inline" name="calendarTable" id="calendarTable">
												<table class="table table-bordered" name="calendarTableOption" id="calendarTableOption" >
													<!--  <thead> -->
													<thead id="thead" style="display:table;width:100%;table-layout:fixed;">
														<tr>
															<th style="width:6%;">
																<label class="fancy-checkbox-inline">
																	<input type="checkbox" id="CalendarTableSelectAll_chk" onClick="CalendarTableSelectAll()"><span></span>
																</label>
															</th>
															<th >날짜</th>
															<th >휴가 구분</th>
															<th >휴일 내용</th>
														</tr>
													</thead>
													<tbody  id="tbody" style="display:block;height:400px;overflow:auto;">
													</tbody>
												</table>
											</form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
