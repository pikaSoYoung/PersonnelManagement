package com.example.spring.common.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.example.spring.common.dao.CommonDao;

@Service
public class CommonService {
	
	@Resource(name="commonDao")
	private CommonDao commonDao;
	
	//권한 별 사이드바 list
	public List<HashMap<String,String>> navList(String empEmno){
		
		List<HashMap<String,String>> navList =commonDao.navList(empEmno);
		return navList;
	}//navList
	
	//관리자용 사이드바 list
	public List<HashMap<String,Object>> adminNavList(){
		
		List<HashMap<String,Object>> list= commonDao.adminNavList();
		return list;
	}//adminNavList
	
	//현재페이지 메뉴
	public HashMap<String,Object> selectMenu(HashMap<String,String> map){
		
		HashMap<String,Object> mnPrntNo = commonDao.selectMenu(map);
		return mnPrntNo;
	}//selectMenu
	
	//login 
	public HashMap<String,Object> loginProcess(HashMap<String,Object> map){
		
		HashMap<String,Object> userMap = commonDao.loginProcess(map);
		return userMap;
	}//loginProcess
	
	//권한 list
	public List<HashMap<String,Object>> authorityProcess(HashMap<String,Object> map){
		
		List<HashMap<String,Object>> userAuthList = commonDao.authorityProcess(map);
		return userAuthList;
	}//authorityProcess
	
	//url check
	public HashMap<String,String> urlCheck(String mnUrl){
			
		HashMap<String,String> map = commonDao.urlCheck(mnUrl);
		return map;
	}//urlCheck
	
}//CommonService
