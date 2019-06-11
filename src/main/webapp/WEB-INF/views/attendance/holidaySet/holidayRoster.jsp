<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<link rel="stylesheet" href="/spring/resources/common/css/demo.css">
<link type="text/css" rel="stylesheet" href="/spring/resources/common/helpers/demo.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/helpers/media/layout.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/helpers/media/elements.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/areas.css?v=3110" />    
        
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/month_white.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/month_green.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/month_transparent.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/month_traditional.css?v=3110" />      
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/navigator_8.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/navigator_white.css?v=3110" />        
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/calendar_transparent.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/calendar_white.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/calendar_green.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/calendar_traditional.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_8.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_white.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_green.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_blue.css?v=3110" />    
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_traditional.css?v=3110" />
<link type="text/css" rel="stylesheet" href="/spring/resources/common/themes/scheduler_transparent.css?v=3110" />    

<script src="/spring/resources/common/js/daypilot-all.min.js?v=3110" type="text/javascript"></script>
<script src="/spring/resources/common/js/JMap.js"></script>

<style>
    .scheduler_default_cellparent, .scheduler_default_cell.scheduler_default_cell_business.scheduler_default_cellparent  {
        background: #ddd;
    }

</style>

<body>

<!-- INSERT MODAL -->
<div id="insertModal" class="modal fade" role="dialog">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" onClick="hideModal()">&times;</button>
				<h4 class="modal-title">근무 순서</h4>
			</div>
			<div class="modal-body">
				<div class="row">
					<div class="col-md-11" style="padding-top:20px;">
						<form action="/spring/commonInsert.do" id="insertForm">
							<table class="table" align="center">
								<tr>
									<td style="width:120px"> &nbsp;근무순서</td>
									<td>
										<div class="col-md-5">
											<label for="inputRoster"></label><i class="fa fa-minus-circle" onClick = "removeArray()"></i>
										</div>
									</td>
								</tr>
								<tr>
									<td> &nbsp;근무정보</td>
									<td>
										<div class="col-md-5">
											<input type="radio" name="rosterRadioButton" value="day" id="day">주간 <label for="day"></label>
											<br><input type="radio" name="rosterRadioButton" value="night" id="night">야간<label for="night"></label>
											<br><input type="radio" name="rosterRadioButton" value="evening" id="evening">심야<label for="evening"></label>
										</div>
									</td>
								</tr>
<!-- 								<tr> -->
<!-- 									<td> &nbsp;dsd</td> -->
<!-- 									<td> -->
<!-- 										<div class="col-md-5" id = "rosterTime"> -->
										
<!-- 										</div> -->
<!-- 									</td> -->
<!-- 								</tr> -->
							</table>
						</form>
					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" id="applyBtn" class="btn btn-default" onClick="addBtn()">추가</button>
				<button type="button" id="insertBtn" class="btn btn-default" onClick = "applyBtn()">적용</button>
				<button type="button" class="btn btn-default" onClick = "hideModal()">닫기</button>
			</div>
		</div>
	</div>
</div>

<div class="main">
	<div class="main-content">
		<div class="container-fluid">
			<c:forEach items="${infoMap }" var = "item">	
				<c:choose>
					<c:when test="${item.key=='yearMonth' }">
						<input type="hidden" name="yearMonth" value="${item.value }">
					</c:when>
					
					<c:when test="${item.key=='empName' }">
						<input type="hidden" name="empName" value="${item.value }"> 
					</c:when>
				</c:choose>
			</c:forEach>
			<input type="hidden" name="events"> 
			<input type="hidden" name="days">
			
			<div class="panel panel-headline">
				<div class="panel-heading">
					<h4 class="panel-title" style="font-size:20px; padding-left:15px;">근무표 생성 연도와 달을 선택하세요.</h4>
				</div>
			
				<div class="panel-body">
				<select id="rosterYear" name="rosterYear" onchange="changeList()">
							<option value="2016">2016</option>
							<option value="2017">2017</option>
							<option value="2018">2018</option>
							<option value="2019">2019</option>
						</select>년
						
						<select id="rosterMonth" name="rosterMonth" class="w_40 mgb_5" onchange="changeList()">
							<option value="01">1</option>
							<option value="02">2</option>
							<option value="03">3</option>
							<option value="04">4</option>
							<option value="05">5</option>
							<option value="06">6</option>
							<option value="07">7</option>
							<option value="08">8</option>
							<option value="09">9</option>
							<option value="10">10</option>
							<option value="11">11</option>
							<option value="12">12</option>
						</select>월
				</div>
			</div>
			
			<div style="padding-top:40px"></div>
			<div id="dp"></div>
			
			<input type="hidden" name="rosterStartSubOne" value="">
			<input type="hidden" name="rosterMakeFlag" value="">
			<input type="hidden" name="selectNumber" value="">
			<input type="hidden" name="hiddenNotChangeRosterOrder" value="">
			<input type="hidden" name="hiddenRosterOrder" value="">
			<input type="hidden" name="dbRosterInsert" value="">
			<input type="hidden" name="empName2" value="">
			<input type="hidden" name="yearMonth2" value="">
			<input type="button" name="saveBtn" class="btn btn-primary" value="저장하기" onClick="saveRosterBtn()">
			<input type="button" id="selectRosterMake" onClick="insertModalOpen()" name="selectRosterMake" class="btn btn-primary" value="선택 인원 근무 생성">
		</div>
	</div>
</div>

<!-- data-toggle="modal" data-backdrop="static" data-target="#insertModal" -->

