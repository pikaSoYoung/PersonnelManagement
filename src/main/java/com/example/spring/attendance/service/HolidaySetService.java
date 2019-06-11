package com.example.spring.attendance.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.spring.attendance.dao.HolidaySetDao;
import com.example.spring.attendance.entity.JsonData;
import com.example.spring.attendance.entity.JsonDataVac;
import com.example.spring.attendance.entity.DayMinPerson;
import com.example.spring.attendance.entity.DeleteEventsData;
import com.example.spring.attendance.entity.EventsData;


@Service
public class HolidaySetService {

	private static final Logger logger = LoggerFactory.getLogger(HolidaySetService.class);

	@Resource(name="holidaySetDao")
	private HolidaySetDao holidaySetDao;

	public int holidaySetDBInsert(ArrayList<JsonData> jsonArrayList) {
		int result = holidaySetDao.holidaySetDBInsert(jsonArrayList);

		return result;
	}

	public int holidayRosterDelete(ArrayList<DeleteEventsData> deleteEventData) {
		int result = holidaySetDao.holidayRosterDelete(deleteEventData);
		
		return result;
	}
	
	public int holidayRoster(HashMap<String,Object> infoMap) {
		int result = holidaySetDao.holidayRoster(infoMap);
		
		return result;
	}
	
	public List<HashMap<String, String>> rosterTime(@RequestParam HashMap<String,String> standardTime){
		List<HashMap<String,String>> list = holidaySetDao.rosterTime(standardTime);
		
		return list;
	}
	
	public List<HashMap<String,String>> holidayRosterEventsList2(HashMap<String,Object> eventsList){
		List<HashMap<String,String>> list = holidaySetDao.holidayRosterEventsList2(eventsList);
		
		return list;
	}
	
	public List<HashMap<String,String>> holidayRosterEventsList(){
		List<HashMap<String,String>> list = holidaySetDao.holidayRosterEventsList();
		
		return list;
	}
	
	public HashMap<String, String> holidayRosterList(){
		HashMap<String, String> map = new HashMap<String, String>();
		
		map = holidaySetDao.holidayRosterList();
		
		return map;
	}
	
	public int holidayRosterDBInsert(ArrayList<EventsData> eventsArrayList) {
		int result = holidaySetDao.holidayRosterDBInsert(eventsArrayList);
				
		return result;
	}
	
	//년차수에 따른 연차 디비 Insert
	public int conWorkVacSetDBInsert(ArrayList<JsonDataVac>jsonArrayList) {
		int result = holidaySetDao.conWorkVacSetDBInsert(jsonArrayList);
		return result;
	}

	public int holidayRosterSetting(HashMap<String, DayMinPerson> map) {
		int result = holidaySetDao.holidayRosterSetting(map);
		
		return result;
	}
	
	//년차수에 따른 연차 List 불러오기
	public List<HashMap<String,Object>> conWorkVacSetupList(HashMap<String,Object> map) {

		List<HashMap<String,Object>> list = holidaySetDao.conWorkVacSetupList(map);

		logger.debug("service>>> " + list);

		return list;
	}
	//휴일 일정 등록(update) service
	public int calenderUpdate(HashMap<String, String> map) {
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdfToday = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String today = sdfToday.format(cal.getTime());
		String startDate = map.get("startDate").replaceAll("-", ""); //2018-01-24 -> 20180124
		
		System.out.println("+++++++++++++++++++++++++++++++++++++++++++++++++++++++++calendar Update SSService : "+map);		
		
		map.put("startDate", startDate );
		
		//map.put("", value)
		
		int result = holidaySetDao.calenderUpdate(map);
		
		return result;
	}
	//개인일정상세보기
	public List<String> calendarList(){
		
		List<String> list = holidaySetDao.calendarList();
		
		return list;
	}
	//휴일 일정 db 가저오기
	public HashMap<String, String> calendarListDB(String start){
		start = start.replaceAll("\"", "");
		HashMap<String, String> map = holidaySetDao.calendarListDB(start);
		
		return map;
	}
	//휴일설정 2번째 탭 리스트 읽어오기
	public List<HashMap<String, String>> SecondTabCalendarTableList(HashMap<String, String> map){
		
		System.out.println("2번째 탭리스트 서비스 까지 옴 ");
		List<HashMap<String, String>> result = holidaySetDao.SecondTabCalendarTableList(map);
		
		return result;
	}
}
