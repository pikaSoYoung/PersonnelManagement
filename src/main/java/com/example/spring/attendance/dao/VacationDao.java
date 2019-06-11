package com.example.spring.attendance.dao;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

/* 휴가 관련 DAO 
 * 유성실, 신지연 */

@Repository("vacationDao")
public class VacationDao {
	
	private static final Logger logger = LoggerFactory.getLogger(VacationDao.class);
	
	@Autowired
	private SqlSession sqlSession;
	private String nameSpaceName = "vacation.";
	
	/*  휴가일수설정  사원 리스트 출력   */
	public List<HashMap<String,Object>> vacationCountEmpList(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		List<HashMap<String,Object>> list
			= this.sqlSession.selectList(nameSpaceName + "vacationCountEmpList", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	
	/*  휴가일수설정  자동 계산   */
	public List<HashMap<String,Object>> vacationCountAutoCalculation(HashMap<String,Object> map) {

		List<HashMap<String,Object>> list = new ArrayList<HashMap<String,Object>>();
		
		Calendar cal = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMM");
		
		int cowyCnt = 0; //근속연수((오늘-입사일자)/365)
		int empIncoYearMonth = 0; //입사년월
		int nowYear, nowMonth, empIncoYear, empIncoMonth = 0; //현재년, 현재월, 입사년, 입사월
		int monthSize = 0; //현재월 -입사월
		int cowyMonthCnt = 0; //개근 월 개수(한달단위로 for문 돌림)
		int vacCnt = 0; //휴가개수
		int beforeYearPvacUd = 0; //전년도 휴가 사용 개수
		int cowyUpdate = 0; //근속연수 +1 업데이트
		int cowyYn = 0; //전년도 근속일수가 80% 넘는지
		
		String s1 = (String) map.get("empEmnoResult");
		String[] words = s1.split("/");
		
		for(String empEmno : words) {
			vacCnt = 0;
			logger.info("empEmno: " + empEmno);
			map.put("empEmno", empEmno);
			
			cowyCnt = this.sqlSession.selectOne(nameSpaceName + "cowyCnt", empEmno);
			cowyYn = this.sqlSession.selectOne(nameSpaceName + "cowyYn", empEmno);
			empIncoYearMonth = this.sqlSession.selectOne(nameSpaceName + "empIncoYearMonth", empEmno);
			nowYear = Integer.parseInt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("YYYY")));
			nowMonth = Integer.parseInt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("MM")));
			empIncoYear = Integer.parseInt(String.valueOf(empIncoYearMonth).substring(0,4));
			empIncoMonth = Integer.parseInt(String.valueOf(empIncoYearMonth).substring(4,6));

			monthSize = (nowYear - empIncoYear)* 12 + (nowMonth - empIncoMonth);