<script type="text/javascript">
    var dp;
    var options;
    var option2;
    var jArray;
    var ojb;
    var empName;
    var yearMonth;
    var empName;					//input hidden(emppName1,2)에 값을 넣어주기 위해 만들어준 변수
	var yearMonth;					//input hidden(yearMonth1,2)에 값을 넣어주기 위해 만들어준 변수
	var rosterResult = "";
	var rosterOrderArray = new Array();
	var rosterOrderNotChangeArray = new Array();
    
	function removeArray(){
		rosterOrderArray.splice(rosterOrderArray.length-1 ,1);
// 		rosterOrderNotChangeArray.splice(rosterOrderNotChangeArray.length-1, 1);
		
		$("label[for='inputRoster']").text(rosterOrderArray);
	}
	
	function hideModal(){
// 		console.log("test222 : " + $("input[name='hiddenNotChangeRosterOrder']").val());
		
		rosterOrderArray = [];
		rosterOrderNotChangeArray = [];
		
		$("input[name='hiddenRosterOrder']").val(rosterOrderArray);
// 		$("input[name='hiddenNotChangeRosterOrder']").val(rosterOrderNotChangeArray);
		
		$("label[for='inputRoster']").text("");
		
		$("#insertModal").modal('hide');
	}
	
	function applyBtn(){
		console.log("rosterOrderArray길이 : " + rosterOrderArray.length);
		
		
		if(rosterOrderArray.length == 0){
			alert("최소 하나 선택하세요");
			
			$("input[name='rosterMakeFlag']").val("flase");
			
		}else{
			$("input[name='rosterMakeFlag']").val("true");
			$("input[name='hiddenRosterOrder']").val(rosterOrderArray);
// 			$("input[name='hiddenNotChangeRosterOrder']").val(rosterOrderNotChangeArray);
		
			console.log("test : " + $("input[name='hiddenRosterOrder']").val());
		
			rosterOrderArray = [];
			rosterOrderNotChangeArray = [];
		
			$("label[for='inputRoster']").text("");
		
			$("#insertModal").modal('hide');
		}
	}
	
	function addBtn(){
		var checkedValue = $("input[type=radio][name=rosterRadioButton]:checked").val();
		
		if(rosterOrderArray.length < 3){
// 			rosterOrderNotChangeArray.push(checkedValue);
// 			if(checkedValue == "C2016-03-01D"){
// 				checkedValue = "주";
// 			}else if(checkedValue == "C2016-03-01N"){
// 				checkedValue = "야";
// 			}else if(checkedValue == "C2016-03-01E"){
// 				checkedValue = "심";
// 			}
			
			rosterOrderArray.push(checkedValue);
		}
		var rosterChangeLetter = new Array();
// 		$("input[name='dbRosterInsert']").val(JSON.stringify(resultArray));
		
		$("input[name='hiddenRosterOrder']").val(rosterOrderArray);
// 		$("input[name='hiddenNotChangeRosterOrder']").val(rosterOrderNotChangeArray);
		
		for(var i = 0 ; i < rosterOrderArray.length; i++){
			var tmp = rosterOrderArray[i];
			
			if(tmp == "C2016-03-01D"){
				tmp = "주";
			}else if(tmp == "C2016-03-01N"){
				tmp = "야";
			}else if(tmp == "C2016-03-01E"){
				tmp = "심";
			}
			
			rosterChangeLetter.push(tmp);
		}
		
		console.log("배열2: " + $("input[name='dbRosterInsert']").val());
		
		$("label[for='inputRoster']").text(rosterChangeLetter);
		
	}
	
	function timeInsert(time){
		time = time.substring(1, time.length-1);
		
		console.log("시간3 : " + time);
		
		return time;
	}
	
	function insertModalOpen(){
		if($("input[name='selectNumber']").val() > 0){
			$("#insertModal").modal({backdrop: 'static', keyboard: false});
		}else{
			alert("인원을 선택해주세요");
		}
		
		var standardTime;
		
		console.log("hh : " + $("input[name='hiddenRosterOrder']").val());
		
		if($("input[name='yearMonth']").val() == undefined){
			standardTime = $("input[name='yearMonth2']").val();
		}else{
			standardTime = $("input[name='yearMonth']").val();
		}
		
		console.log("standardTime : " + standardTime);
		
		var dataObj = {"standardTime" : standardTime};
		
		paging.ajaxSubmit("/spring/rosterTime.ajax", dataObj, function(result){
			var resultArray = new Array();
			var resultObj = new Object;
			$("input[name='dbRosterInsert']").val(result);
			
			for(var i = 0 ; i < result.length ; i++){
				resultObj.SHWK_SHF_TYPE = result[i].SHWK_SHF_TYPE;
				resultObj.SHWK_SHF_IN_TIME = result[i].SHWK_SHF_IN_TIME;
				resultObj.SHWK_SHF_C = result[i].SHWK_SHF_C;
				rosterOrderNotChangeArray.push(result[i].SHWK_SHF_C + "/" + result[i].SHWK_SHF_TYPE);
				resultObj.SHWK_START_DATE = result[i].SHWK_START_DATE;
				resultObj.SHWK_END_DATE = result[i].SHWK_END_DATE;
				resultObj.SHWK_SHF_OUT_TIME = result[i].SHWK_SHF_OUT_TIME;
				
				resultArray.push(resultObj);
				
				resultObj = {};
				
			}
			
			$("input[name='hiddenNotChangeRosterOrder']").val(rosterOrderNotChangeArray);
			$("input[name='dbRosterInsert']").val(JSON.stringify(resultArray));
			
			console.log("test333 : " + $("input[name='hiddenNotChangeRosterOrder']").val());
			console.log("dbRosterInsert10 : " + $("input[name='dbRosterInsert']").val());
			
			var content = $("input[name='dbRosterInsert']").val();
			content = JSON.parse(content);
			
			for(var i = 0 ; i < content.length ; i++){
				var rosterStartEndTime = timeInsert(JSON.stringify(content[i].SHWK_SHF_IN_TIME)) + "-" + timeInsert(JSON.stringify(content[i].SHWK_SHF_OUT_TIME));
				var code = content[i].SHWK_SHF_C;
				code = code.substring(code.length-1);

				if(code == "D"){
					$("#day").val(content[i].SHWK_SHF_C);
					$("label[for='day']").text(rosterStartEndTime);
				}else if(code == "E"){
					$("#evening").val(content[i].SHWK_SHF_C);
					$("label[for='evening']").text(rosterStartEndTime);
				}else if(code == "N"){
					$("#night").val(content[i].SHWK_SHF_C);
					$("label[for='night']").text(rosterStartEndTime);
				}
			}
			
    	});
	}
	
	function validate(){	
		//일반사원은 근무표만 볼수있으면 되기때문에 디비에서 값을 가지고옴. ajax로 동기화 통신을 해서 값을 가지고오는중. 
		//비동기로 하면 값을 못 읽어들이기 때문에 동기로 처리해줌.
    	paging.ajaxSubmit("/spring/holidayRosterList.ajax", "", function(result){
    		$('input[name=empName2]').val(result.empName);
			$('input[name=yearMonth2]').val(result.yearMonth);
			console.log("ss : " + result.empName);
    	}, false);
    	
    	//관리자는 Setting 페이지로 들어오고 컨트롤러에서 @ResponseBody로 값이 전해져 온거라서 input name=empName이 생기는데 일반사원은
    	//Roster로 들어와서 input name=empName이 안생기기때문에 empName2를 사용해야함.
    	if($('input[name=empName]').val() == undefined){
    		empName = $('input[name=empName2]').val();
     		yearMonth = $('input[name=yearMonth2]').val();
    	}else{
    		empName = $('input[name=empName]').val();
     		yearMonth = $('input[name=yearMonth]').val();
    	}
    	
    	var year = yearMonth.substring(0,4);
    	var month = yearMonth.substring(5,7);
    	var day = yearMonth.substring(8,10);
    	
    	$("#rosterYear").val(year).attr("selected", "selected");
    	$("#rosterMonth").val(month).attr("selected", "selected");
    	
    	var tmpYearMonth = new Date(year, month-1, day);
    	tmpYearMonth.setDate(tmpYearMonth.getDate() - 5);
    	
    	yearMonth = tmpYearMonth.getFullYear() + '-' + ((tmpYearMonth.getMonth()+1)<10 ? '0' + (tmpYearMonth.getMonth()+1) : (tmpYearMonth.getMonth()+1)) + '-' +
        (tmpYearMonth.getDate()<10 ? '0'+tmpYearMonth.getDate() : tmpYearMonth.getDate());
    	
 		//empName이 ex)[김재우, 박민찬, 진두환] 이런형식으로 있기때문에 이름 하나만 이용하려면은 split으로 짤라주어야함. 그거를 배열로 만든거.
 		var empNameArray = empName.split(",");
 		obj = new Object();
		jArray = new Array();
 		
		//배열을 하나 만들어줘서 배열에 계속 저장
 		for(var i = 0 ; i < empNameArray.length ; i++){
 			obj.name = empNameArray[i];
 			obj.id = empNameArray[i];
 			jArray.push(obj);
			obj = {};
 		}
		
// 		console.log(jArray);
		
// 		console.log(empName);
// 		console.log(yearMonth);
		
		options = {
            startDate: "",
            days: "",
            scale: "Day",
            timeHeaders: [
                { groupBy: "Month", format: "MMM yyyy" },
                { groupBy: "Cell", format: "ddd d" }
            ],
            treeEnabled: true,
            resources: [
//                 { name: "Room A", id: "A", expanded: true, children:[
//                     { name : "Room A.1", id : "A.1" },
//                     { name : "Room A.2", id : "A.2" }
//                 ]
//                 },
//                 { name: "Room B", id: "2" },
//                 { name: "Room C", id: "3" },
//                 { name: "Room D", id: "4" },
//                 { name: "Room E", id: "5" },
//                 { name: "Room F", id: "6" },
//                 { name: "Room G", id: "7" },
//                 { name: "Room H", id: "H" },
//                 { name: "Room I", id: "I" },
//                 { name: "Room J", id: "J" },
//                 { name: "Room K", id: "K" },
             ],

            events: [
//                  {
// 				start: "2015-12-28T00:00:00",
// 	            end: "2015-12-29T12:00:00",
// 	            id: DayPilot.guid(),
// 	            resource: "강병욱",
// 	            text: "Event"
//                  },
// 				{
// 					start: "2014-01-25T00:00:00",
//                     end: "2014-01-26T00:00:00",
//                     id: DayPilot.guid(),
//                     resource: "신지연",
//                     text: "D"
// 				}
            ],

            // event moving
            onEventMoved: function (args) {
                dp.message("Moved: " + args.e.text());
                //$("input[name='events']").val(JSON.stringify(options.events));
            },

            // event resizing
            onEventResized: function (args) {
                dp.message("Resized: " + args.e.text());
                //$("input[name='events']").val(JSON.stringify(options.events));
            },

            // event creating
            onTimeRangeSelected: function (args) {
                var name = prompt("New event name:", "Event");
                dp.clearSelection();
                if (!name) return;
                var e = new DayPilot.Event({
                    start: args.start,
                    end: args.end,
                    id: DayPilot.guid(),
                    resource: args.resource,
                    text: name
                });
                dp.events.add(e);
                dp.message("Created");
            },

            scrollTo : ""

        };

		var eventsObj = new Object();
		var eventsArray = new Array();
		
		//db에 있는 데이터(options.events)를 받아와서  jsp페이지에있는 근무표에 자신이 몇번 근무인지 알수있게 넣어주는 곳.
		//비동기를 동기로 바꿔서 순서대로 처리할수있게해줌.
		//eventsObj에 options.events에 들어가는 데이터들을 다 넣고
		//eventsArray 배열에 오브젝트를 넣어줌.
		paging.ajaxSubmit("/spring/holidayRosterEventsList.ajax", "", function(result){
			console.log("hhh");
			for(var i = 0 ; i < result.length ; i++){
				eventsObj.start = result[i].start;
				eventsObj.end = result[i].end;
				eventsObj.text = result[i].text;
				eventsObj.id = result[i].id;
				eventsObj.resource = result[i].resource;
				
				eventsArray.push(eventsObj);
				eventsObj = {};
			}
			
			options.events = eventsArray;
			
    	}, false);
		
		options.resources = jArray;
		options.startDate = yearMonth;
		options.scrollTo = yearMonth;
		
		console.log("길이 : " + options.resources.length);
		
		for(var i = 0 ; i < options.resources.length ; i++){
			var result = Math.floor(Math.random() * 3) + 1;
			console.log("result : " + result);
		}
		
		console.log("events : " + JSON.stringify(options.events));
		
		return options;
	}
	
    $(document).ready(function() {
		option2 = validate();
		var headerMap = new JMap();
		var map = new JMap();
		var deleteData;
		
        dp = $("#dp").daypilotScheduler(option2);
		dp.allowEventOverlap = false;
		
		dp.resourceBubble = new DayPilot.Bubble();
		
		//마우스 오른쪽 버튼 누르면 edit, delete, select 부분 나오는 api
		dp.contextMenu = new DayPilot.Menu({items: [
        	{text:"Edit", onClick: function(args) { 
        		dp.events.edit(args.source); } },
        	{text:"Delete", onClick: function(args) { 
        		var deleteObj = new Object();
        		var deleteArray = new Array();
        		
        		//json 형식으로 만들어주기 위해 오브젝트를 만들고 오브젝트를 배열에 넣어줌.
        		deleteObj.start = args.source.start();
        		deleteObj.id = args.source.id();
        		deleteObj.end = args.source.end();
        		deleteObj.resource = args.source.resource();
        		deleteObj.text = args.source.text();
        		deleteArray.push(deleteObj);
        		deleteObj = {};
        		
        		console.log("delete : " + JSON.stringify(deleteArray));
        		
        		//map 형식으로 만들어줌.
            	var dataObj = {"holidayRosterDelete" : JSON.stringify(deleteArray)};
        		
        		paging.ajaxSubmit("/spring/holidayRosterDelete.ajax", dataObj, function(result){
            		
            	});
        		
        		dp.events.remove(args.source); } },
        	{text:"-"},
        	{text:"Select", onClick: function(args) { 
        		dp.multiselect.add(args.source); } },
		]}
		);

	    dp.eventMovingStartEndEnabled = true;
	    dp.eventResizingStartEndEnabled = true;
	    dp.timeRangeSelectingStartEndEnabled = true;
		
	    //내장 api 마우스를 갖다대면 조그맣게 나오는 화면 
	    dp.bubble = new DayPilot.Bubble({
	        onLoad: function(args) {
	            var startBubble = args.source.start();			//events안에서 start(ex : "2018-02-11T00:00:00")
	            var endBubble = args.source.end();				//events안에서 end(ex : "2018-02-13T00:00:00")
	            var nameBubble = args.source.resource();		//events안에서 resouece(ex : "신지연")
	            var textBubble = args.source.text();			//events안에서 text부분(안에 씌여진 부분 ex : "1")
	            var eventsLength = option2.events.length;		//events배열의 길이
	            var array = option2.events;						//events 배열을 array안에 담음.
	            var resultString = "";							//나오는 결과값을 담기위한 string
	            var oneInsert = true;
	            var nameOneInsert = true;
	            
	            if(oneInsert){
	            	for(var i = 0 ; i < eventsLength ; i++){
	            		//ex) 유성실이 1근무가 몇개있고 2근무가 몇개있는지 구분하기위해서 events안에서 유성실인것만 찾음.
	 	            	if(array[i].resource == nameBubble){
	 	            		//for문을 돌기때문에 이렇게 안하면 이름이 events배열 길이 만큼 들어감. 한번만 들어가게 하기 위해서 만들어준 if문
	 	            		if(nameOneInsert){
	 	            			resultString += "<div>" + array[i].resource + "</div>";
	 	            			nameOneInsert = false;
	 	            		}
	 	            		
	 	            		var startDateEvents = array[i].start;
	 	            		var endDateEvents = array[i].end;
	 	            		
	 	            		var startDateString = ((JSON.stringify(startDateEvents).substring(1,11))).split('-');		//ex) 2018-02-08만 남기고 거기서 '-'를 제거함
	 	   					var startDate = new Date(startDateString[0], (startDateString[1]-1), startDateString[2]);	//date 함수에 넣음.
	 	   					var endDateString = ((JSON.stringify(endDateEvents).substring(1,11))).split('-');
	 	   					var endDate = new Date(endDateString[0], (endDateString[1]-1), endDateString[2]);
	 	            		var calendarStartDateString = (option2.startDate).split('-');
	 	            		var calendarStartDate = new Date(calendarStartDateString[0], (calendarStartDateString[1]-1), calendarStartDateString[2]);
	 	            		var calendarEndDate = new Date();
	 	            		calendarEndDate.setDate(calendarStartDate.getDate() + option2.days -1);
	 	            		var tmpDate = new Date(startDateString[0], (startDateString[1]-1), startDateString[2]);
	 	            		
	 	            		console.log("sfosfl");
	 	            		
	 	   					var diff = endDate - startDate;
	 						var currDay = 24 * 60 * 60 * 1000;				//일차이
	 						var currMonth = currDay * 30;					//월차이
	 						var currYear = currMonth * 12;					//연차이
	 						var diffCurrDay = parseInt(diff/currDay);
	 	   					
	 						for(var j = 0 ; j < diffCurrDay ; j++){
	 							console.log("tmpDate : " + tmpDate.getMonth());
	 							console.log("tmpDate : " + tmpDate.getDate());
	 							console.log("tmpDate : " + tmpDate.getFullYear());
	 							
	 							if(tmpDate.getTime() >= calendarStartDate.getTime() && tmpDate.getTime() < calendarEndDate.getTime()){
	 								if(map.containsKey(array[i].text)){
		 	            				map.put(array[i].text, map.get(array[i].text) + 1);
		 	            			}else{
		 	            				map.put(array[i].text, 1);
		 	            			}
	 							}
	 							
	 							tmpDate.setDate(tmpDate.getDate() + 1);
	 						}
	 						
	 						console.log("달력 처음부터 끝 : " + option2.startDate);
	 						//console.log("startDate : " + startDateString[2]);
	 						
	 						//console.log(startDateString + " : " + endDateString +  " diffCurrDay : " + diffCurrDay);
	 						
	 						//map 안에 key값이 있으면 key값에 해당하는 value(Int) 값을 불러와서 +1 해주고 다시 넣어줌.
	 						//key값이 없으면 value(Int) 값에 1을 넣어줌.
// 	 						for(var j = 0 ; j < diffCurrDay ; j++){
// 	 							if(map.containsKey(array[i].text)){
// 	 	            				map.put(array[i].text, map.get(array[i].text) + 1);
// 	 	            			}else{
// 	 	            				map.put(array[i].text, 1);
// 	 	            			}
// 	 						}
	 	            	}
	 	            }
	            	nameOneInsert = true;
	            	oneInsert = false;
	            }
	            //map에 key값만 가져옴.
 	            var keyArray = map.keys();
 	            
	            //map을 돌면서 결과 string에 값을 넣어줌.
 	            for(var i = 0 ; i < keyArray.length; i++){
 	            	resultString += "<div>" + keyArray[i] + " : " + map.get(keyArray[i]) + "</div>";
 	            }
	            //최종적인 화면에 보여지기 위해서 쓰여진 api
 	            args.html = resultString;
 	            
 	            console.log("map keys : " + map.keys());
 	            console.log("map values : " + map.values());
 	            
	            console.log("gg : " + JSON.stringify(option2.events));
	            //args.html = "testing bubble for: " + ev.text();
				//args.html = "<div>" + args.source.start() + "</div><div>" + args.source.end() + "</div><div>" + args.source.resource() + "</div><div>" + args.source.text() + "</div>";
	           
				//map을 지워줘야 다른부분을 실행할때 전 데이터가 남아있지않음.
				map.clear();
				oneInsert = true;
				
	        }
	    });
	    
	    dp.onTimeHeaderClick = function(args) {
// 	    	alert("clicked: " + args.header.start);
	        //alert("clicked : " + args.header.end);
	        var array = option2.events;					//events 배열을 array안에 담음.
	        var resultString = "";							//나오는 결과값을 담기위한 string
	        var eventsLength = option2.events.length;		//events배열의 길이
	        var headerOneInsert = true;
	         
	        console.log("header array : " + JSON.stringify(array));
	         
	        for(var i = 0 ; i < eventsLength ; i++){
	        	var startDateEvents = array[i].start;
	        	var headerStartDate = args.header.start;
	        	var endDateEvents = array[i].end;				//events안에서 end(ex : "2018-02-13T00:00:00")
	        	
	        	var startDateString = ((JSON.stringify(startDateEvents).substring(1,11))).split('-');		//ex) 2018-02-08만 남기고 거기서 '-'를 제거함
				var startDate = new Date(startDateString[0], (startDateString[1]-1), startDateString[2]);	//date 함수에 넣음.
				var endDateString = ((JSON.stringify(endDateEvents).substring(1,11))).split('-');
				var endDate = new Date(endDateString[0], (endDateString[1]-1), endDateString[2]);
				var headerStartDateString = ((JSON.stringify(headerStartDate).substring(1,11))).split('-');
				var headerStartDate = new Date(headerStartDateString[0], (headerStartDateString[1]-1), headerStartDateString[2]);
         		var tmpDate = new Date(startDateString[0], (startDateString[1]-1), startDateString[2]);
	        	
	        	console.log("startDate.getDate() : " + startDate.getDate() + " endDate.getDate() : " + endDate.getDate());
	        	console.log("headerStartDate.getDate() : " + headerStartDate.getDate())
	        	
	        	var tmpDate = new Date(startDateString[0], (startDateString[1]-1), startDateString[2]);
	 	            		
	 	   		var diff = endDate - startDate;
	 			var currDay = 24 * 60 * 60 * 1000;				//일차이
	 			var currMonth = currDay * 30;					//월차이
	 			var currYear = currMonth * 12;					//연차이
	 			var diffCurrDay = parseInt(diff/currDay);
	 	   					
	 			for(var j = 0 ; j < diffCurrDay ; j++){
	 				if((tmpDate.getDate() == headerStartDate.getDate()) && (tmpDate.getMonth() == headerStartDate.getMonth())){
	 					if(headerOneInsert){
	            			resultString += headerStartDate.getFullYear() + "-" + headerStartDate.getMonth() + "-" + headerStartDate.getDate() + "\n";
	            			headerOneInsert = false;
	            		}
        			
	        			if(headerMap.containsKey(array[i].text)){
	        				headerMap.put(array[i].text, headerMap.get(array[i].text) + 1);
	            		}else{
	            			headerMap.put(array[i].text, 1);
	            		}
	 				}
	 				tmpDate.setDate(tmpDate.getDate() + 1);
	 			}
	        	
	        	
// 	        	for(var j = startDate.getDate() ; j < endDate.getDate() ; j++){
// 	        		if(j == headerStartDate.getDate()){
// 	        			if(headerOneInsert){
//  	            			resultString += headerStartDate.getFullYear() + "-" + headerStartDate.getMonth() + "-" + headerStartDate.getDate() + "\n";
//  	            			headerOneInsert = false;
//  	            		}
	        			
// 	        			if(headerMap.containsKey(array[i].text)){
// 	        				headerMap.put(array[i].text, headerMap.get(array[i].text) + 1);
// 	            		}else{
// 	            			headerMap.put(array[i].text, 1);
// 	            		}
// 	        		}
// 	        	}
	        }
	        
	        
	      	//map에 key값만 가져옴.
	      	var keyArray = headerMap.keys();
	            
            //map을 돌면서 결과 string에 값을 넣어줌.
	        for(var i = 0 ; i < keyArray.length; i++){
	        	resultString += keyArray[i] + " : " + headerMap.get(keyArray[i]) + "\n";
	        }
            
            //최종적인 화면에 보여지기 위해서 쓰여진 api
	        alert(resultString);
            
	        headerMap.clear();
	        headerOneInsert = true;
	    };
	    
		console.log("ss : " + JSON.stringify(option2.events));
		
    });
	
  //바뀌면 update를 해줘서 표 안을 바꿔줌.
	function changeList(){
		yearMonthChange();
		
// 		if($("input[name='yearMonth']").val() == undefined){
// 			dp.startDate = $("input[name='yearMonth2']").val();
// 		}else{
// 			dp.startDate = $("input[name='yearMonth']").val();
// 		}
		
		dp.startDate = $("input[name='rosterStartSubOne']").val()
		
		console.log("dp.start222 : " + dp.startDate);
// 		dp.startDate = $("input[name='yearMonth2']").val();
		dp.days = $("input[name='days']").val();
		
		dp.update();
	}
	
	function daysInMonth(month, year) {
	    var days;
	    switch (month) {
	        case 1: // Feb, our problem child
	            var leapYear = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
	            days = leapYear ? 29 : 28;
	            break;
	        case 3: case 5: case 8: case 10: 
	            days = 30;
	            break;
	        default: 
	            days = 31;
	        }
	    console.log("year : " + year + " month : " + month + " days : " + days);
	    
	    return days;
	}
  
	//year, month가 바뀌면 바뀐 데이터를 hidden에 넣어주는 기능
	function yearMonthChange(){
		var year = $("select[name=rosterYear]").val();
		var month = $("select[name=rosterMonth]").val();
		var day = "1";
		
		console.log("year : " + year);
		console.log("month : " + month);
		
		var rosterDate = new Date(year, (month -1), "1");
		
// 		rosterDate.setDate(rosterDate.getDate()-1);
		
		console.log("rosterDate : " + rosterDate);
		var day2 = daysInMonth(rosterDate.getMonth(), rosterDate.getFullYear());
		var day2 = Number(day2) + 1;
		$("input[name='days']").val(day2);
		
		rosterDate.setDate(rosterDate.getDate() - 1);
		
		var yearMonth = rosterDate.getFullYear() + '-' + ((rosterDate.getMonth()+1)<10 ? '0' + (rosterDate.getMonth()+1) : (rosterDate.getMonth()+1)) + '-' +
        (rosterDate.getDate()<10 ? '0'+rosterDate.getDate() : rosterDate.getDate());
		
		$("input[name='rosterStartSubOne']").val(yearMonth);
		
		console.log("rosterStartSubOne : " + $("input[name='rosterStartSubOne']").val());
// 		
		console.log("days22 : " + $("input[name='days']").val());
		
		rosterDate.setDate(rosterDate.getDate() + 1);
		
		var yearMonth = rosterDate.getFullYear() + '-' + ((rosterDate.getMonth()+1)<10 ? '0' + (rosterDate.getMonth()+1) : (rosterDate.getMonth()+1)) + '-' +
        (rosterDate.getDate()<10 ? '0'+rosterDate.getDate() : rosterDate.getDate());
		
		$("input[name='yearMonth2']").val(yearMonth);
		
		console.log("test : " + $("input[name='yearMonth2']").val());
	}
    
	function daysInMonth(month, year) {
	    var days;
	    switch (month) {
	        case 1: // Feb, our problem child
	            var leapYear = ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
	            days = leapYear ? 29 : 28;
	            break;
	        case 3: case 5: case 8: case 10: 
	            days = 30;
	            break;
	        default: 
	            days = 31;
	        }
	    console.log("year : " + year + " month : " + month + " days : " + days);
	    
	    return days;
	}
	
    function saveRosterBtn(){
    	console.log("startDateOption : " + option2.startDate);

		startDateString = String(option2.startDate);
// 		startDateString = startDateString.substring(0,10);
		startDateString = startDateString.split('-');
		startDate = new Date(startDateString[0], startDateString[1]-1, startDateString[2]);
		
		console.log("startDate22 : " + startDate);
		
// 		var endDateString = String((dp.rows.selection.get()[0]).start);
// 		endDateString = endDateString.substring(0,10);
// 		endDateString = endDateString.split('-');
    	endDate = new Date(startDateString[0], startDateString[1]-1, startDateString[2]);
    	
    	endDate.setDate(parseInt(endDate.getDate()) + parseInt(option2.days));
    	
    	console.log("endDate.getDate() : " + endDate.getDate());
    	console.log("options.events : " + JSON.stringify(options.events));
    	
    	$("input[name='events']").val(JSON.stringify(options.events));
    	//$("form[name='hiddenForm']").submit();
    	var dataArray = new Array();
    	//var dataObj = {"eventsArray":JSON.stringify($("input[name='events']").val())};
    	dataArray.push($("input[name='events']").val());
    	dataArray = JSON.parse(dataArray);
    	var standardArray = new Array();
    	
    	console.log("dataArray55 : " + JSON.stringify(dataArray));
//     	var data = JSON.stringify($("input[name='events']").val());
    	var standardDate;
    	//특정문자 '\'를 제거해주는 작업
// 		data = data.replace(/\\/g,'');
//     	data = JSON.parse(data);
    	
		console.log("startDate33 : " + startDate);
		console.log("endDate33s : " + endDate);
    	
    	for(var i = 0 ; i < dataArray.length ; i++){
//     		console.log(data[i].start);

    		standardDateString = String(dataArray[i].start);
    		standardDateString = standardDateString.substring(0,10);
    		standardDateString = standardDateString.split('-');
    		standardDate = new Date(standardDateString[0], standardDateString[1]-1, standardDateString[2]);
    		
    		if((startDate.getTime() <= standardDate.getTime()) && (standardDate.getTime() <= endDate.getTime())){
    			console.log("ss");
    			dataArray[i].text = codeChange(dataArray[i].text);
    			standardArray.push(dataArray[i]);
    			
    		}
    		
//     		console.log("standardDate : " + standardDate);
    	}
    	
    	console.log("standardArray 2: " + JSON.stringify(standardArray));
    	
//     	console.log("data : " + data);
    	
    	//map 형식으로 만들어줌.
    	var dataObj = {"eventsArray":JSON.stringify(standardArray)};
    	
		paging.ajaxSubmit("/spring/holidayRosterDBInsert.ajax",dataObj,function(result){
			console.log(result);
		});
		
		alert("저장되었습니다.");
    }
    
    function selectRosterMake(selectArray, startDate, endDate, startDateString){
    	console.log("startDateString : " + startDateString);
    	var tmpEvents = new Array();
    	var tmpDate = new Date();
    	var standardDate = new Date(startDateString[0], startDateString[1]-1, startDateString[2]);
    	
    	standardDate.setDate(standardDate.getDate() + 1);
    	
    	tmpDate = startDate;
    	tmpDate.setDate(tmpDate.getDate() + 1);
    	
    	console.log("selectArrayStart  : " + JSON.stringify(selectArray));
    	
//     	var name = prompt("넣을 근무를 입력해주세요.", "주/야/심");
    	
//     	name = name.split('/');
    	
    	var name = $("input[name='hiddenRosterOrder']").val();
    	
    	console.log("name222222 : " + name);
    	
    	name = name.split(',');
    	
    	console.log("서순2 : " + name[0]);
    	
		var diff = endDate - startDate;
		var currDay = 24 * 60 * 60 * 1000;// 시 * 분 * 초 * 밀리세컨
		var diffDay= parseInt(diff/currDay);
    	
		console.log("길이 : " + selectArray.length);
		
// 		console.log("dp : " + JSON.stringify(dp.events));
		
		console.log("diffDay : " + diffDay);
		
    	for(var i = 0 ; i < selectArray.length ; i++){
        	
    		for(var j = 0 ; j <= diffDay ; j++){
    			var tmpObj = new Object();
    			
    			var tmpString = tmpDate.getFullYear() + '-' + ((tmpDate.getMonth()+1)<10 ? '0' + (tmpDate.getMonth()+1) : (tmpDate.getMonth()+1)) + '-' +
    	        (tmpDate.getDate()<10 ? '0'+tmpDate.getDate() : tmpDate.getDate());
    			
    			tmpObj.id = DayPilot.guid();
    			tmpObj.start = tmpString + "T00:00:00";
    			tmpObj.end = tmpString + "T12:00:00";
    			tmpObj.resource = selectArray[i].name;
    			
//     			var nameChange = name[j%3];
    			
//     			if(nameChange == "")
    			
    			tmpObj.text = letterChange(name[j%name.length]);
    			
    			//tmpEvents.push(tmpObj);
    			dp.events.list.push(tmpObj);
    			tmpObj = "";
    			
    			tmpDate.setDate(tmpDate.getDate() + 1);
    		}
    		tmpDate.setYear(standardDate.getFullYear());
    		tmpDate.setMonth(((standardDate.getMonth())<10 ? '0' + (standardDate.getMonth()) : (standardDate.getMonth())));
    		tmpDate.setDate(standardDate.getDate()<10 ? '0'+ standardDate.getDate() : standardDate.getDate());
    	}
    	
    	console.log("tmpEvents55 : " + JSON.stringify(tmpEvents));
    	console.log("길이 : " + tmpEvents.length);
    	
//     	console.log(JSON.stringify(option2.events));
    	console.log("변함1010");
    	
//     	dp.events.list = [{
//             start: "2015-12-27T00:00:00",
//             end: "2015-12-27T12:00:00",
//             id: DayPilot.guid(),
//             resource: "강병욱",
//             text: "Event"
//     	},
//     	{
//             start: "2015-12-28T00:00:00",
//             end: "2015-12-28T12:00:00",
//             id: DayPilot.guid(),
//             resource: "강병욱",
//             text: "Event"
//     	}
//     	];

		//dp.events.list = tmpEvents;
		//dp.events.list.push(tmpEvents);
		
		console.log("eventsTest : " + JSON.stringify(dp.events.list));
		
    	dp.update();
    	
    }
    
    function codeChange(letter){
    	var result = "";
    	var standardLetter = $("input[name='hiddenNotChangeRosterOrder']").val();
    	standardLetter = standardLetter.split(",");
    	
    	for(var i = 0 ; i < standardLetter.length ; i++){
    		if(standardLetter[i].indexOf(letter) != -1){
    			console.log("찾은문자 : " + standardLetter[i]);
    			result = standardLetter[i].substring(0, 12);
    		}
    	}
    	
    	console.log(result);
    	
    	return result;
    }
    
    function letterChange(letter){
    	
    	if(letter == "" || letter == null){
    		letter = null;
    	}
    	
    	console.log("letter : " + letter);
    	var result = "";
    	var standardLetter = $("input[name='hiddenNotChangeRosterOrder']").val();
    	
    	console.log("standardLetter : " + standardLetter);
    	
    	standardLetter = standardLetter.split(",");
    	
    	for(var i = 0 ; i < standardLetter.length ; i++){

    		if(standardLetter[i].match(letter) != null){
    			result = standardLetter[i].substring(standardLetter[i].length-2);
    			console.log("찾은문자333 : " + result);
    		}
    		
//     		if(standardLetter[i].indexOf(letter) != -1){
    			
    			
//     		}
    	}
    	
    	return result;
    }
    
	$(document).ready(function() { 
// 		var url = window.location.href; 
// 		var filename = url.substring(url.lastIndexOf('/')+1); 
// 		if (filename === "") filename = "index.html"; 
// 			$(".menu a[href='" + filename + "']").addClass("selected"); 

		$("input[name='selectNumber']").val(0);
		
		changeList();
		
		console.log("tt2 : " + $("input[name='days']").val());
		
		var rowArray = new Array();
		//근무표안에 들어가는 cell 높이 넓이 지정해주는 부분.
		dp.eventHeight = 50;
		dp.cellWidth = 50;	
		
		var data;
		var endDate;
		var startDate;
		var startDateString;
		
		console.log(option2.resources);
		
		dp.rowClickHandling = "Select";
		
	    dp.onRowSelect = function(args) {
	        window.console && console.log(args.row.toJSON());
	    };
	    dp.onRowSelected = function(args) {
// 	    	var tmp = new Object();
// 	    	tmp.id = args.row.id;
// 	    	tmp.name = args.row.name;
	    	
// 	    	rowArray.push(tmp);
	    	
	    	console.log("args.row[0] : " + JSON.stringify(args.row.index));
	    	console.log("args.selected : " + args.selected);
	    	
	        var msg = "This row was " + (args.selected ? "" : "de") + "selected: " + args.row.name;
// 	        console.log("array : " + JSON.stringify(rowArray));
	        dp.message(msg);
	        window.console && console.log(dp.rows.selection.get().length);
	        
	        $("input[name='selectNumber']").val(dp.rows.selection.get().length);
	        
	        console.log("선택 된 인원" + $("input[name='selectNumber']").val());
	        
	        console.log("id : " + args.row.id);
			console.log("name : " + args.row.name);
			console.log("name33 : " + JSON.stringify((dp.rows.selection.get())[0]));
// 			console.log("name44 : " + (dp.rows.selection.get()[0]).index);
// 			console.log("end : " + ((dp.rows.selection.get()[0]).start)); 
			console.log("test22 : " + JSON.stringify(dp.rows.selection.get()));
			
			data = dp.rows.selection.get();
			
			console.log("data55 : " + data.length);
			
			startDateString = String((dp.rows.selection.get()[0]).start);
			startDateString = startDateString.substring(0,10);
			startDateString = startDateString.split('-');
			startDate = new Date(startDateString[0], startDateString[1]-1, startDateString[2]);
			
// 			console.log("startDateString : " + startDateString);
			
			var endDateString = String((dp.rows.selection.get()[0]).start);
			endDateString = endDateString.substring(0,10);
			endDateString = endDateString.split('-');
			console.log("바뀜2 : " + endDateString);
			endDate = new Date(endDateString[0], endDateString[1]-1, endDateString[2]);
			console.log("데이 : " + dp.days);
			endDate.setDate(endDate.getDate() + Number(dp.days) - 1);
			
			//selectRosterMake(JSON.stringify(dp.rows.selection.get()));
			
			console.log("바뀜44 : " + endDate);
	    };
		
	    $('#insertBtn').click(function(){
	    	if($("input[name='rosterMakeFlag']").val() == "true"){
	    		selectRosterMake(data, startDate, endDate, startDateString);
	    	}
	    });
	    
// 		dp.selectedRows = ["강병욱"];
		
		dp.onRowFilter = function(args) {
	        if (args.row.name.toUpperCase().indexOf(args.filter.toUpperCase()) === -1) {
	            args.visible = false;
	        }
	    };
		
// 	    option2.events =                  [{
// 	            start: "2015-12-28T00:00:00",
// 	            end: "2015-12-29T12:00:00",
// 	            id: DayPilot.guid(),
// 	            resource: "강병욱",
// 	            text: "Event"
// 	    }];
	    
	    console.log("events3 : " + JSON.stringify(dp.events.list));
	    
// 	    dp.events.list = [{
// 	            start: "2015-12-27T00:00:00",
// 	            end: "2015-12-27T12:00:00",
// 	            id: DayPilot.guid(),
// 	            resource: "강병욱",
// 	            text: "Event"
// 	    }];
	    
		dp.update();
		console.log("바뀜6");
	});
	
	
</script> 
	<!-- /bottom -->

</body>
</html>