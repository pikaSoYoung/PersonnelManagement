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
			
			<h3 class="page-title">근무표 조회</h3>
			
			<div class="panel panel-headline">
				<div class="panel-heading">
					<h4 class="panel-title" style="font-size:20px; padding-left:15px;">근무표 조회 연도와 달을 선택하세요.</h4>
				</div>
			
				<div class="panel-body">
<!-- 					<div class="input-group date" id="rosterYearMonthStart"> -->
<!-- 					<input type="text" class="form-control" id="rosterStartDate" name="rosterStartDate"/> -->
<!-- 					<span class="input-group-addon"> -->
<!-- 						<span class="fa fa-calendar" > -->
<!-- 						</span> -->
<!-- 					</span> -->
<!-- 					</div> -->
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
			
			<input type="hidden" name="empName2" value="">
			<input type="hidden" name="yearMonth2" value="">
			
			<form action="weekRoster" method="post" name="hiddenWeekRosterForm">
				<input type="hidden" name="formYearMonth" value="">
			</form>
			
			<input type="button" class="btn btn-primary" name="individualRoster" value="개인근무표" onClick="">
			<input type="button" class="btn btn-primary" name="weekRoster" value="주간근무표" onClick="weekRoster()">
			<input type="button" class="btn btn-primary" name="monthRoster" value="월간근무표" onClick="">
			<input type="button" class="btn btn-primary" name="editButton" value="편집" onClick="">
			
		</div>
	</div>
</div>

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
    var year;
	var month;
	
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
    	
    	$("#rosterYear").val(year).attr("selected", "selected");
    	$("#rosterMonth").val(month).attr("selected", "selected");
    	
    	console.log("yearMonth233 : " + yearMonth);
    	//console.log("yearMonth2 : " + yearMonth2);
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
//                 {
//                     start: "2014-01-25T00:00:00",
//                     end: "2014-01-25T12:00:00",
//                     id: DayPilot.guid(),
//                     resource: "강병욱",
//                     text: "Event"
//                 },
// 				{
// 					start: "2014-01-25T00:00:00",
//                     end: "2014-01-26T00:00:00",
//                     id: DayPilot.guid(),
//                     resource: "신지연",
//                     text: "D"
// 				}
            ],

            scrollTo : "",
            eventMoveHandling: "Disabled",
            eventResizeHandling: "Disabled",
            eventDeleteHandling: "Disabled",
            eventClickHandling: "Disabled",
            eventHoverHandling: "Bubble"
        };

		var eventsObj = new Object();
		var eventsArray = new Array();
		
		//db에 있는 데이터(options.events)를 받아와서  jsp페이지에있는 근무표에 자신이 몇번 근무인지 알수있게 넣어주는 곳.
		//비동기를 동기로 바꿔서 순서대로 처리할수있게해줌.
		//eventsObj에 options.events에 들어가는 데이터들을 다 넣고
		//eventsArray 배열에 오브젝트를 넣어줌.
		paging.ajaxSubmit("/spring/holidayRosterEventsList.ajax", "", function(result){
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
		
		console.log("events : " + JSON.stringify(options.events));
		
		return options;
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
	
	//바뀌면 update를 해줘서 표 안을 바꿔줌.
	function changeList(){
		yearMonthChange();
		
		if($("input[name='yearMonth']").val() == undefined){
			dp.startDate = $("input[name='yearMonth2']").val();
		}else{
			dp.startDate = $("input[name='yearMonth']").val();
		}
		
		console.log("dp.start222 : " + dp.startDate);
// 		dp.startDate = $("input[name='yearMonth2']").val();
		dp.days = $("input[name='days']").val();
		
		dp.update();
	}
	
	//year, month가 바뀌면 바뀐 데이터를 hidden에 넣어주는 기능
	function yearMonthChange(){
		var year = $("select[name=rosterYear]").val();
		var month = $("select[name=rosterMonth]").val();
		var day = "1";
		
		var rosterDate = new Date(year, (month -1), "1");
		
		$("input[name='days']").val(daysInMonth(rosterDate.getMonth(), rosterDate.getFullYear()));
		
		var yearMonth = rosterDate.getFullYear() + '-' + ((rosterDate.getMonth()+1)<10 ? '0' + (rosterDate.getMonth()+1) : (rosterDate.getMonth()+1)) + '-' +
        (rosterDate.getDate()<10 ? '0'+rosterDate.getDate() : rosterDate.getDate());
		
		$("input[name='yearMonth2']").val(yearMonth);
	}
	
    $(document).ready(function() {
		option2 = validate();
		var headerMap = new JMap();
		var map = new JMap();
		var deleteData;
		
        dp = $("#dp").daypilotScheduler(option2);
		
		dp.resourceBubble = new DayPilot.Bubble();

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
    
    function weekRoster(){
    	var data;
    	
    	if($('input[name=yearMonth]').val() == undefined){
    		$('input[name=formYearMonth]').val($('input[name=yearMonth2]').val());
    	}else{
    		$('input[name=formYearMonth]').val($('input[name=yearMonth]').val());
    	}
    	
    	$("form[name='hiddenWeekRosterForm']").submit();
    }
    
	$(document).ready(function() { 
// 		var url = window.location.href; 
// 		var filename = url.substring(url.lastIndexOf('/')+1); 
// 		if (filename === "") filename = "index.html"; 
// 			$(".menu a[href='" + filename + "']").addClass("selected");  

// 		yearMonthChange(); 
		changeList();
		
		//근무표안에 들어가는 cell 높이 넓이 지정해주는 부분. 
		
		dp.eventHeight = 50;
		dp.cellWidth = 50;	
		
		console.log(option2.resources);
		
		dp.update();
			
	});
</script> 
	<!-- /bottom -->

</body>
</html>