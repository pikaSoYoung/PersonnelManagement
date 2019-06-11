package com.example.spring.attendance.controller;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import org.apache.ibatis.javassist.bytecode.Descriptor.Iterator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.spring.attendance.entity.JsonData;
import com.example.spring.attendance.entity.JsonDataVac;
import com.example.spring.attendance.entity.WeekRoster;
import com.example.spring.attendance.entity.DayMinPerson;
import com.example.spring.attendance.entity.DeleteEventsData;
import com.example.spring.attendance.entity.EventsData;
import com.example.spring.attendance.service.HolidaySetService;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;

@Controller
public class HolidaySetController {

	private static final Logger logger = LoggerFactory.getLogger(HolidaySetController.class);

	@Autowired
	private HolidaySetService holidaySetService;

	//관리자 - 휴가리스트 조회하기
	@RequestMapping(value = "/holidaySet")
	public String vatacionListAdminPage() {
		return "holidaySet";
	}

	//관리자 - 휴일설정
	@RequestMapping(value = "/holiDyMng")
	public String vatacionListAdminPage2() {
		return "holiDyMng";
	}

	//requestParam으로 받아오면 지금 ajax로 데이터를 보낼때 {jArray : "(json형태)"}로 보냈기 때문에 맵으로 받음.
	//맵 형태로 보내야함(key 값이 꼭있어야 보낼수있음)
	@RequestMapping(value = "/holidaySetDBInset.ajax")
	public @ResponseBody HashMap<String, String> holidaySetDBInsert(@RequestParam HashMap<String,Object> jsonMap) {
		logger.debug("-----------------------------------------holidaySetDBInsert 들어왔다"+jsonMap);

		//success 다시 되돌려줄 맵
		HashMap<String, String> map = new HashMap<String, String>();
		Gson gson = new Gson();
		//List<JsonData>로 타입을 만들어주겠다 선언.
		Type type = new TypeToken<List<JsonData>>() {}.getType();

		String result = (String) jsonMap.get("jArray");
		
		//gson.fromJson : Json 형식으로된 String을 ArrayList로 바꿔주는 역할을 함.
		//지금 result에는 json형식으로 되어있음.
		ArrayList<JsonData> list = gson.fromJson(result, type);

		//값이 제대로 나오는지 확인해보는 용도
		for(int i = 0 ; i < list.size() ; i++) {
			JsonData tmp = (JsonData)list.get(i);
			System.out.println(tmp.getDivide() + " " + tmp.getCode() + " " + tmp.getAnnualLeaveReflection() + " " + tmp.getTitle() + " " + tmp.getUseOrFailure() + " " + tmp.getNote());
		}

		//list를 이제 서비스쪽으로 보냄.
		holidaySetService.holidaySetDBInsert(list);
		
		map.put("success", "true");

		return map;
	}
	
	//관리자 - 근속연수에 따른 휴가설정
	@RequestMapping(value = "/conWorkVacSet")
	public String vatacionListAdminPage3() {
		return "conWorkVacSet";
	}

	//관리자 - 근무표 페이지
	@RequestMapping(value = "/holidayRoster")
	public ModelAndView holidayRoster() {
		//HashMap<String, String> empNameMap = new HashMap<String, String>();
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("holidayRoster");
		
		//holidaySetService.holidayRoster(infoMap);
		
		return mv;
	}
	
