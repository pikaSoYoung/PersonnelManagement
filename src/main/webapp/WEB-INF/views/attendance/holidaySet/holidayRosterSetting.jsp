
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script src="/spring/resources/common/js/pagingNav.js"></script>
<script src="/spring/resources/common/management/js/menuTree.js"></script>

</head>

<script type="text/javascript">
// 	$(function () {
// 		//$('#btstBtStartDate').val(moment().format('YYYY-MM-DD')); //출장신청일
// 		$('#rosterStartDate').val(moment().format('YYYY-MM-DD')); //출장종료일
// 		$('#rosterYearMonthStart').datetimepicker({ //신청년월 시작 달력
// 			viewMode: 'days',
// 			format: 'YYYY-MM-DD'
// 		});
		
// 	});//function

	function submitButton(){
		var year = $("select[name=rosterYear]").val();
		var month = $("select[name=rosterMonth]").val();
		var day = "1";
		
		var rosterDate = new Date(year, (month -1), "1");
		
		console.log("rosterDate : " + rosterDate);
		
		var yearMonth = rosterDate.getFullYear() + '-' + ((rosterDate.getMonth()+1)<10 ? '0' + (rosterDate.getMonth()+1) : (rosterDate.getMonth()+1)) + '-' +
        (rosterDate.getDate()<10 ? '0'+rosterDate.getDate() : rosterDate.getDate());
		
		$("input[name='yearMonth']").val(yearMonth);
		
		console.log("yearMonth : " + $("input[name='yearMonth']").val());
		
		$("form[name='rosterSetting']").submit();
// 		$("form[name='hiddenForm']").submit();
	}
	
	var searching =false; //검색 활성화 값 boolean
	var searchCnd; //검색 옵션
	var searchWd; //검색 text
	var workerCode = [];	
	var workerName = [];
	
	$(document).ready(function(){
		empListPrint(); //사원리스트 출력 함수 호출
		searchEvent(); //검색 이벤트 함수 호출
	});
	
	//검색 이벤트 발생 시 유효성 검사 후 검색 리스트 출력 함수 호출
	var searchEvent = function(){
		$("button[name='searchBtn']").on('click',function(){
			
			if(!$("[name='searchCnd']>option").index($("[name='searchCnd']>option:selected"))){
				alert("option을 선택해주세요"); 
			}else if($("[name='searchWd']").val()==""){
				alert("검색내용이 없습니다");
			}else{
				searching = true;
				searchStart();
			}//유효성 검사 후 리스트 출력 함수 호출if else
			
		});//onclick
	}//searchEvent
	
	//리스트 전 처리 후 출력 함수 호출 
	var searchStart =function(choicePage){
		if(searching){
			searchCnd  = $("[name='searchCnd'] option:selected").val();
			searchWd = $("input[name='searchWd']").val();
		}//if
		empListPrint(searchCnd,searchWd,choicePage); //리스트 출력함수 호출
	}//searchStart
		
	//리스트 출력 함수
	var empListPrint = function(searchCnd,searchWd,choicePage){
		
		if(choicePage==undefined){
			choicePage = 1;
		}//선택 페이지값이 들어오지 않은 경우 if
		
		if(searchCnd==undefined){
			searchCnd = "";
		}//검색 옵션 값이 들어오지 않은 경우 if
		
		if(searchWd==undefined){
			searchWd = "";
		}//검색 text 값이 들어오지 않은 경우 if
		
		var url = "empList.ajax"; //data를 보낼 url
		var data = {"choicePage":choicePage, searchCnd:searchCnd, searchWd:searchWd, }; //보낼데이터
		var str=""; //append 시킬 string 저장 변수
		var thisList; //사원리스트 저장변수
		
		//paging.ajaxSubmit 호출
		paging.ajaxSubmit(url,data,function(result){
			
			thisList = result.empList;
			
			if(thisList!=null){
				$.each(thisList,function(index){
					str += "<tr style='cursor:pointer'>";
					str += "<td><label class='fancy-checkbox-inline'><input type='checkbox' id='chk' name='chk'><span></span></label></td>";
					str += "<td>"+thisList[index].deptName+"</td>";
					str += "<td>"+thisList[index].rankName+"</td>";
					str += "<td name='empEmno'>"+thisList[index].empEmno+"</td>"
					str += "<td>"+thisList[index].empName+"</td>";
				});//each
				
				$("tbody").children().remove();
				$("tbody").append(str);
				
				$('input:checkbox[name="chk"]').each(function(){
					
					var progTr = $(this).parent().parent().parent();
					var progTd = progTr.children().eq(3);
					var empEmno = progTd.text();
					
					console.log(workerCode);
					
					for(var i = 0 ; i < workerCode.length ; i++){
						
// 						console.log($(this));
						if(empEmno == workerCode[i]){
							$(this).prop("checked", true);
						}
					}
				});
				
				checkSave();
				
				var obj = {"totalNoticeNum":result.totalNoticeNum,"choicePage":choicePage};
				$("nav[name='pagingNav']").pagingNav(obj,"pageClick");
			}//if
			
		});//paging.ajaxSubmit	
	};//empListPrint
	
	//paging 처리 
	var pageClick = function(target){
		console.log(target);
		//searching = false;
		searchStart(target.attr("name"));
		
	}//pageClick
	
	//
	var checkSave = function(){
		
		//사원 리스트 checkbox에 이벤트 등록
		$('input:checkbox[name="chk"]').on("click",function(){
			var progTr = $(this).parent().parent().parent();
			var progTd = progTr.children().eq(3);
			var empEmno = progTd.text();
			progTd = progTr.children().eq(4);
			var empName = progTd.text();
			
			//체크되어있는지 확인
			if($(this).prop('checked')){
				//배열 안에 체크박스 체크되어있으면 배열안에다가 사번 push함.
// 				for(var i = 0 ; i < hiddenResult.length ; i++){
// 					if(empEmno != hiddenResult[i]){
// 						hiddenResult.push(empEmno);
// 					}
// 				}
				workerCode.push(empEmno);
				workerName.push(empName);
			}else{
				//체크를 해제하면 배열안에서 지워줌.
				workerCode.splice(workerCode.indexOf(empEmno),1);
				workerName.splice(workerName.indexOf(empName),1);
			}
			
			$("input[name='empEmno']").val(workerCode);
			$("input[name='empName']").val(workerName);
			
			console.log($("input[name='empName']").val());
		});
	
	}//detailEvent
	
