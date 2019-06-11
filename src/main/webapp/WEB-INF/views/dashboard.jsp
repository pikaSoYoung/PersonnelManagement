<!-- 메인 대시보드(만든이 : 유성실) -->
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>휴가관리</title>
<style>
.table > tbody > tr > td { 
	vertical-align: middle;
}
.table > tbody > tr > th { 
	vertical-align: middle;
}
</style>
<script type="text/javascript" src="https://www.amcharts.com/lib/3/amcharts.js"></script>
<script type="text/javascript" src="https://www.amcharts.com/lib/3/serial.js"></script>
<script type="text/javascript" src="https://www.amcharts.com/lib/3/themes/light.js"></script>
</head>
<body>
	<div class="main" style="min-height: 867px;">
		<div class="main-content">
			<div class="container-fluid">
				<form id="frm">
					<input type="hidden" name="empEmno" value="<%=(String)session.getAttribute("userEmno")%>"><!-- 사원번호 -->
					<input type="hidden" name="baseMonth"><!-- 시스템년월(YYYYMM) -->
				</form>
				
				<div class="row">
					<div class="col-md-7"><!-- START box1 -->
						<div class="panel panel-headline">
							<div class="panel-heading">
								<h3 class="panel-title" id="empName"></h3>
								<p class="panel-subtitle" id="clock"></p>
							</div>
							<div class="panel-body">
								<table class="table table-bordered table-striped" id="empInfoTable">
									<tbody>
										<tr>
											<th>사원번호</th>
											<td id="empEmno"></td>
											<th>입사일</th>
											<td id="empIncoDate"></td>
										</tr>
										<tr>
											<th>부서명</th>
											<td id="deptName"></td>
											<th>직위명</th>
											<td id="rankName"></td>
										</tr>
										<tr>
											<th>생년월일</th>
											<td id="empBday"></td>
											<th>전화번호</th>
											<td id="empTno"></td>
										</tr>
										<tr>
											<th>이메일주소</th>
											<td colspan="3" id="empEmail"></td>									
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div><!-- END box1 -->
			
					<div class="col-md-5"><!-- START box2 -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">부서 일정</h3>
							</div>
							<div class="some-content-related-div" style="position: relative; overflow: hidden; width: auto; height: 310px; margin-top:-25px">
								<div class="panel-body" id="scrollPanel" style="overflow: hidden; width: auto; height: 310px;">
									<ul class="list-unstyled todo-list" id="scheduleList">
									</ul>
									<button type="button" class="btn btn-primary btn-bottom center-block" onclick="goScheduleView()">달력 보기</button>
								</div>
								<div class="slimScrollBar" style="background: rgb(0, 0, 0); width: 7px; position: absolute; top: 0px; opacity: 0.4; display: none; border-radius: 7px; z-index: 99; right: 1px; height: 337.409px;"></div>
								<div class="slimScrollRail" style="width: 7px; height: 100%; position: absolute; top: 0px; display: none; border-radius: 7px; background: rgb(51, 51, 51); opacity: 0.2; z-index: 90; right: 1px;"></div>
							</div>
						</div>
					</div><!-- END box2 -->
				</div><!-- END row(box1,box2) -->

				<div class="row">
					<div class="col-md-6"><!-- START box3 -->
						<div class="panel">
							<div class="panel-heading">
								<h3 class="panel-title">오늘의 휴가자</h3>
							</div>
							<div class="panel-body no-padding">
								<table class="table table-striped tablesorter" id="vacTable">
									<thead style="display:table;width:100%;table-layout:fixed;">
										<tr>
											<th>사원번호</th>
											<th>성명</th>
											<th>부서</th>
											<th>휴가기간</th>
											<th>휴가구분</th>
										</tr>
									</thead>
									<tbody id="vacTbody" style="display:block;height:255px;overflow:auto;">
									</tbody>
								</table>
							</div>
						</div>
					</div><!-- END box3 -->					
					
					<div class="col-md-6"><!-- START box4 -->
						<div class="panel">
							<div class="panel-heading" style="margin-bottom: -20px;">
								<h3 class="panel-title" id="monthlyChartTitle"></h3>
							</div>
							<div class="panel-body">
								<div class="row">
									<div class="col-md-9" style="float:left">
										<div id="Monthlychartdiv" style="width: 100%; height: 350px; background-color: #FFFFFF;" ></div>	
									</div>
									<div class="col-md-3" style="padding-top:5px; padding-right:30px; display:inline-block">
										<div class="weekly-summary text-right">
											<span class="number" id="emreVacUd" style="font-weight:450">0</span>
											<span class="info-label">연차일수</span>
										</div>
										<div class="weekly-summary text-right">
											<span class="number" id="emrePvacUd" style="font-weight:450">0</span> 
											<span class="info-label">사용일수</span>
										</div>
										<div class="weekly-summary text-right">
											<span class="number" id="emreRemndrUd" style="font-weight:450">0</span> 
											<span class="info-label">잔여일수</span>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div><!-- END box4 -->
				</div><!-- End row(box3,box4) -->
			</div><!-- END container fluid -->
		</div><!-- END main content -->
	</div><!-- END main -->