	//관리자 - 근무인원, 근무 날짜 db에 입력하는 컨트롤러
	@RequestMapping(value = "/holidayRosterSettingDBInsert")
	public ModelAndView holidayRosterSettingDBInsert(@RequestParam HashMap<String,Object> rosterSetting) {
		//HashMap<String, String> empNameMap = new HashMap<String, String>();
			
		System.out.println("---------------------infoMap2" + rosterSetting);
		
		HashMap<String,Object> infoMap = new HashMap<String, Object>();
		HashMap<String, DayMinPerson> minPersonMap = new HashMap<String, DayMinPerson>();
		
		String yearMonth = (String) rosterSetting.get("yearMonth");
		
		infoMap.put("empName", rosterSetting.get("empName"));
		infoMap.put("yearMonth", rosterSetting.get("yearMonth"));
		
		System.out.println("yearMonth : " + yearMonth);
		
		rosterSetting.remove("empName");
		rosterSetting.remove("yearMonth");
		
		for(String mapKey : rosterSetting.keySet()) {
//			System.out.println(mapKey + " : " + rosterSetting.get(mapKey));
			String day = mapKey.substring(0, mapKey.length()-1);
			String last = mapKey.substring(mapKey.length()-1);
			String value = (rosterSetting.get(mapKey)).toString();
			
			DayMinPerson tmp = new DayMinPerson();
			
//			System.out.println("last : " + last);
			
			if(last.equals("D")) {
				tmp.setMinPerson(String.valueOf(stringToInt(value)));
				tmp.setDay(day);
				String result = "C" + yearMonth + last;
				tmp.setCode(result);
			}else if(last.equals("E")) {
				tmp.setMinPerson(String.valueOf(stringToInt(value)));
				tmp.setDay(day);
				String result = "C" + yearMonth + last;
				tmp.setCode(result);
			}else if(last.equals("N")) {
				tmp.setMinPerson(String.valueOf(stringToInt(value)));
				tmp.setDay(day);
				String result = "C" + yearMonth + last;
				tmp.setCode(result);
			}
			
			System.out.println("Code : " + tmp.getCode());
			
			minPersonMap.put(mapKey, tmp);
			
		}
		
//		for(String mapKey : rosterSetting.keySet()) {
//			DayMinPerson tmp = (DayMinPerson)minPersonMap.get(mapKey);
//			System.out.println("ssdd : " + mapKey);
//			System.out.println(tmp.getDay() + " : " + tmp.getCode() + " : " + tmp.getMinPerson());
//		}
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("holidayRoster");
		mv.addObject("infoMap", infoMap);
			
		holidaySetService.holidayRosterSetting(minPersonMap);
		holidaySetService.holidayRoster(infoMap);
			
		return mv;
	}
	
	public static int stringToInt(String number) {
		int result = -1;
		
		if(number.equals("zero")) {
			result = 0;
		}else if(number.equals("one")) {
			result = 1;
		}else if(number.equals("two")) {
			result = 2;
		}else if(number.equals("three")) {
			result = 3;
		}else if(number.equals("four")) {
			result = 4;
		}else if(number.equals("five")) {
			result = 5;
		}else if(number.equals("six")) {
			result = 6;
		}else if(number.equals("seven")) {
			result = 7;
		}else if(number.equals("eight")) {
			result = 8;
		}else if(number.equals("nine")) {
			result = 9;
		}else if(number.equals("ten")) {
			result = 10;
		}
		
		return result;
	}
	
	//관리자 - 근무인원, 근무 날짜 db에 입력하는 컨트롤러
	@RequestMapping(value = "/individualRoster")
	public String individualRoster() {
		return "individualRoster";
	}
	
	//관리자 - 근무표 근무 인원 db에서 불러오는 컨트롤러.
	@RequestMapping(value = "/holidayRosterEventsList.ajax")
	public @ResponseBody List<HashMap<String, String>> holidayRosterEventsList(@RequestParam HashMap<String,Object> eventsList) {
		System.out.println("eventsList : " + eventsList);
		
		List<HashMap<String, String>> map = new ArrayList<HashMap<String, String>>();
		
		map = holidaySetService.holidayRosterEventsList();
		
		System.out.println("------------- holidayRosterEventsList : "+map);
		
		return map;
	}
	
	@RequestMapping(value = "/rosterTime.ajax")
	public @ResponseBody List<HashMap<String, String>> rosterTime(@RequestParam HashMap<String,String> standardTime) {
		System.out.println("standardTime : " + standardTime);
		
		List<HashMap<String, String>> map = new ArrayList<HashMap<String, String>>();
			
		map = holidaySetService.rosterTime(standardTime);
			
		System.out.println("------------- holidayRosterEventsList : "+map);
			
		return map;
	}
	
	//관리자 - 근무표 근무 인원 db에서 불러오는 컨트롤러.
	@RequestMapping(value = "/holidayRosterEventsList2.ajax")
	public @ResponseBody List<HashMap<String, String>> holidayRosterEventsList2(@RequestParam HashMap<String,Object> eventsList) {
		System.out.println("eventsList2323 : " + eventsList);
		
		List<HashMap<String, String>> map = new ArrayList<HashMap<String, String>>();
			
		map = holidaySetService.holidayRosterEventsList2(eventsList);
			
		System.out.println("------------- holidayRosterEventsList : "+map);
			
		return map;
	}
	
