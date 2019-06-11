package com.example.spring.attendance.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AttendDao {
	
	private static final Logger logger = LoggerFactory.getLogger(AttendDao.class);

	@Autowired
	private SqlSession sqlSession;
	
	private String nameSpaceName = "attend.";
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [일일근태등록]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.06
	 ***************************************************************************************/
	/**
	 * 츨근 정보 입력 함수  Insert
	 * @param params
	 */
	public void insertDailAttReg(HashMap<String, String> params) {
		// TODO Auto-generated method stub
		sqlSession.insert(nameSpaceName +"insertDailAttReg", params);
	}
	
	/**
	 * 출근 / 퇴근 / 검색 버튼 출력 조회 Select
	 * @param params
	 * @return
	 */
	public List<HashMap<String, Object>> selectInDailAttReg (HashMap<String, String> params) {
		
		List<HashMap<String, Object>> resultList
			=this.sqlSession.selectList(nameSpaceName +"selectInDailAttReg", params);
		
		return resultList;
	}
	
	/**
	 * 퇴근 정보 입력 함수 Update  
	 * @param params
	 * @return 
	 */
	public void updateDailAttReg(HashMap<String, String> params) {
		sqlSession.update(nameSpaceName + "updateDailAttReg", params);
	}	
	
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월간 근태 생성/마감]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.??
	 ***************************************************************************************/
	
	public int readMnthngAttdCrtClsCnt(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return ((Integer)this.sqlSession.selectOne(nameSpaceName + "readMnthngAttdCrtClsCnt", paramMap));
	}
	
	public List<HashMap<String, Object>> readMnthngAttdCrtCls(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultList 
			= this.sqlSession.selectList(nameSpaceName + "readMnthngAttdCrtCls", paramMap);
		
		return resultList;
	}
	
	public HashMap<String, Object> readMnthngAttdCrtClsStts(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		HashMap<String, Object> resultList 
			= this.sqlSession.selectOne(nameSpaceName + "readMnthngAttdCrtClsStts", paramMap);
	
		return resultList;
	}
	
	public int insertMnthngAttdCrtCls(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpaceName +"insertMnthngAttdCrtCls", paramMap);
	}
	
	public int insertAllMnthngAttdCrtCls(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return sqlSession.insert(nameSpaceName +"insertAllMnthngAttdCrtCls", paramMap);
	}
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [월근태현황]
	 * 개요    : 
	 * @Author : 이용선
	 * @Date   : 2018.02.08
	 ***************************************************************************************/

	public List<HashMap<String, Object>> mAttdSelectEmpList(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultList 
			= this.sqlSession.selectList(nameSpaceName + "mAttdSelectEmpList", map);
		
		return resultList;
	}
	
	public List<HashMap<String, Object>> searchMnthAttdStat(HashMap<String, String> paramMap) {
		// TODO Auto-generated method stub
		List<HashMap<String, Object>> resultList 
			= this.sqlSession.selectList(nameSpaceName + "searchMnthAttdStat", paramMap);
		return resultList;
	}
	
	
	
	
	
	
	
	
	/***************************************************************************************
	 * 메뉴명 : [출결관리] - [휴일 /연장 /야간근무 조회]
	 * 개요    : 
	 * @Author : 제영호
	 * @Date   : 2018.01.??
	 ***************************************************************************************/
	
	public int readHdayExtnNightWorkInqrCnt(HashMap<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return ((Integer)this.sqlSession.selectOne(nameSpaceName + "readHdayExtnNightWorkInqrCnt", paramMap));
	}
	
	public List<HashMap<String, Object>> readHdayExtnNightWorkInqr(HashMap<String, Object> paramMap) {
		
		List<HashMap<String, Object>> resultList
			= this.sqlSession.selectList(nameSpaceName + "readHdayExtnNightWorkInqr", paramMap);
		
		return resultList;
	}

	public HashMap employee_extended_work_deadline(HashMap<String, Object> map) {
		
		this.sqlSession.update(nameSpaceName+"acalUpdate", map);
		return map;
	}
	
	


}