			//휴가일수 자동 계산 로직
			if(cowyCnt == 0){ //1년 미만
				for(int i=0; i<=monthSize; i++) {
					map.put("cowyMonthCnt", empIncoYearMonth);
					cowyMonthCnt = this.sqlSession.selectOne(nameSpaceName + "cowyMonthCnt", map);
					
					if(cowyMonthCnt == 1) { //1개월 개근했으면                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
						vacCnt++; //휴가개수+1
//						logger.info("휴가개수+1 돼씅ㅁ!!!!"+empIncoYearMonth);
					}
					
//					logger.info("테스트"+String.valueOf(empIncoYearMonth).substring(4, 6));
					
					if(Integer.parseInt(String.valueOf(empIncoYearMonth).substring(4, 6)) < 12) { //1월~11월
						empIncoYearMonth++; //월+1(다음월)
					}else if(Integer.parseInt(String.valueOf(empIncoYearMonth).substring(4, 6)) == 12) { //12월
						int year = Integer.parseInt(String.valueOf(empIncoYearMonth).substring(0, 4))+1; //1년 증가
						
						empIncoYearMonth = Integer.parseInt(String.valueOf(year)+"01"); //1년증가된 년에 1월로 세팅
//					    logger.info("제발 "+empIncoYearMonth);
					}
				}
//				logger.info(">>>1년 미만<<< 휴가:"+vacCnt);
//				일사월부터 1개월 개근시 연차 1일 생성
//				입사일자 월부터 현재월까지 정상근무 월과 비교
//				근태공통코드 W7(결근)이 아닌 날만 한달치 개수 비교
//				개수가 똑같거나 큰 날만큼 연차 생성

			}else if(cowyCnt == 1){ //1년
				if(cowyYn == 0){ //전년도 80% 미만 출근(정상근무 개수 80% 미만)
					empIncoYearMonth = Integer.parseInt(LocalDateTime.now().minusYears(1).format(DateTimeFormatter.ofPattern("YYYY"))+"01"); //작년 1월
					for(int i=1; i<=12; i++) {
						map.put("cowyMonthCnt", empIncoYearMonth);
						cowyMonthCnt = this.sqlSession.selectOne(nameSpaceName + "cowyMonthCnt", map);
						
						if(cowyMonthCnt == 1) { //1개월 개근했으면
							vacCnt++; //1월부터 1개월 개근시 연차 1일 생성
						}
						empIncoYearMonth++; //월+1(다음월)
					}
//					logger.info(">>>1년 80% 미만<<< 휴가:"+vacCnt);
				}else{ //전년도 80% 이상 출근
					map.put("cowyCnt", cowyCnt);
					cowyUpdate = this.sqlSession.update(nameSpaceName + "empIncoYearMonth", map); //근속연수 +1

					beforeYearPvacUd = this.sqlSession.selectOne(nameSpaceName + "beforeYearPvacUd", empEmno);
					if(beforeYearPvacUd == 0){ //전년도 휴가 사용 일수가 0이면
						vacCnt = 15;
					}else{ //전년도 휴가 사용 일수가 있으면
						vacCnt = 15 - beforeYearPvacUd; //15일-전년도 휴가 사용일
					}
//					logger.info(">>>1년<<< 휴가:"+vacCnt);
				}
			}else{ //2년 이상
				if(cowyYn == 0){ //전년도 80% 미만 출근
					empIncoYearMonth = Integer.parseInt(LocalDateTime.now().minusYears(1).format(DateTimeFormatter.ofPattern("YYYY"))+"01"); //작년 1월
					logger.info("empIncoYearMonth: "+empIncoYearMonth);
					for(int i=1; i<=12; i++) {
						map.put("cowyMonthCnt", empIncoYearMonth);
						cowyMonthCnt = this.sqlSession.selectOne(nameSpaceName + "cowyMonthCnt", map);
//						logger.info("cowyMonthCnt: "+cowyMonthCnt);
						if(cowyMonthCnt == 1) { //1개월 개근했으면
							vacCnt++; //1월부터 1개월 개근시 연차 1일 생성
						}
						empIncoYearMonth++; //월+1(다음월)
					}
//					logger.info(">>>2년 이상 80% 미만<<< 휴가:"+vacCnt);
				}else{ //전년도 80% 이상 출근
					map.put("cowyCnt", cowyCnt);
					cowyUpdate = this.sqlSession.update(nameSpaceName + "cowyUpdate", map); //근속연수 +1
					
					vacCnt = this.sqlSession.selectOne(nameSpaceName + "cowyVacDays", empEmno); //근속연수 연차개수
				}
			}
			//로직 끝
			