	//관리자 - 근무표 근무 인원 db에서 불러오는 컨트롤러.
	@RequestMapping(value = "/holidayRosterList.ajax")
	public @ResponseBody HashMap<String, String> holidayRosterList() {
		HashMap<String, String> map = new HashMap<String, String>();
			
		map = holidaySetService.holidayRosterList();
		
		System.out.println("------------- map : "+map);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("holidayRoster");
		mv.addObject("infoMap", map);
			
		map.put("success", "true");
		
		return map;
	}
	
	//관리자 - 근무표 근무 인원 db에서 제거하는 함수.
	@RequestMapping(value = "/holidayRosterDelete.ajax")
	public @ResponseBody HashMap<String, String> holidayRosterDelete(@RequestParam HashMap<String, String> deleteMap) {
		HashMap<String, String> map = new HashMap<String, String>();
			
		System.out.println("------------- deleteMap : "+deleteMap);
		
		Gson gson = new Gson();
		//List<DeleteEventsData>로 타입을 만들어주겠다 선언.
		Type type = new TypeToken<List<DeleteEventsData>>() {}.getType();

		String result = (String) deleteMap.get("holidayRosterDelete");

		//gson.fromJson : Json 형식으로된 String을 ArrayList로 바꿔주는 역할을 함.
		//지금 result에는 json형식으로 되어있음.
		ArrayList<DeleteEventsData> list = gson.fromJson(result, type);
		
		holidaySetService.holidayRosterDelete(list);
		
		map.put("success", "true");
			
		return map;
	}
	
	//관리자 - 근무표생성설정
	@RequestMapping(value = "/holidayRosterSetting")
	public String holidayRosterSetting() {
		return "holidayRosterSetting";
	}
	
	//관리자 - 근무표조회
	@RequestMapping(value = "/holidayRosterCheck")
	public ModelAndView holidayRosterCheck() {
		ModelAndView mv = new ModelAndView();
		mv.setViewName("holidayRosterCheck");
		
		return mv;
	}
	
	//관리자 - 근무표생성설정
	@RequestMapping(value = "/weekRoster")
	public ModelAndView weekRoster(@RequestParam("formYearMonth") String yearMonth) {
		System.out.println("weekRoster : " + yearMonth);
		
		ModelAndView mv = new ModelAndView();
		mv.setViewName("weekRoster");
		mv.addObject("formYearMonth", yearMonth);
		
		return mv;
	}
	
	//관리자 - 근무표생성설정
	@RequestMapping(value = "/yearMonthDeliver")
	public @ResponseBody HashMap<String, String> yearMonthDeliver(@RequestParam HashMap<String, String> yearMonth) {
		System.out.println("yearMonth : " + yearMonth);
			
		return yearMonth;
	}

	//관리자 - 근무표 db 입력
	@RequestMapping(value = "/holidayRosterDBInsert.ajax")
	public @ResponseBody HashMap<String, String> holidayRosterDBInsert(@RequestParam HashMap<String,Object> eventsMap) {
		System.out.println("---------------------2222222" + eventsMap);
		
		//success 다시 되돌려줄 맵
		HashMap<String, String> map = new HashMap<String, String>();
		Gson gson = new Gson();
		//List<EventsData>로 타입을 만들어주겠다 선언.
		Type type = new TypeToken<List<EventsData>>() {}.getType();

		String result = (String) eventsMap.get("eventsArray");
		
		//지금 string result 속에 jsp에서 넘어온 데이터가 앞뒤로 "가 있어서 이것을 제외해주는 작업 
//		result = result.replaceFirst("\"", "");
//		result = replaceLast(result, "\"", "");
		
		//gson.fromJson : Json 형식으로된 String을 ArrayList로 바꿔주는 역할을 함.
		//지금 result에는 json형식으로 되어있음.
		ArrayList<EventsData> list = gson.fromJson(result, type);

//		for(int i = 0 ; i < list.size() ; i++) {
//			EventsData tmp = (EventsData)list.get(i);
//			System.out.println(tmp.getStart() + "," + tmp.getEnd() + "," + tmp.getId() + "," + tmp.getResource() + "," + tmp.getText());
//		}
		//list를 이제 서비스쪽으로 보냄.
		
		holidaySetService.holidayRosterDBInsert(list);
		
		map.put("success", "true");

		return map;
		
	}
	
