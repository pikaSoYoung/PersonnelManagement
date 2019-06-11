package com.example.spring.common.controller;

import java.util.HashMap;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.spring.common.service.DashboardService;

@Controller
public class DashboardController {
	
	private static final Logger logger = LoggerFactory.getLogger(DashboardController.class);

	@Autowired
	private DashboardService dashboardService;
	
	/* 메인 대시보드 */	
//	@RequestMapping(value="main.do")
//	public String main() {		
//		return "main";
//	}
	
	/* 대시보드 - 사원정보 */
	@RequestMapping(value="/empUserInfo.exc")
	public @ResponseBody HashMap<String, Object> empUserInfo(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("파라미터다!!!!"+map);
		
		List<HashMap<String,Object>> empUserInfo = dashboardService.empUserInfo(map); //사원정보
		
		map.put("empUserInfo", empUserInfo);
			
		if(!(map.get("empUserInfo").toString()).equals("[]")) {
			map.put("success", "Y");
		}else {
			map.put("success", "N");
		}
		
		return map;
	}
	
	/* 대시보드 - 사원휴가정보 */
	@RequestMapping(value="/empVacInfo.exc")
	public @ResponseBody HashMap<String, Object> empVacInfo(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("파라미터다!!!!"+map);
		
		List<HashMap<String,Object>> empVacInfo = dashboardService.empVacInfo(map); //사원휴가정보
		
		map.put("empVacInfo", empVacInfo);
			
		if(!(map.get("empVacInfo").toString()).equals("[]")) {
			map.put("success", "Y");
		}else {
			map.put("success", "N");
		}
		
		return map;
	}
	
	/* 대시보드 - 부서 일정 */
	@RequestMapping(value="/scheduleList.exc")
	public @ResponseBody HashMap<String, Object> scheduleList(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("파라미터다!!!!"+map);
		
		List<HashMap<String,Object>> list = dashboardService.scheduleList(map);
		
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("scheduleList", list);
			
			if(!(map.get("scheduleList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 대시보드 - 월별 휴가사용개수 그래프 */
	@RequestMapping(value="/monthlyVacChart.exc")
	public @ResponseBody HashMap<String, Object> monthlyVacChart(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("파라미터다!!!!"+map);
		
		List<HashMap<String,Object>> list = dashboardService.monthlyVacChart(map);
		
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("monthlyVacChart", list);
			
			if(!(map.get("monthlyVacChart").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 대시보드 - 오늘의 휴가자 */
	@RequestMapping(value="/vacTodayEmpList.exc")
	public @ResponseBody HashMap<String, Object> vacTodayEmpList() {
		
		List<HashMap<String,Object>> list = dashboardService.vacTodayEmpList();
		
		HashMap<String,Object> map = new HashMap<String,Object>();
		
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("vacTodayEmpList", list);
			
			if(!(map.get("vacTodayEmpList").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
	
	/* 대시보드 - 내가 이번달에 사용한 항목별 휴가 */
	@RequestMapping(value="/thisMonthVacChart.exc")
	public @ResponseBody HashMap<String, Object> thisMonthVacChart(
			@RequestParam HashMap<String,Object> map) {
		
		logger.info("파라미터다!!!!"+map);
		
		List<HashMap<String,Object>> list = dashboardService.thisMonthVacChart(map);
		
		if(list == null) {
			map.put("success", "N");
		}else {
			map.put("thisMonthVacChart", list);
			
			if(!(map.get("thisMonthVacChart").toString()).equals("[]")) {
				map.put("success", "Y");
			}else {
				map.put("success", "N");
			}
		}

		return map;
	}
}