</body>
<script>
	$(function(){
		
		$('input[name=baseMonth]').val(moment().format('YYYYMM')); //YYYYMM
		$('#monthlyChartTitle').html('연차 사용현황 ('+$('input[name=baseMonth]').val().substr(0,4)+')');
		printClock(); //현재시간
		empUserInfo(); //사원정보
		scheduleList(); //부서 일정 ajax
		vacTodayEmpList(); //오늘의 휴가자 ajax
		tablesorterFunc(); //테이블 정렬
		monthlyVacChart(); //월별 휴가사용개수 그래프 + ajax
		empVacInfo(); //사원휴가정보
	});
	
	function scrollFunc(){
		$('#scrollPanel').slimScroll({
			height: '310px',
	    alwaysVisible: true
		});
	}
	
	//인사 일정 달력으로 이동
	function goScheduleView(){ 
		window.location.href = "${pageContext.request.contextPath}/scheduleView.do";
	}
	
	function scheduleList(){
		paging.ajaxFormSubmit("scheduleList.exc", "frm", function(rslt){
			console.log("부서 일정:"+JSON.stringify(rslt));
			
			if(rslt.success == 'Y'){
		 		$.each(rslt.scheduleList, function(k, v) {
		 			$('#scheduleList').append(
						"<li>"+
							"<p style='margin-left:-30px'>"+
							"<span class='title'>"+v.depnTit+"</span>"+
							"<span class='short-description'>"+v.depnCntn+"</span>"+
							"<span class='date'>"+v.DepnDate+"</span>"+
							"</p>"+
						"</li>"
		 			);
		 		});
			}else{
				$('#scheduleList').append("<div class='text-center'><br><br><br><br>등록된 일정이 없습니다.<br><br></div>");
			}
		});
		scrollFunc(); //부서 일정 scroll
	}
	
	function printClock() { // 	출처: http:'//bbaksae.tistory.com/23 [QRD]
	    
	    var clock = document.getElementById("clock");            // 출력할 장소 선택
	    var currentDate = new Date();                                     // 현재시간
	    var calendar = currentDate.getFullYear() + "-" + (currentDate.getMonth()+1) + "-" + currentDate.getDate() // 현재 날짜
	    var amPm = 'AM'; // 초기값 AM
	    var currentYear = currentDate.getFullYear();
	    var currentMonth = currentDate.getMonth();
	    var currentdate = currentDate.getDate();
	    var currentHours = addZeros(currentDate.getHours(),2); 
	    var currentMinute = addZeros(currentDate.getMinutes() ,2);
	    var currentSeconds =  addZeros(currentDate.getSeconds(),2);
	    
	    if(currentHours >= 12){ // 시간이 12보다 클 때 PM으로 세팅, 12를 빼줌
	    	amPm = 'PM';
	    	currentHours = addZeros(currentHours - 12,2);
	    }

	    if(currentSeconds >= 50){// 50초 이상일 때 색을 변환해 준다.
	       currentSeconds = '<span style="color:#de1951;">'+currentSeconds+'</span>'
	    }
	    clock.innerHTML = currentYear+"."+currentMonth+"."+currentdate+"  "+currentHours+":"+currentMinute+":"+currentSeconds +" <span class='panel-subtitle'>"+ amPm+"</span>"; //날짜를 출력해 줌
	    
	    setTimeout("printClock()",1000);         // 1초마다 printClock() 함수 호출
	}

	function addZeros(num, digit) { // 자릿수 맞춰주기
		  var zero = '';
		  num = num.toString();
		  if (num.length < digit) {
		    for (i = 0; i < digit - num.length; i++) {
		      zero += '0';
		    }
		  }
		  return zero + num;
	}
	
	function empUserInfo(){
		paging.ajaxFormSubmit("empUserInfo.exc", "frm", function(rslt){
			console.log("사원 정보:"+JSON.stringify(rslt));
			
			$.each(rslt.empUserInfo, function(k, v) {
	 			$('#empName').html(v.empName+'님 환영합니다!');
	 			$('#empEmno').html($('input[name=empEmno]').val()); //사원번호
	 			$('#empIncoDate').html(v.empIncoDate); //입사일
	 			$('#deptName').html(v.deptName); //부서명
	 			$('#rankName').html(v.rankName); //직위명
	 			$('#empBday').html(v.empBday); //생년월일
	 			$('#empTno').html(v.empTno); //전화번호
	 			$('#empEmail').html(v.empEmail); //이메일주소
			});
	 		$('#empInfoTable').css('height','210px'); //테이블 높이
			$('#empInfoTable th').css('width','150px');
			$('#empInfoTable td').css('width','150px');
			$('#empInfoTable tr').children().addClass('text-center'); //테이블 내용 가운데 정렬
		});
	}

	function empVacInfo(){
		paging.ajaxFormSubmit("empVacInfo.exc", "frm", function(rslt){
			console.log("사원휴가정보:"+JSON.stringify(rslt));
			
			if(rslt.success == 'Y'){
		 		$.each(rslt.empVacInfo, function(k, v) {
		 			$('#emreVacUd').html(v.emreVacUd); //연차일수
		 			$('#emrePvacUd').html(v.emrePvacUd); //사용일수
		 			$('#emreRemndrUd').html(v.emreRemndrUd); //잔여일수
		 		});
			}else{
				$('#emreVacUd').addClass('text-danger'); //연차일수 색상 red로 변경
				$('#emrePvacUd').addClass('text-danger'); //사용일수 색상 red로 변경
				$('#emreRemndrUd').addClass('text-danger'); //잔여일수 색상 red로 변경
				$('#monthlyChartTitle').append(
					"&nbsp;&nbsp;&nbsp;"+
					"<div class='alert alert-danger' style='width:370px; display:inline-block; padding:8px;'>"+
						"<i class='fa fa-times-circle' style='font-size:80%;'></i>"+
						"<span style='font-size:13px'> 휴가일수가 설정되지 않았습니다. 관리자에게 문의하세요.</span>"+
					"</div>"
				);
			}
		});
	}
	
	//월별 휴가사용개수 그래프 ajax
	function monthlyVacChart(){
		paging.ajaxFormSubmit("monthlyVacChart.exc", "frm", function(rslt){
			console.log("휴가사용현황 그래프:"+JSON.stringify(rslt.monthlyVacChart));
			
			AmCharts.makeChart("Monthlychartdiv",{
				"type": "serial",
				"categoryField": "date",
				"dataDateFormat": "YYYYMM",
				"plotAreaBorderColor": "#666666",
				"borderColor": "#666666",
				"color": "#666666",
				"theme": "light",
				"categoryAxis": {
					"minPeriod": "MM",
					"parseDates": true
				},
				"chartCursor": {
					"enabled": true,
					"categoryBalloonDateFormat": "MMM YYYY",
					"cursorColor": "#666666"
				},
				"trendLines": [],
				"graphs": [
					{
						"fillAlphas": 0.7,
						"id": "allData",
						"lineAlpha": 0,
						"title": "전체 사원의 평균 연차 사용일",
						"valueField": "allData"
					},
					{
						"fillAlphas": 0.7,
						"id": "userData",
						"lineAlpha": 0,
						"title": "나의 연차 사용일",
						"valueField": "userData"
					}
				],
				"guides": [],
				"valueAxes": [
					{
						"dashLength": 2,
						"totalTextColor": "#666666",
						"color": "#666666",
						"gridColor": "#666666"
					}
				],
				"allLabels": [],
				"balloon": {},
				"legend": {
					"enabled": true,
					"align": "center"
				},
				"dataProvider": JSON.parse(JSON.stringify(rslt.monthlyVacChart))
			});
		});
	}

	//테이블 정렬
	function tablesorterFunc(){
		$("#vacTable").tablesorter();
		$("#vacTable").tablesorter({sortList: [[0,0], [1,0]]});
	}

	//오늘의 휴가자
	function vacTodayEmpList(){
		paging.ajaxSubmit("vacTodayEmpList.exc", "", function(rslt){
			console.log("오늘의 휴가자:"+JSON.stringify(rslt));
			
// 			$('#vacTable').children('thead').css('width','calc(100% - 1.1em)'); //테이블 스크롤 css

			if(rslt == null || rslt.success == "N"){
				$('#vacTable').children('tbody').append( //리스트가 없을 경우 : 조회된 데이터가 없습니다
	 				"<div class='text-center'><br><br><br>휴가자가 없습니다.</div>"
	 			);
			}else if(rslt.success == "Y"){
	 			$.each(rslt.vacTodayEmpList, function(k, v) {
	 				$('#vacTable').children('tbody').append(
						"<tr style='display:table; width:100%; table-layout:fixed; cursor:pointer;'>"+
			 				"<td>"+ v.empEmno +"</td>"+ //사원번호
			 				"<td>"+ v.empName +"</td>"+ //성명
			 				"<td>"+ v.deptName +"</td>"+ //부서
			 				"<td>"+ v.vastTerm +"</td>"+ //휴가기간
						"</tr>"
					);
	 				
	 				//연차 primary 반차 success 기타휴가 warning
	 				if(v.vastC == '연차'){ //연차
	 					$('#vacTable > tbody > tr:last').append(
	 						"<td><span class='label label-primary'>"+v.vastC+"</span></td>"
	 					);
	 				}else if(v.vastC == '반차'){ //반차
	 					$('#vacTable > tbody > tr:last').append(
		 					"<td><span class='label label-success'>"+v.vastC+"</span></td>"
		 				);
	 				}else if(v.vastC == '기타휴가'){ //기타휴가
	 					$('#vacTable > tbody > tr:last').append(
		 					"<td><span class='label label-warning'>"+v.vastC+"</span></td>"
		 				);
	 				}
	 			});
			}
			$('#vacTable tr').children().addClass('text-center'); //테이블 내용 가운데 정렬
		});
	}
</script>
</html>