	//관리자 - 근속연수에 따른 휴가설정
	@RequestMapping(value = "/conWorkVacSetDBInsert.ajax")
	public @ResponseBody HashMap<String, String> conWorkVacSetDBInsert(@RequestParam HashMap<String,Object> jsonMap) {
		logger.debug("-----------------conWorkVacSetDBInsert 들어왔da."+jsonMap);

		//success 다시 되돌려줄 맵
		HashMap<String, String> map = new HashMap<String, String>();
		Gson gson = new Gson();
		//List<JsonData>로 타입을 만들어주겠다 선언.
		Type type = new TypeToken<List<JsonDataVac>>() {}.getType();

		String result = (String) jsonMap.get("jArray");

		//gson.fromJson : Json 형식으로된 String을 ArrayList로 바꿔주는 역할을 함.
		//지금 result에는 json형식으로 되어있음.
		ArrayList<JsonDataVac> list = gson.fromJson(result, type);

		for(int i = 0 ; i < list.size() ; i++) {
			JsonDataVac tmp = (JsonDataVac)list.get(i);
			System.out.println(tmp.getConworkyear()+" "+tmp.getVacofyear()+" "+tmp.getNote());
		}
		//list를 이제 서비스쪽으로 보냄.
		holidaySetService.conWorkVacSetDBInsert(list);
		
		map.put("success", "true");

		return map;
	}
	/* 관리자 근속연수에 따른 휴가설정 리스트 */
	@RequestMapping(value="/conWorkVacSetuplist.ajax")
	public @ResponseBody HashMap<String, Object> conWorkVacSetUpList(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("++++++++++++++++++++++관리자 근속연수에 따른 휴가설정 리스트 파라미터: " + map);
		
		List<HashMap<String,Object>> list = holidaySetService.conWorkVacSetupList(map);
		
		if(list == null ) {
			map.put("success", "N");
		}else {
			map.put("conWorkVacSetuplist", list);
			
			if(!(map.get("conWorkVacSetuplist").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}
		return map;
	}
	
	//이 함수는 replaceFirst는 있는데 replaceLast라는 함수는 없어서 직접 만들어준 함수. 문장 끝에서부터 내가 원하는 문자열을 찾고 바꿔주는 함수이다.
	private static String replaceLast(String string, String toReplace, String replacement) {    
		int pos = string.lastIndexOf(toReplace);     

		if (pos > -1) {        
		return string.substring(0, pos)+ replacement + string.substring(pos +   toReplace.length(), string.length());     
		} else { 
			return string;     
		} 
	} 
	//휴일정등록
	@RequestMapping(value="calenderUpdate.do")
	public @ResponseBody int calenderUpdate(@RequestParam HashMap<String, String> map) {
		System.out.println("+++++++++++++++++++ 등록 컨트롤러 map : " + map);
		int result = holidaySetService.calenderUpdate(map);
		
		return result;
	}
	//휴일정상세보기
	@RequestMapping(value="calendarList.exc")
	public @ResponseBody List<String> calendarList(){
		System.out.println("일정상세보기(controller)");
		
		List<String> list = holidaySetService.calendarList();
		
		return list;
	}
	//휴일 일정 db 가저오기
	@RequestMapping(value="calendarListDB")
	public @ResponseBody HashMap<String, String> calendarListDB(String start){
		System.out.println("휴일 일정 DB 가져오기 성공 (controller)");
		
		HashMap<String, String> map = holidaySetService.calendarListDB(start);
		
		return map;
	}
	//휴일설정 2번째 탭 리스트 읽어오기
	@RequestMapping(value="SecondTabCalendarTableList")
	public @ResponseBody List<HashMap<String, String>> SecondTabCalendarTableList(@RequestParam HashMap<String, String> yearMap){
		System.out.println("~~~~~~~~~~2nd Tab Calendar Table Listing하기 CONTROLLER");
		List<HashMap<String, String>> map = holidaySetService.SecondTabCalendarTableList(yearMap);
		
//		System.out.println(yearMap);
//		
//		String startEndDay = yearMap.get("startEndDay");
//		String yearEndDay = yearMap.get("yearEndDay");
//		
//		System.out.println(yearEndDay);
		
		return map;
	}
	
}