</script>

<body>

<div class="main">
	<div class="main-content">
		<div class="container-fluid">
			<h3 class="page-title">근무표 생성</h3>
			
			<div class="panel panel-headline">
				<div class="panel-heading">
					<h4 class="panel-title" style="font-size:20px; padding-left:15px;">근무표 생성 연도와 달을 선택하세요.</h4>
				</div>
			
				<div class="panel-body">
<!-- 					<div class="input-group date" id="rosterYearMonthStart"> -->
<!-- 					<input type="text" class="form-control" id="rosterStartDate" name="rosterStartDate"/> -->
<!-- 					<span class="input-group-addon"> -->
<!-- 						<span class="fa fa-calendar" > -->
<!-- 						</span> -->
<!-- 					</span> -->
<!-- 					</div> -->
						<select id="rosterYear" name="rosterYear">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
						</select>년
						
						<select id="rosterMonth" name="rosterMonth" class="w_40 mgb_5">
							<option value="1">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
							<option value="6">6</option>
							<option value="7">7</option>
							<option value="8">8</option>
							<option value="9">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>월
				</div>
				
				<div class="panel-heading">
					<h4 class="panel-title" style="font-size:20px; padding-left:15px;">근무자 수</h4>
					각 요일별 근무자 수 배정 기준을 입력합니다.	<br>
					D : Day E : Evening N : Night
				</div>
				
				<form action="holidayRosterSettingDBInsert" method="post" id="rosterSetting" name="rosterSetting">			
				<div class="panel-body">
					휴　일 - D : 
					<select name="holidayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="holidayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N : 
					<select name="holidayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					월요일 - D : 
					<select name="MondayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="MondayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="MondayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					화요일 - D : 
					<select name="TuesdayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="TuesdayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="TuesdayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					수요일 - D : 
					<select name="WednesdayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="WednesdayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="WednesdayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					목요일 - D : 
					<select name="ThursdayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="ThursdayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="ThursdayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					금요일 - D : 
					<select name="FridayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="FridayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="FridayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					토요일 - D : 
					<select name="SaturdayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="SaturdayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="SaturdayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
					
					일요일 - D : 
					<select name="SundayD" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					E : 
					<select name="SundayE" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					N :
					<select name="SundayN" class="w_40 mgb_5">
						<option value="zero">0</option>
						<option value="one">1</option>
						<option value="two">2</option>
						<option value="three">3</option>
						<option value="four">4</option>
						<option value="five">5</option>
						<option value="six">6</option>
						<option value="seven">7</option>
						<option value="eight">8</option>
						<option value="nine">9</option>
						<option value="ten">10</option>
					</select>
					<br>
				</div>
				<input type="hidden" name="empName">
				<input type="hidden" name="yearMonth">
				</form>	
				
				<div class="panel-heading">
					<h4 class="panel-title" style="font-size:20px; padding-left:15px;">근무 투입 인원 검색</h4>
				</div>
				<div class="panel-body">
					<div class="col-md-2">
						<select name="searchCnd" class="form-control">
							<option value="all">전체</option>
							<option value="deptName" <c:out value="${searchCnd eq 'deptCode' ? 'selected' : ''}"/>>부서명</option>
						</select>
					</div>
					<div class="input-group">
						<input type="text" name="searchWd" class="form-control" value="${searchWd}">
						<span class="input-group-btn">
							<button type="button" class="btn btn-primary" name="searchBtn">검색</button>
						</span>
					</div>
				</div>
				
			</div>
			
			<div class="panel">
				<div class="panel-heading">
					<div class="row">
						<div class="panel-body">
							<table name="empTable" class="table table-hover text-center">
								<thead>
									<tr>
										<th class="text-center">선택</th>
										<th class="text-center">부서명</th>
										<th class="text-center">직책</th>
										<th class="text-center">사원코드</th>
										<th class="text-center">사원명</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
							<!-- 페이징 네비게이션 시작 -->
							<nav name="pagingNav" aria-label='Page navigation example' align='center'>
							</nav>
							<!-- 페이징 네비게이션 끝 -->
						</div>
						<input type="button" class="btn btn-primary" name="makeBtn" value="만들기" onClick="submitButton()">
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- hidden form start-->
<!-- 	<form action="authorityDetail.do" name="hiddenForm" method="post"> -->
<!-- 		<input type="hidden" name="empEmno"> -->
<!-- 	</form> -->

	<input type="hidden" name="empEmno">

<!-- 	<form action="holidayRosterSettingDBInsert" id="hiddenForm" name="hiddenForm" method="post"> -->
<!-- 		<input type="hidden" name="empName"> -->
<!-- 		<input type="hidden" name="yearMonth"> -->
<!-- 	</form> -->
	<!-- hidden form end-->
	
</div>

</body>
</html>