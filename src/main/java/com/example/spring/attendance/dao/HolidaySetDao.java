package com.example.spring.attendance.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

import com.example.spring.attendance.entity.DayMinPerson;
import com.example.spring.attendance.entity.DeleteEventsData;
import com.example.spring.attendance.entity.EventsData;
import com.example.spring.attendance.entity.JsonData;
import com.example.spring.attendance.entity.JsonDataVac;


@Repository("holidaySetDao")
public class HolidaySetDao {

	private static final Logger logger = LoggerFactory.getLogger(HolidaySetDao.class);

	@Autowired
	private SqlSession sqlSession;
	private String nameSpaceName = "holidaySet.";
	public int holidaySetDBInsert(ArrayList<JsonData> jsonArrayList) {
		//int result = this.sqlSession.insert(nameSpaceName + "holidaySetDBInsert", jsonArrayList);
				
		//return result;
		int result = -1;

		for(int i = 0 ; i < jsonArrayList.size(); i++) {
			JsonData tmp = (JsonData)jsonArrayList.get(i);

			result = this.sqlSession.insert(nameSpaceName + "holidaySetDBInsert", tmp);
		}

		return result;
	}
	
	public int holidayRoster(HashMap<String,Object> infoMap) {
		int result = -1;
		
		result = this.sqlSession.insert(nameSpaceName + "holidayRoster", infoMap);
		
		return result;
	}
	
	public int holidayRosterDelete(ArrayList<DeleteEventsData> deleteEventData) {
		int result = -1;
		
		for(int i = 0 ; i < deleteEventData.size() ; i++) {
			DeleteEventsData tmp = (DeleteEventsData)deleteEventData.get(i);
			
			result = this.sqlSession.delete(nameSpaceName + "holidayRosterDelete", tmp);
		}
		
		return result;
	}
	
	public HashMap<String, String> holidayRosterList(){
		HashMap<String, String> map = new HashMap<String, String>();
		
		map = this.sqlSession.selectOne(nameSpaceName + "holidayRosterList");
		
		return map;
		
	}
	
	public List<HashMap<String,String>> rosterTime(@RequestParam HashMap<String,String> standardTime){
		List<HashMap<String,String>> list = this.sqlSession.selectList(nameSpaceName + "rosterTime", standardTime);
		
		return list;
	}
	
	public List<HashMap<String,String>> holidayRosterEventsList2(HashMap<String,Object> eventsList){
		List<HashMap<String,String>> list = this.sqlSession.selectList(nameSpaceName + "holidayRosterEventsList2", eventsList);
		
		return list;
	}
	
	public List<HashMap<String,String>> holidayRosterEventsList(){
		List<HashMap<String,String>> list = this.sqlSession.selectList(nameSpaceName + "holidayRosterEventsList");
		
		return list;
	}
	
	public int holidayRosterDBInsert(ArrayList<EventsData> eventsArrayList) {
		int result = -1;
		
		for(int i = 0 ; i < eventsArrayList.size() ; i++) {
			EventsData tmp = (EventsData)eventsArrayList.get(i);
			
			result = this.sqlSession.insert(nameSpaceName + "holidayRosterDBInsert", tmp);
		}
		
		return result;
	}
	
	public int holidayRosterSetting(HashMap<String, DayMinPerson> map) {
		int result = -1;
		
		for(String mapKey : map.keySet()) {
			DayMinPerson tmp = (DayMinPerson)map.get(mapKey);
			
			result = this.sqlSession.insert(nameSpaceName + "holidayRosterSetting", tmp);
		}
		
		return result;
	}
	
	//2018.01.30 주용하 - 근속년수에따른 휴가설정 디비 insert
	public int conWorkVacSetDBInsert(ArrayList<JsonDataVac> jsonArrayList) {

		int result = -1;

		for(int i = 0 ; i < jsonArrayList.size(); i++) {
			JsonDataVac tmp = (JsonDataVac)jsonArrayList.get(i);

			result = this.sqlSession.insert(nameSpaceName + "conWorkVacSetDBInsert", tmp);
		}

		return result;
	}
	//2018.01.31 주용하
	//근속년수에따른 휴가설정 조회
	public List<HashMap<String,Object>> conWorkVacSetupList(HashMap<String,Object> map) {
		
		List<HashMap<String,Object>> list
			= this.sqlSession.selectList(nameSpaceName + "conWorkVacSetupList", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	//휴일 일정등록 dao
	public int calenderUpdate(HashMap<String, String> map) {
		
		int result = 0;
		
		System.out.println("=========================   DAO  ==================================== mmmmmap   : "+map);
		result = this.sqlSession.update(nameSpaceName+"calenderUpdate",map);
		System.out.println("==============================================result===================="+result);
		return result;
	}
	//휴일 일정 리스트 dao
	public List<String> calendarList(){
		
		List<String> list = this.sqlSession.selectList(nameSpaceName+"calendarList");
		System.out.println("List DAO ========================"+list);
		return list;
	}
	//db에서 휴일 정보 읽어오기
	public HashMap<String, String> calendarListDB(String start){
		
		HashMap<String, String> map = this.sqlSession.selectOne(nameSpaceName+"calendarListDB",start);
		System.out.println("ListDB DAO ================ㅇㅁㄹㅇㄴ========"+map);
		return map;
	}
	//휴일설정 2번째 탭 리스트 읽어오기
	public List<HashMap<String, String>> SecondTabCalendarTableList(HashMap<String, String> map){
		
		List<HashMap<String, String>> result = this.sqlSession.selectList(nameSpaceName+"SecondTabCalendarTableList", map);
		System.out.println("SecondTabCalendarTableList DAO ======================== "+map);
		return result;
	}
}