			HashMap<String,Object> calMap = new HashMap<String,Object>();
			calMap.put("empEmno", empEmno); //사원번호
			calMap.put("vacCnt", vacCnt); //연차개수
			list.add(calMap); //사원별로 연차개수 리스트에 담기
		}
		
		return list;
	}
	
	//휴가일수설정 휴가일수 저장하기
	public int vacationCountUpdate(HashMap<String,Object> map) {
		logger.debug("dao >>> "+map);
		
		int list = 0;
		
		String s1 = (String) map.get("empEmnoResult");
		String[] words = s1.split("/");
		
		for(String empEmno : words) {
			logger.info("empEmno: " + empEmno.substring(0, empEmno.indexOf("^")));
			map.put("empEmno", empEmno.substring(0, empEmno.indexOf("^")));
			map.put("vacCnt", empEmno.substring(empEmno.indexOf("^")+1));
//			logger.info("test"+map.get("vacCnt"));
			
			this.sqlSession.insert(nameSpaceName + "vacationCountUpdate", map);
			list++;
		}

		logger.debug("dao List: "+list);
		
		return 0;
	}
	
	/* 휴가일수설정 - 사원등록 필요 개수 */
	public int vacationCountEmpSignUpCntNum() {	
		
		int empSignUpCntNum = this.sqlSession.selectOne(nameSpaceName + "vacationCountEmpSignUpCntNum");
				logger.info("dao List: " + empSignUpCntNum);	

		return empSignUpCntNum;
	}
	
	/*  휴가일수설정  사원등록 리스트 출력   */
	public List<HashMap<String,Object>> vacationCountEmpSignUpList(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		List<HashMap<String,Object>> list
			= this.sqlSession.selectList(nameSpaceName + "vacationCountEmpSignUpList", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	
	//휴가일수설정 - 사원등록 저장하기
	public int vacCntEmpSignUpInsert(HashMap<String,Object> map) {
		logger.debug("dao >>> "+map);
		
		int list = 0;
		
		String s1 = (String) map.get("empEmnoResult");
		String[] words = s1.split("/");
		
		for(String empEmno : words) {
			logger.info("empEmno: " + empEmno);
			this.sqlSession.insert(nameSpaceName + "vacCntEmpSignUpInsert", empEmno);
			list++;
		}

		logger.debug("dao List: "+list);
		
		return list;
	}
	
	/* 관리자 or 사원 어떤 버전으로 로그인 했는지 체크(권한부여 때문) */
	public int adminChk(HashMap<String,Object> map) {
		int adminChk = this.sqlSession.selectOne(nameSpaceName + "adminChk", map);
		logger.info("dao ADMIN CHK::"+adminChk);
		return adminChk;
	}
	
	
	/*  휴가일수설정에 등록된 사원인지 체크   */
	public int empVacChk(HashMap<String,Object> map) {
		
		int empVacChk = this.sqlSession.selectOne(nameSpaceName + "empVacChk", map);
		
		logger.debug("dao List: "+empVacChk);
		
		return empVacChk;
	}
	
	/* 휴가신청: 사원일 경우 사원 정보 나타내기 */
	public List<HashMap<String,Object>> empVacInfomation(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "empVacInfomation", map);
		logger.info("휴가신청하기 사원정보 Dao::"+list);
		return list;
	}
	
	/* 휴가 신청하기 - 휴가명 셀렉 */
	public List<HashMap<String,Object>> vacationTypeList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "vacationTypeList", map);
		return list;
	}
	
	/* 휴가 신청하기 */
	public int vacationRequest(HashMap<String,String> map) {
		logger.info("vacationREQ DAO 진입>>>>" + map);
		
		int list = this.sqlSession.insert(nameSpaceName + "vacationRequest", map); 
			logger.info("vacationREQ DAO LIST>> " + list);
		return list;
	}//휴가 신청하기

	
	/* 휴가조회(사원)-사원별 휴가 개수  */
	public List<HashMap<String,Object>> vacationListEmpRemindingVac(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		List<HashMap<String,Object>> list
			= this.sqlSession.selectList(nameSpaceName + "vacationListEmpRemindingVac", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
		
	/* 휴가조회(사원)- 휴가내역 상세보기 모달  */
	public List<HashMap<String,Object>> empVacListDetail(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		List<HashMap<String,Object>> list
			= this.sqlSession.selectList(nameSpaceName + "empVacListDetail", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	
	/* 휴가조회(사원)- 휴가내역 수정  */
	public int vacationListUpdate(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		int list = this.sqlSession.update(nameSpaceName + "vacationListUpdate", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	
	/* 휴가조회(사원)- 휴가내역 삭제  */
	public int vacationListDelete(HashMap<String,Object> map) {
//		logger.debug("dao >>> "+map);
		
		int list = this.sqlSession.update(nameSpaceName + "vacationListDelete", map);
		
		logger.debug("dao List: "+list);
		
		return list;
	}
	
	
	/* 휴가 조회 -관리자 휴가현황 리스트 총 개수  */
//	public int vacListMaxNum(HashMap<String,Object> map) {
//		logger.info("총 개수 DAO___"+map);
//		int list = (Integer)this.sqlSession.selectOne(nameSpaceName+"vacListMaxNum",map);
//		logger.info("총 개수 DAO list---------------"+list);
//		return list;
//	}
	
	
	/* 휴가 조회하기 - 관리자 */
	public List<HashMap<String,Object>> vacationListAdmin(HashMap<String,Object> map) {
		logger.info("휴가조회 관리자 DAO>>>>" + map);
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "vacationListAdmin", map);

		logger.info("휴가조회 관리자 DAO list>><<<<" + list);
		return list;
	}
	
	/* 휴가 조회 - 퇴직 여부 셀렉박스 */
	public List<HashMap<String,Object>> retTypeList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "retTypeList", map);
		return list;
	}
	/* 휴가 조회 - 부서 리스트 셀렉박스 */
	public List<HashMap<String,Object>> deptNameList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "deptNameList", map);
		return list;
	}
	/* 휴가 조회 - 직급 리스트 셀렉박스 */
	public List<HashMap<String,Object>> rankNameList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "rankNameList", map);
		return list;
	}
	
	
	/* 휴가조회-관리자 : 모달 - 상단 사원 정보 */
	public List<HashMap<String,Object>> empInfo(HashMap<String,Object> map){
		logger.info("휴가조회관리자 모달 사원 정보 DAO::::"+map);
		
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "empInfo", map);
		//logger.info("휴가조회관리자 모달 사원 정보아아아ㅏ아 DAO::::"+list);
		
		return list;
	}
	
	/* 휴가조회-관리자 : 모달 - 휴가 사용 정보 */
	public List<HashMap<String,Object>> empVacList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "empVacList", map);
		logger.info("휴가관리자 모달 사원!!!!!!!!~~!" + list);
		return list;
	}
	
	/* 휴가조회-관리자 : 모달 - 하단 휴가 개수 */
	public List<HashMap<String,Object>> empVacNum(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "empVacNum", map);
		return list;
	}
	
	
	/* 휴가 신청현황 - 승인대기 개수 */
	public int vacationProgCntNum() {	
		logger.info("vacation 휴가승인 개수 DAO///////");
		
		int countNum = this.sqlSession.selectOne(nameSpaceName + "vacationProgCntNum");
				logger.info("vacationProg 휴가승인대기 개수 dao>>>> " + countNum);	

		return countNum;
	}
	
	
	/* 휴가 신청현황 - 승인대기현황 셀렉박스 */
	public List<HashMap<String,Object>> situationList(HashMap<String,Object> map){
		List<HashMap<String,Object>> list = this.sqlSession.selectList(nameSpaceName + "situationList", map);
		return list;
	}
	
	/* 휴가 신청현황 리스트 */
	public List<HashMap<String, Object>> vacationProgressList(HashMap<String,Object> map) {
		logger.info("vacation 휴가승인 리스트 DAO///////");
		
		List<HashMap<String, Object>> list = this.sqlSession.selectList(nameSpaceName + "vacationProgressList", map);
			logger.info("휴가신청현황리스트 dao----" + list);
		return list;
	}
	
	
	/* 휴가 승인완료 저장 */
	public int vacationProgressSave(HashMap<String,Object> map){
		logger.info("휴간신청 승인대기 DAO 진입 --->>>>");
		
		int list = 0;
		
		String num = (String) map.get("progToggleResult");
		String[] obj = num.split("/");
		
		//휴가 승인완료된 사람들의 일련번호들
		for(String vastSerialNumber : obj) {
			logger.info("jjjjjjnum:::"+num);
			
			logger.info("jjjjjjjjjjjjjj"+vastSerialNumber);
			logger.info("01 ::" + vastSerialNumber.substring(0,vastSerialNumber.indexOf("^")));//31
			logger.info("02::" + vastSerialNumber.substring(vastSerialNumber.indexOf("^")+1,vastSerialNumber.indexOf("#")));	
			logger.info("03::" + vastSerialNumber.substring(vastSerialNumber.indexOf("#")+1, vastSerialNumber.lastIndexOf("^")));
			logger.info("04::"+vastSerialNumber.substring(vastSerialNumber.lastIndexOf("^")+1));//0.5
		
			//시리얼넘버, 승인현황, 휴가사용일수 담아오기
			map.put("vastSerialNumber", vastSerialNumber.substring(0,vastSerialNumber.indexOf("^")));
			map.put("vastC", vastSerialNumber.substring(vastSerialNumber.indexOf("^")+1,vastSerialNumber.indexOf("#")));
			map.put("vastProgressSituation", vastSerialNumber.substring(vastSerialNumber.indexOf("#")+1, vastSerialNumber.lastIndexOf("^")));
			map.put("vastVacUd", vastSerialNumber.substring(vastSerialNumber.lastIndexOf("^")+1));
			logger.info("test:::"+map.get("vastProgressSituation"));
			this.sqlSession.update(nameSpaceName + "vacationProgToggle", map);
			this.sqlSession.update(nameSpaceName + "vacationUdCnt", map);
			
			list++;
		}//for-split'/'
			logger.info("승인대기 DAO list::" + list);
		return list;
	}

	/* 휴가 승인대기 삭제 */
	public int vacationDelete(HashMap<String,Object> map) {
		logger.info("휴가 삭제 DAO------------"+map);
		int list = 0;
		
		String del = (String) map.get("progToggleResult");
		if(list == 0) {
			list = this.sqlSession.update(nameSpaceName + "vacationDelete", map);
		}
		
		logger.info("휴가승인대기 삭제 DAO LIST==="+list);
		return list;
	}
	
	
	

	/* 휴가 개수 계산하기 */
	public String vacationCount() {
		return "";
	}
	
	
	/* 휴가 월마감 */
	public String vacationMonthlyReport() {
		return "";
	}
	
	
} //main
